import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain_index.dart';

import 'products_repository_provider.dart';

//State Notifier Provider

// Provider es el que provee el estado de manera global

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

// Notifier para determinar cuando estoy cargando, cuando termine, cuando estableci productos etc

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }

  Future<bool> createUpdateProduct(Map<String,dynamic> productLike) async {
    try{
        final product = await productsRepository.createUpdateProduct(productLike);
        final isProductInState = state.products.any((element) => element.id == product.id);
        if(!isProductInState){
          state = state.copyWith(
            products: [...state.products, product]
          );
          return true;
        }
        state = state.copyWith(
          products: state.products.map((e) => (e.id == product.id)
          ? product : e,
          ).toList()
        );
        return true;
    }catch (e){
     return false;
    }
  }

  Future loadNextPage() async {
    if (state.isLastPage || state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductsByPage(
        limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        products: [...state.products, ...products]);
  }
}

//State para determinar todo lo que vamos a necesitar

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
