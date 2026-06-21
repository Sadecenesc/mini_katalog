# Mini Katalog Uygulaması 🛍️

Flutter ile geliştirilmiş **Apple ürünleri** kataloğu mobil uygulaması. Kullanıcılar ürünleri listeleyebilir, arama yapabilir, kategoriye göre filtreleyebilir, favorileyebilir ve sepete ekleyebilir.

Bu proje, Flutter Günlük Eğitim programı kapsamında widget yapısı, sayfa geçişleri, temel UI tasarımı, veri modeli oluşturma ve proje klasörleme mantığını uygulamak amacıyla geliştirilmiştir.

---

## 📸 Ekran Görüntüleri

| Ana Sayfa | Arama | Kategori | Ürün Detayı |
|---|---|---|---|
| [![Ana Sayfa](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/01_ana_sayfa.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/01_ana_sayfa.png) | [![Arama](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/02_arama.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/02_arama.png) | [![Kategori](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/03_kategori_aksesuar.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/03_kategori_aksesuar.png) | [![Detay](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/04_urun_detay.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/04_urun_detay.png) |

| Sepete Eklendi | Sepet | Favoriler | Final |
|---|---|---|---|
| [![Sepete Eklendi](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/05_sepete_eklendi.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/05_sepete_eklendi.png) | [![Sepet](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/06_sepet.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/06_sepet.png) | [![Favoriler](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/07_favoriler.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/07_favoriler.png) | [![Final](https://github.com/Sadecenesc/mini_katalog/raw/master/screenshots/08_ana_sayfa_final.png)](/Sadecenesc/mini_katalog/blob/master/screenshots/08_ana_sayfa_final.png) |

---

## ✨ Özellikler

### Ürün Listeleme
- 6 Apple ürünü **2 sütunlu GridView** ile listelenir
- Her kart; ürün görseli, adı ve fiyatı gösterir
- Ürün görselleri yüksek kaliteli yerel asset olarak saklanır

### Arama & Filtreleme
- Anlık arama — yazarken liste güncellenir
- **Kategori chip'leri** ile filtreleme: Tümü / Telefon / Bilgisayar / Tablet / Aksesuar / Ev

### Ürün Detayı
- Tam ekran ürün görseli
- Ürün adı, fiyatı, kategorisi ve açıklaması
- **Sepete Ekle** butonu — eklenince rengi yeşile döner, SnackBar bildirimi gösterilir
- AppBar'dan **favorileme** (kalp ikonu)

### Sepet
- Eklenen ürünlerin listesi
- **Sola kaydırarak** (swipe) veya çöp kutusu butonu ile silme
- Toplam fiyat hesaplama
- **Sipariş Onay** diyaloğu

### Favoriler
- Hem ürün kartında hem AppBar'da kalp ikonuna dokunarak favorileme
- AppBar'daki kalp ve sepet ikonlarında **badge sayacı**
- Ayrı **Favoriler ekranı** — favorilenen ürünler listelenir
- Favori ekrandan direkt sepete ekleme

---

## 🏗️ Veri Modeli ve Sayfa Geçişleri

### Ürün Veri Modeli

`Product` model sınıfı (`lib/models/product.dart`), eğitimde işlenen nesne
yönelimli programlama mantığına uygun olarak tasarlanmıştır. `id`, `name`,
`description`, `price`, `image` ve `category` alanlarını barındırır; bu yapı
modeli ileride bir API'ye bağlanmaya hazır hale getirir.

```dart
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });
}
```

### Sayfalar Arası Geçiş (Navigator)

Sayfa geçişleri `Navigator.push` ile `MaterialPageRoute` kullanılarak
yapılır. Kullanıcı bir ürün kartına dokunduğunda seçilen `Product`
nesnesi, favori durumu ve callback fonksiyonları birlikte `DetailScreen`'e
iletilir; böylece durum yönetimi `HomeScreen`'de merkezi olarak tutulur:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailScreen(
      product: product,
      isFavorite: isFav,
      onAddToCart: () => addToCart(product),
      onToggleFavorite: () => toggleFavorite(product.id),
    ),
  ),
);
```

---

## 🗂️ Proje Yapısı

```
mini_katalog/
├── lib/
│   ├── main.dart                    # Uygulama giriş noktası
│   ├── models/
│   │   └── product.dart             # Ürün veri modeli
│   ├── screens/
│   │   ├── home_screen.dart         # Ana sayfa (grid, arama, kategoriler)
│   │   ├── detail_screen.dart       # Ürün detay sayfası
│   │   ├── cart_screen.dart         # Sepet sayfası
│   │   └── favorites_screen.dart    # Favoriler sayfası
│   └── widgets/
│       └── product_card.dart        # Yeniden kullanılabilir ürün kartı
├── assets/
│   └── images/                      # Yerel ürün görselleri
│       ├── iphone.jpg
│       ├── macbook.jpg
│       ├── ipad.jpg
│       ├── airpods.jpg
│       ├── applewatch.jpg
│       └── homepod.jpg
├── screenshots/                     # Uygulama ekran görüntüleri
└── pubspec.yaml
```

---

## 🛠️ Kullanılan Teknolojiler

| Teknoloji | Açıklama |
|---|---|
| Flutter 3.x | UI framework |
| Dart 3.x | Programlama dili |
| Material Design 3 | Tasarım sistemi |
| StatefulWidget / setState | Durum yönetimi |
| Navigator / MaterialPageRoute | Sayfa geçişleri ve callback aktarımı |
| GridView.builder | Ürün ızgarası |
| ListView.builder | Sepet listesi |
| Dismissible | Kaydırarak silme |
| Badge | AppBar ikon sayaçları |
| Image.asset | Yerel görsel yükleme |

> Not: Tablodaki Flutter sürümünü kendi ortamında `flutter --version`
> komutunu çalıştırarak doğrula ve gerekirse güncelle.

---

## 📱 Ekranlar

| Ekran | Widget Türü | Açıklama |
|---|---|---|
| `HomeScreen` | StatefulWidget | Ürün grid, arama, kategori filtresi, badge'li ikon çifti |
| `DetailScreen` | StatefulWidget | Ürün detayı, favorileme, sepete ekleme + SnackBar |
| `CartScreen` | StatefulWidget | Ürün listesi, swipe-to-delete, sipariş onayı |
| `FavoritesScreen` | StatefulWidget | Favori ürünler, anlık kaldırma, sepete ekleme |

---

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio (Android Emulator için) veya bağlı bir Android cihaz

### Adımlar

```bash
# 1. Repoyu klonla
git clone https://github.com/Sadecenesc/mini_katalog.git
cd mini_katalog

# 2. Bağımlılıkları yükle
flutter pub get

# 3. Bağlı cihaz/emülatörleri listele
flutter devices

# 4. Android Emulator veya bağlı Android cihazda çalıştır
flutter run -d android

# 5. (Alternatif) Windows'ta çalıştır
flutter run -d windows

# 6. (Alternatif) Web tarayıcısında çalıştır
flutter run -d chrome
```

---

## 📦 Ürünler

| # | Ürün | Kategori | Fiyat |
|---|---|---|---|
| 1 | iPhone 15 Pro | Telefon | $999.00 |
| 2 | MacBook Pro 14" | Bilgisayar | $1999.00 |
| 3 | iPad Air | Tablet | $599.00 |
| 4 | AirPods Pro | Aksesuar | $249.00 |
| 5 | Apple Watch Series 9 | Aksesuar | $399.00 |
| 6 | HomePod Mini | Ev | $99.00 |
