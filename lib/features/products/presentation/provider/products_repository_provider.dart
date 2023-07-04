import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/reositories/products_repository.dart';

import '../../infrastructure/infrastructure_index.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductRepositoryImpl(
    dataSource: ProductsDatasourceImpl(accessToken: accessToken),
  );

  return productsRepository;
});
