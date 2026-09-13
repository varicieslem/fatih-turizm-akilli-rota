import warnings
warnings.filterwarnings('ignore')

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import mysql.connector
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# FastAPI Uygulamasını Başlat
app = FastAPI(title="Fatih Turizm Akıllı Rota API")

# --- YENİ EKLENEN KISIM: CORS GÜVENLİK İZİNLERİ ---
# PHP'nin (localhost) Python'a erişmesine izin veriyoruz
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Her yerden gelen isteğe izin ver
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '', 
    'database': 'fatih_turizm_db'
}

class KullaniciIstegi(BaseModel):
    tercihler: list[str]

@app.post("/api/rota")
def akilli_rota_olustur(istek: KullaniciIstegi):
    try:
        conn = mysql.connector.connect(**db_config)
        query = """
        SELECT m.id, m.isim, m.aciklama, m.enlem, m.boylam, m.maksimum_kapasite,
               y.guncel_kisi_sayisi, GROUP_CONCAT(k.kategori_adi SEPARATOR ' ') as etiketler
        FROM Mekanlar m
        LEFT JOIN Anlik_Yogunluk y ON m.id = y.mekan_id
        LEFT JOIN Mekan_Kategorileri mk ON m.id = mk.mekan_id
        LEFT JOIN Kategoriler k ON mk.kategori_id = k.id
        GROUP BY m.id
        """
        
        df = pd.read_sql(query, conn)
        df['doluluk_yuzdesi'] = (df['guncel_kisi_sayisi'] / df['maksimum_kapasite']) * 100
        
        kullanici_metin = " ".join(istek.tercihler)
        tum_metinler = df['etiketler'].fillna('').tolist()
        tum_metinler.append(kullanici_metin)
        
        vectorizer = CountVectorizer()
        vektorler = vectorizer.fit_transform(tum_metinler)
        
        benzerlik_skorlari = cosine_similarity(vektorler[-1:], vektorler[:-1])[0]
        df['uyum_skoru'] = benzerlik_skorlari * 100
        
        def ceza_hesapla(row):
            skor = row['uyum_skoru']
            yogunluk = row['doluluk_yuzdesi']
            if yogunluk > 85: return skor * 0.4
            elif yogunluk > 70: return skor * 0.7
            else: return skor * 1.0
                
        df['final_skor'] = df.apply(ceza_hesapla, axis=1)
        
        df = df[df['uyum_skoru'] > 0]
        oneri_listesi = df.sort_values(by='final_skor', ascending=False).head(3)
        
        orijinal_en_iyiler = df.sort_values(by='uyum_skoru', ascending=False).head(2)
        kalabalik_var_mi = orijinal_en_iyiler['doluluk_yuzdesi'].max() > 70
        
        if kalabalik_var_mi:
            mesaj = "Ana rotalar şu an oldukça kalabalık. Sizin için sıra beklemeyeceğiniz, ilgi alanlarınıza uyan alternatif harika rotalar hazırladık!"
        else:
            mesaj = "Harika bir zamanlama! Seçtiğimiz rotalar şu an oldukça sakin, rahatça gezebilirsiniz."
        
        mekanlar_json = oneri_listesi[['isim', 'aciklama', 'enlem', 'boylam', 'uyum_skoru', 'doluluk_yuzdesi']].to_dict(orient='records')
        
        return {
            "bilgilendirme_mesaji": mesaj,
            "onerilen_mekanlar": mekanlar_json
        }

    except Exception as e:
        return {"hata": str(e)}
    finally:
        if 'conn' in locals() and conn.is_connected():
            conn.close()