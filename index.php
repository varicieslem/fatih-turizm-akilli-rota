<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fatih Turizm Akıllı Rota</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; display: flex; }
        #sol-panel { width: 350px; padding: 20px; background-color: #f8f9fa; height: 100vh; overflow-y: auto; box-shadow: 2px 0 5px rgba(0,0,0,0.1); z-index: 1000; }
        #harita { flex-grow: 1; height: 100vh; }
        h2 { color: #2c3e50; font-size: 22px; }
        .kategori-kutusu { margin-bottom: 10px; }
        button { width: 100%; padding: 12px; background-color: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-top: 15px; }
        button:hover { background-color: #2980b9; }
        #mesaj-kutusu { margin-top: 20px; padding: 15px; border-radius: 5px; display: none; font-size: 14px; line-height: 1.5; }
        .basarili { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .uyari { background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
    </style>
</head>
<body>
    <div id="sol-panel">
        <h2>Rota Tercihlerinizi Seçin</h2>
        <p style="color: #7f8c8d; font-size: 14px;">Akıllı algoritmamız, anlık yoğunluğa göre size en uygun rotayı çizecektir.</p>
        <form id="rota-formu">
            <div class="kategori-kutusu"><input type="checkbox" value="Tarihi"> Tarihi Mekanlar</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Müze"> Müzeler</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Doğa/Manzara"> Doğa ve Manzara</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Yeme-İçme"> Yeme-İçme</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Ücretsiz"> Ücretsiz Mekanlar</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Dini"> Dini Yapılar</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Fotoğraf/Sokak"> Fotoğraf ve Sokaklar</div>
            <div class="kategori-kutusu"><input type="checkbox" value="Alışveriş"> Alışveriş</div>
            <button type="submit">Akıllı Rota Oluştur</button>
        </form>
        <div id="mesaj-kutusu"></div>
        <div id="sonuclar" style="margin-top: 20px;"></div>
    </div>
    <div id="harita"></div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
       // 1. Fatih'in görünmez duvarlarını (Sınır Kutusu) tanımlıyoruz
    var fatihSinirlari = [
        [40.988, 28.913], // Güneybatı Köşesi
        [41.030, 28.986]  // Kuzeydoğu Köşesi
    ];

    // 2. Haritayı bu sınırlara göre ve daha yakından (zoom: 15) başlatıyoruz
    var map = L.map('harita', {
        center: [41.015, 28.965],
        zoom: 15,          // Başlangıç yakınlığı (eskiden 14'tü, şimdi daha detaylı)
        minZoom: 14,       // Kullanıcının fareyle çok uzaklaşıp İstanbul'u görmesini engeller
        maxBounds: fatihSinirlari, // Haritayı Fatih dışına kaydırmayı yasaklar
        maxBoundsViscosity: 1.0    // Duvara çarpma efekti (Kullanıcı haritayı dışarı çekemez)
    });

    // 3. Harita Çizimleri (OpenStreetMap)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors',
        maxZoom: 19
    }).addTo(map);

        var isaretciler = L.layerGroup().addTo(map);

        document.getElementById('rota-formu').addEventListener('submit', function(e) {
            e.preventDefault(); 
            var secilenKategoriler = [];
            document.querySelectorAll('input[type="checkbox"]:checked').forEach(kutu => secilenKategoriler.push(kutu.value));

            if(secilenKategoriler.length === 0) return alert("Lütfen en az bir kategori seçin.");

            fetch('http://localhost:8000/api/rota', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ tercihler: secilenKategoriler })
            })
            .then(response => response.json())
            .then(data => {
                isaretciler.clearLayers();
                
                var mesajKutusu = document.getElementById('mesaj-kutusu');
                mesajKutusu.style.display = 'block';
                mesajKutusu.innerHTML = data.bilgilendirme_mesaji;
                mesajKutusu.className = data.bilgilendirme_mesaji.includes("kalabalık") ? "uyari" : "basarili";

                var sonuclarDiv = document.getElementById('sonuclar');
                sonuclarDiv.innerHTML = "<h3>Önerilen Rota</h3>";

                data.onerilen_mekanlar.forEach(mekan => {
                    var pin = L.marker([mekan.enlem, mekan.boylam]).addTo(isaretciler);
                    pin.bindPopup(`<b>${mekan.isim}</b><br>Doluluk: %${mekan.doluluk_yuzdesi.toFixed(1)}`);
                    
                    sonuclarDiv.innerHTML += `
                        <div style="background: white; padding: 10px; margin-bottom: 10px; border-left: 4px solid #3498db; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                            <strong>${mekan.isim}</strong>
                            <small style="display:block; margin-top:5px;">Uyum: %${mekan.uyum_skoru.toFixed(1)} | Doluluk: %${mekan.doluluk_yuzdesi.toFixed(1)}</small>
                        </div>
                    `;
                });

                if(data.onerilen_mekanlar.length > 0) {
                    map.flyTo([data.onerilen_mekanlar[0].enlem, data.onerilen_mekanlar[0].boylam], 15);
                }
            })
            .catch(error => alert("API'ye ulaşılamadı. Python sunucusunun çalıştığından emin olun."));
        });
    </script>
</body>
</html>