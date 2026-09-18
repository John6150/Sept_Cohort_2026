import 'package:flutter_riverpod/legacy.dart';

/// Providers are declared globally and specify how to create a state
// final counterProvider = StateProvider((ref) => 0);

StateProvider<int> counterProvider = StateProvider((ref) {
  return 0;
});

class ProductModel {
  final String name;
  final String id;
  final List<String> reviews;

  const ProductModel({
    required this.name,
    required this.id,
    required this.reviews,
  });
}

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super(<ProductModel>[]);

  Future<void> getProducts() async {
    Future.delayed(Duration(seconds: 5), () {
      state = [
        ProductModel(
          name: 'iPhone 18 pro max',
          id: '1234',
          reviews: ['A very good phone'],
        ),
        ProductModel(
          name: 'Nike Show',
          id: '4321',
          reviews: ['A very good show'],
        ),
      ];
    });
  }
}

final productProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>(
      (ref) => ProductNotifier(),
    );
