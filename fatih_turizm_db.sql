-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 12 Ağu 2026, 00:43:29
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `fatih_turizm_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `anlik_yogunluk`
--

CREATE TABLE `anlik_yogunluk` (
  `mekan_id` int(11) NOT NULL,
  `guncel_kisi_sayisi` int(11) DEFAULT 0,
  `son_guncellenme_zamani` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `anlik_yogunluk`
--

INSERT INTO `anlik_yogunluk` (`mekan_id`, `guncel_kisi_sayisi`, `son_guncellenme_zamani`) VALUES
(1, 3800, '2026-08-12 01:28:11'),
(2, 1200, '2026-08-12 01:28:11'),
(3, 1450, '2026-08-12 01:28:11'),
(4, 1500, '2026-08-12 01:28:11'),
(5, 9000, '2026-08-12 01:28:11'),
(6, 400, '2026-08-12 01:28:11'),
(7, 1800, '2026-08-12 01:28:11'),
(8, 950, '2026-08-12 01:28:11'),
(9, 145, '2026-08-12 01:28:11'),
(10, 240, '2026-08-12 01:28:11'),
(11, 3500, '2026-08-12 01:28:11'),
(12, 480, '2026-08-12 01:28:11'),
(13, 50, '2026-08-12 01:28:11'),
(14, 48, '2026-08-12 01:28:11'),
(15, 380, '2026-08-12 01:28:11'),
(16, 200, '2026-08-12 01:28:11'),
(17, 150, '2026-08-12 01:28:11'),
(18, 300, '2026-08-12 01:28:11'),
(19, 1200, '2026-08-12 01:28:11'),
(20, 400, '2026-08-12 01:28:11'),
(21, 100, '2026-08-12 01:28:11'),
(22, 800, '2026-08-12 01:28:11'),
(23, 50, '2026-08-12 01:28:11'),
(24, 140, '2026-08-12 01:28:11'),
(25, 80, '2026-08-12 01:28:11'),
(26, 40, '2026-08-12 01:28:11'),
(27, 600, '2026-08-12 01:28:11'),
(28, 145, '2026-08-12 01:28:11'),
(29, 300, '2026-08-12 01:28:11'),
(30, 200, '2026-08-12 01:28:11');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kategoriler`
--

