import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_assignment/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
   final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body:Column(
        children: [
          Expanded(
            child: cartProvider.cartItems.isEmpty
            ? const Center(child: Text('Your cart is Empty'),)
            : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index){
                final product = cartProvider.cartItems[index];
                return Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),),
                    focusColor: Theme.of(context).colorScheme.primary,
                    leading: CachedNetworkImage(imageUrl: product.image, width:50),
                    title: Text(product.title),
                    titleAlignment: ListTileTitleAlignment.center,
                    subtitle: Text('\$${product.price.toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                    trailing: IconButton(onPressed: (){
                      cartProvider.removeFromCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item is deleted from the cart')));
                    }, 
                    icon: const Icon(Icons.remove_circle),
                  )
                  ),
                );
            
            }),
          ),
        ],
      )
    );
  }
}