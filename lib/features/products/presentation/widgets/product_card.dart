import 'package:flutter/material.dart';

import '../../domain/domain_index.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageVew(listImages: product.images),
        Text(product.title, textAlign: TextAlign.center),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _ImageVew extends StatelessWidget {

  final List<String>  listImages;

  const _ImageVew({required this.listImages});

  @override
  Widget build(BuildContext context) {
    if(listImages.isEmpty){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover,
        height: 250,),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
  child: FadeInImage(
    fit: BoxFit.cover,
    height: 250,
    fadeInDuration: const Duration(milliseconds: 200),
    fadeOutDuration: const Duration(milliseconds: 200),
    image: NetworkImage(listImages.first),
    placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
     ),
    );
  }
}