CREATE TABLE `kategoriler` (
  `id` int(11) NOT NULL,
  `kategori_adi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `kategoriler`
--

INSERT INTO `kategoriler` (`id`, `kategori_adi`) VALUES
(5, 'Alışveriş'),
(3, 'Dini'),
(4, 'Doğa/Manzara'),
(9, 'Fotoğraf/Sokak'),
(8, 'Kapalı Alan'),
(2, 'Müze'),
(1, 'Tarihi'),
(7, 'Ücretsiz'),
(6, 'Yeme-İçme');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanicilar`
--

CREATE TABLE `kullanicilar` (
  `id` int(11) NOT NULL,
  `cihaz_kimligi` varchar(100) NOT NULL,
  `olusturulma_tarihi` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `kullanicilar`
--

INSERT INTO `kullanicilar` (`id`, `cihaz_kimligi`, `olusturulma_tarihi`) VALUES
(1, 'ios_user_99x', '2026-08-12 01:28:11'),
(2, 'and_user_44b', '2026-08-12 01:28:11'),
(3, 'web_user_11a', '2026-08-12 01:28:11');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanici_tercihleri`
--

CREATE TABLE `kullanici_tercihleri` (
  `kullanici_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `kullanici_tercihleri`
--

INSERT INTO `kullanici_tercihleri` (`kullanici_id`, `kategori_id`) VALUES
(1, 1),
(1, 2),
(2, 4),
(2, 6),
(3, 7),
(3, 9);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `mekanlar`
--

CREATE TABLE `mekanlar` (
  `id` int(11) NOT NULL,
  `isim` varchar(100) NOT NULL,
  `aciklama` text DEFAULT NULL,
  `enlem` decimal(10,8) NOT NULL,
  `boylam` decimal(11,8) NOT NULL,
  `acilis_saati` time NOT NULL,
  `kapanis_saati` time NOT NULL,
  `ucretli_mi` tinyint(1) NOT NULL DEFAULT 0,
  `maksimum_kapasite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `mekanlar`
--

INSERT INTO `mekanlar` (`id`, `isim`, `aciklama`, `enlem`, `boylam`, `acilis_saati`, `kapanis_saati`, `ucretli_mi`, `maksimum_kapasite`) VALUES
(1, 'Topkapı Sarayı', 'Osmanlı İmparatorluğu\'nun 400 yıllık yönetim merkezi ve devasa müze kompleksi.', 41.01150000, 28.98340000, '09:00:00', '18:00:00', 1, 4000),
(2, 'Ayasofya-i Kebir Cami-i Şerifi', 'Dünya mimarlık tarihinin günümüze ulaşan en önemli anıtlarından biri.', 41.00860000, 28.97800000, '00:00:00', '23:59:00', 0, 5000),
(3, 'Yerebatan Sarnıcı', 'Bizans döneminden kalma, suyun içinden yükselen sütunlarıyla ünlü devasa sarnıç.', 41.00830000, 28.97840000, '09:00:00', '19:00:00', 1, 1500),
(4, 'Gülhane Parkı', 'Topkapı Sarayı\'nın dış bahçesi olan, devasa ağaçlarla kaplı tarihi park.', 41.01280000, 28.98000000, '06:00:00', '22:30:00', 0, 8000),
(5, 'Kapalıçarşı', 'Dünyanın en eski ve en büyük kapalı çarşılarından biri.', 41.01080000, 28.96800000, '08:30:00', '19:00:00', 0, 10000),
(6, 'Süleymaniye Camii', 'Mimar Sinan\'ın kalfalık eseri, muhteşem Haliç manzaralı külliye.', 41.01620000, 28.96380000, '08:30:00', '16:30:00', 0, 4000),
(7, 'İstanbul Arkeoloji Müzeleri', 'İskender Lahdi gibi dünya çapında eserlere ev sahipliği yapan müze kompleksi.', 41.01160000, 28.98130000, '09:00:00', '19:00:00', 1, 2500),
(8, 'Balat Renkli Evler', 'Tarihi yarımadanın fotoğrafçılar için en popüler ve nostaljik sokakları.', 41.03110000, 28.94640000, '00:00:00', '23:59:00', 0, 1000),
(9, 'Vefa Bozacısı', '1876\'dan beri değişmeyen atmosferiyle meşhur tarihi boza dükkanı.', 41.01600000, 28.95920000, '08:00:00', '23:30:00', 1, 150),
(10, 'Tarihi Sultanahmet Köftecisi', '1920\'den günümüze hizmet veren, İstanbul\'un en meşhur lezzet duraklarından.', 41.00810000, 28.97600000, '10:30:00', '23:00:00', 1, 250),
(11, 'Mısır Çarşısı', 'Baharat kokularının birbirine karıştığı, Eminönü\'nün tarihi ticaret merkezi.', 41.01650000, 28.97050000, '08:00:00', '19:30:00', 0, 4000),
(12, 'Eminönü Balık Ekmek Tekneleri', 'Galata Kulesi manzarasına karşı geleneksel balık ekmek keyfi.', 41.01750000, 28.97230000, '10:00:00', '22:00:00', 1, 500),
(13, 'Fener Rum Patrikhanesi', 'Ortodoks dünyasının merkezi sayılan tarihi dini kompleks.', 41.02940000, 28.95170000, '08:30:00', '16:00:00', 0, 300),
(14, 'Kurukahveci Mehmet Efendi', 'Kahve kokularının sokağa taştığı, Türkiye\'nin en eski kahvecilerinden.', 41.01640000, 28.97020000, '07:00:00', '19:00:00', 1, 50),
(15, 'Şerefiye Sarnıcı', 'Özel aydınlatması ve su mimarisiyle dikkat çeken restore edilmiş Bizans sarnıcı.', 41.00730000, 28.97290000, '09:00:00', '19:00:00', 1, 400),
(16, 'Kariye Camii (Chora)', 'Bizans dönemi mozaik ve freskleriyle dünyaca ünlü tarihi yapı.', 41.03110000, 28.93920000, '09:00:00', '18:00:00', 0, 800),
(17, 'Haliç Metro Köprüsü', 'Eşsiz gün batımı ve Haliç manzarası sunan modern seyir noktası.', 41.02250000, 28.96670000, '00:00:00', '23:59:00', 0, 600),
(18, 'Türk ve İslam Eserleri Müzesi', 'İbrahim Paşa Sarayı içinde yer alan zengin İslam sanatı koleksiyonu.', 41.00620000, 28.97440000, '09:00:00', '19:00:00', 1, 1200),
(19, 'Sahaflar Çarşısı', 'Beyazıt\'ta yer alan, kitap kokuları arasındaki tarihi çarşı.', 41.00970000, 28.96190000, '08:00:00', '19:00:00', 0, 1500),
(20, 'Ahırkapı Feneri Sahili', 'Sarayburnu\'ndan Marmara Denizi\'ne uzanan huzurlu yürüyüş yolu.', 41.00160000, 28.98390000, '00:00:00', '23:59:00', 0, 2000),
(21, 'Bozdoğan Kemeri (Valens)', 'Romalılar tarafından şehre su taşımak için inşa edilmiş devasa su kemeri.', 41.01580000, 28.95550000, '00:00:00', '23:59:00', 0, 1000),
(22, 'Yeni Cami', 'Eminönü meydanının siluetini oluşturan, yüzlerce güvercine ev sahipliği yapan yapı.', 41.01690000, 28.97110000, '00:00:00', '23:59:00', 0, 3000),
(23, 'Büyük Postane', 'Sirkeci\'de yer alan, I. Ulusal Mimarlık Akımı\'nın en güzel sivil mimari örneklerinden.', 41.01470000, 28.97380000, '08:30:00', '17:30:00', 0, 500),
(24, 'Cağaloğlu Hamamı', '1741 yapımı, barok mimariyle tasarlanmış dünyaca ünlü tarihi Türk hamamı.', 41.01050000, 28.97520000, '09:00:00', '22:00:00', 1, 150),
(25, 'Rüstem Paşa Camii', 'İznik çinileriyle bezenmiş, Mimar Sinan\'ın saklı kalmış şaheserlerinden.', 41.01770000, 28.96910000, '09:00:00', '18:00:00', 0, 500),
(26, 'Zeyrek Camii (Pantokrator)', 'Ayasofya\'dan sonra ayakta kalan en büyük eski Bizans kiliselerinden biri.', 41.01940000, 28.95750000, '09:00:00', '18:00:00', 0, 600),
(27, 'Fatih Camii', 'İstanbul\'un fethinden sonra şehre inşa edilen ilk büyük selatin camii ve külliyesi.', 41.01970000, 28.94970000, '05:00:00', '22:30:00', 0, 5000),
(28, 'Hafız Mustafa 1864', 'Sirkeci\'de geleneksel Türk tatlıları ve lokumlarıyla meşhur tarihi şekerlemeci.', 41.01440000, 28.97550000, '00:00:00', '23:59:00', 1, 150),
(29, 'Dikilitaş (Theodosius Sütunu)', 'Sultanahmet Meydanı\'nda yer alan, Mısır\'dan getirilmiş 3500 yıllık antik anıt.', 41.00630000, 28.97580000, '00:00:00', '23:59:00', 0, 3000),
(30, 'Aya İrini Müzesi', 'Topkapı Sarayı avlusunda yer alan, camiye çevrilmemiş en eski Bizans kilisesi.', 41.00950000, 28.98120000, '09:00:00', '17:00:00', 1, 800);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `mekan_kategorileri`
--

CREATE TABLE `mekan_kategorileri` (
  `mekan_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `mekan_kategorileri`
--

INSERT INTO `mekan_kategorileri` (`mekan_id`, `kategori_id`) VALUES
(1, 1),
(1, 2),
(1, 4),
(2, 1),
(2, 3),
(2, 7),
(2, 8),
(3, 1),
(3, 2),
(3, 8),
(4, 4),
(4, 7),
(5, 1),
(5, 5),
(5, 8),
(6, 1),
(6, 3),
(6, 4),
(6, 7),
(7, 1),
(7, 2),
(7, 8),
(8, 7),
(8, 9),
(9, 1),
(9, 6),
(9, 8),
(10, 6),
(10, 8),
(11, 1),
(11, 5),
(11, 8),
(12, 4),
(12, 6),
(13, 1),
(13, 3),
(13, 7),
(14, 5),
(14, 6),
(15, 1),
(15, 2),
(15, 8),
(16, 1),
(16, 2),
(16, 3),
(16, 8),
(17, 4),
(17, 7),
(17, 9),
(18, 1),
(18, 2),
(18, 8),
(19, 1),
(19, 5),
(19, 7),
(20, 4),
(20, 7),
(20, 9),
(21, 1),
(21, 7),
(21, 9),
(22, 1),
(22, 3),
(22, 7),
(22, 8),
(23, 1),
(23, 7),
(23, 9),
(24, 1),
(24, 8),
(25, 1),
(25, 3),
(25, 7),
(25, 8),
(26, 1),
(26, 3),
(26, 7),
(26, 8),
(27, 1),
(27, 3),
(27, 7),
(27, 8),
(28, 6),
(28, 8),
(29, 1),
(29, 7),
(29, 9),
(30, 1),
(30, 2),
(30, 8);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `anlik_yogunluk`
--
ALTER TABLE `anlik_yogunluk`
  ADD PRIMARY KEY (`mekan_id`);

--
-- Tablo için indeksler `kategoriler`
--
ALTER TABLE `kategoriler`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kategori_adi` (`kategori_adi`);

--
-- Tablo için indeksler `kullanicilar`
--
ALTER TABLE `kullanicilar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cihaz_kimligi` (`cihaz_kimligi`);

--
-- Tablo için indeksler `kullanici_tercihleri`
--
ALTER TABLE `kullanici_tercihleri`
  ADD PRIMARY KEY (`kullanici_id`,`kategori_id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- Tablo için indeksler `mekanlar`
--
ALTER TABLE `mekanlar`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `mekan_kategorileri`
--
ALTER TABLE `mekan_kategorileri`
  ADD PRIMARY KEY (`mekan_id`,`kategori_id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `kategoriler`
--
ALTER TABLE `kategoriler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `kullanicilar`
--
ALTER TABLE `kullanicilar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `mekanlar`
--
ALTER TABLE `mekanlar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `anlik_yogunluk`
--
ALTER TABLE `anlik_yogunluk`
  ADD CONSTRAINT `anlik_yogunluk_ibfk_1` FOREIGN KEY (`mekan_id`) REFERENCES `mekanlar` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `kullanici_tercihleri`
--
ALTER TABLE `kullanici_tercihleri`
  ADD CONSTRAINT `kullanici_tercihleri_ibfk_1` FOREIGN KEY (`kullanici_id`) REFERENCES `kullanicilar` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kullanici_tercihleri_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategoriler` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `mekan_kategorileri`
--
ALTER TABLE `mekan_kategorileri`
  ADD CONSTRAINT `mekan_kategorileri_ibfk_1` FOREIGN KEY (`mekan_id`) REFERENCES `mekanlar` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mekan_kategorileri_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategoriler` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
