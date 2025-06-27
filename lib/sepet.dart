import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alisveris_uygulamasi/providers/cart_provider.dart';
import 'package:alisveris_uygulamasi/urun.dart';

class Sepet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sepet',

        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Toplam: ${cart.totalPrice.toStringAsFixed(2)} ₺",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Urun urun = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(urun.resim),
                  ),
                  title: Text(urun.baslik),
                  subtitle: Text('${urun.fiyat} ₺'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => cart.removeProduct(urun),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: cart.clearCart,
            child: Text('Sepeti Temizle'),
          ),
        ],
      ),
    );
  }
}
