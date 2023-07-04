import '../../domain/domain_index.dart';

class ProductRepositoryImpl extends ProductsRepository {
  final ProductsRepository dataSource;
  ProductRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> procut) {
    return dataSource.createUpdateProduct(procut);
  }

  @override
  Future<Product> getProductsById(String id) {
    return dataSource.getProductsById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 10}) {
    return dataSource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return dataSource.searchProductByTerm(term);
  }
}
