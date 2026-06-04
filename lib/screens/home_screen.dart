import 'package:flutter/material.dart';
import '../models/product.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    Product(
      id: 1,
      name: 'iPhone 15 Pro',
      description:
          'Apple iPhone 15 Pro 256GB. Titanium tasarım, A17 Pro çip, 48MP kamera sistemi ve USB-C bağlantısıyla en güçlü iPhone.',
      price: 999.0,
      image: 'assets/images/iphone.jpg',
      category: 'Telefon',
    ),
    Product(
      id: 2,
      name: 'MacBook Pro 14"',
      description:
          'Apple M3 Pro çipli MacBook Pro. 18GB birleşik bellek, 512GB SSD. Liquid Retina XDR ekran ve 22 saate kadar pil ömrü.',
      price: 1999.0,
      image: 'assets/images/macbook.jpg',
      category: 'Bilgisayar',
    ),
    Product(
      id: 3,
      name: 'iPad Air',
      description:
          'Apple iPad Air 5. Nesil. M1 çip, 10.9 inç Liquid Retina ekran, 5G desteği ve Center Stage kamera ile her yerde üretkenlik.',
      price: 599.0,
      image: 'assets/images/ipad.jpg',
      category: 'Tablet',
    ),
    Product(
      id: 4,
      name: 'AirPods Pro',
      description:
          'AirPods Pro 2. Nesil. Aktif gürültü engelleme, Uyarlanabilir Şeffaflık modu, Kişiselleştirilmiş Uzamsal Ses ve 30 saate kadar pil.',
      price: 249.0,
      image: 'assets/images/airpods.jpg',
      category: 'Aksesuar',
    ),
    Product(
      id: 5,
      name: 'Apple Watch Series 9',
      description:
          'Apple Watch Series 9. S9 çip, Always-On Retina ekran, Çift Dokunuş hareketi, kan oksijeni ve kalp ritmi izleme.',
      price: 399.0,
      image: 'assets/images/applewatch.jpg',
      category: 'Aksesuar',
    ),
    Product(
      id: 6,
      name: 'HomePod Mini',
      description:
          'HomePod Mini. 360 derece yüksek kaliteli ses, Siri entegrasyonu, akıllı ev merkezi ve Ultra Geniş bant çipi ile hassas oda algılama.',
      price: 99.0,
      image: 'assets/images/homepod.jpg',
      category: 'Ev',
    ),
  ];

  final List<Product> cartItems = [];
  final Set<int> favoriteIds = {};
  String searchQuery = '';
  String selectedCategory = 'Tümü';

  List<String> get categories => [
        'Tümü',
        ...products.map((p) => p.category).toSet().toList(),
      ];

  List<Product> get filteredProducts => products.where((p) {
        final matchesSearch =
            p.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesCategory =
            selectedCategory == 'Tümü' || p.category == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();

  void addToCart(Product product) {
    setState(() => cartItems.add(product));
  }

  void removeFromCart(Product product) {
    setState(() => cartItems.remove(product));
  }

  void toggleFavorite(int productId) {
    setState(() {
      if (favoriteIds.contains(productId)) {
        favoriteIds.remove(productId);
      } else {
        favoriteIds.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Mini Katalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Badge(
              label: Text('${favoriteIds.length}'),
              isLabelVisible: favoriteIds.isNotEmpty,
              backgroundColor: Colors.red,
              child: const Icon(Icons.favorite_border),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    products:
                        products.where((p) => favoriteIds.contains(p.id)).toList(),
                    favoriteIds: favoriteIds,
                    onToggleFavorite: toggleFavorite,
                    onAddToCart: addToCart,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Badge(
              label: Text('${cartItems.length}'),
              isLabelVisible: cartItems.isNotEmpty,
              backgroundColor: Colors.orange,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(
                    cartItems: cartItems,
                    onRemove: removeFromCart,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepPurple,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ürün ara...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon:
                    const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => selectedCategory = cat),
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text('Ürün bulunamadı',
                        style: TextStyle(color: Colors.grey)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final isFav = favoriteIds.contains(product.id);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                product: product,
                                isFavorite: isFav,
                                onAddToCart: () => addToCart(product),
                                onToggleFavorite: () =>
                                    toggleFavorite(product.id),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.asset(
                                      product.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Center(
                                        child: Icon(Icons.image,
                                            size: 48, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 6, 8, 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () => toggleFavorite(product.id),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.85),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isFav ? Colors.red : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
