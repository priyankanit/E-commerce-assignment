// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_assignment/models/product.dart';
import 'package:e_commerce_app_assignment/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final cartProvider = Provider.of<CartProvider>(context);
     final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRect(
                  child: CachedNetworkImage(
                    imageUrl: product.image, width: double.infinity,
                    ),
                    ),
                    ),
              const SizedBox(height: 20,),
              Text(product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              Text(product.description, maxLines: 2, style: const TextStyle(fontStyle: FontStyle.normal, fontSize: 15, fontWeight: FontWeight.w400),),
              const SizedBox(height: 10,),
              Text('\$${product.price.toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
              const SizedBox(height: 20,),
               ElevatedButton(
                onPressed: () async {
                await productProvider.addToCart(product);
                cartProvider.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item is added to cart')),
                );
              //onPressed: (){
              //   cartProvider.addToCart(product);
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item is added to cart')));
              //   //Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartPage()));
              //  // Navigator.of(context).pushNamed('/product');
              //  Navigator.popAndPushNamed(context, '/product');
              }, 
              child: Text('Add to Cart', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}