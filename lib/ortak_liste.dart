import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alisveris_uygulamasi/urun.dart';
import 'package:alisveris_uygulamasi/urun_detay_Sayfasi.dart';
import 'package:alisveris_uygulamasi/providers/cart_provider.dart';

class OrtakListe extends StatelessWidget {
  final List<Urun> urunler;

  OrtakListe(this.urunler);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: urunler.length,
      itemBuilder: (context, index) {
        Urun urun = urunler[index];
        final cart = Provider.of<CartProvider>(context);
        final inCart = cart.items.any((u) => u.urunKodu == urun.urunKodu);

        return Card(
          child: ListTile(
            title: Text(urun.baslik),
            subtitle: Text("Fiyat: ${urun.fiyat} ₺"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(urun.resim),
            ),
            trailing: IconButton(
              icon: Icon(
                inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                color: Colors.blue,
              ),
              onPressed: () {
                if (inCart) {
                  cart.removeProduct(urun);
                } else {
                  cart.addProduct(urun);

                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UrunDetaySayfasi(urun),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
