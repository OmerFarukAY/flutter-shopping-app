import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alisveris_uygulamasi/urun.dart';
import 'package:alisveris_uygulamasi/providers/cart_provider.dart';

class UrunDetaySayfasi extends StatelessWidget {
  final Urun _urun;

  UrunDetaySayfasi(this._urun);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    // Bu üründen sepette kaç adet var?
    final countInCart = cart.items.where((u) => u.urunKodu == _urun.urunKodu).length;
    final inCart = countInCart > 0;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, inCart, countInCart, cart),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_urun.baslik),
      centerTitle: true,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );
  }

  Widget _buildBody(BuildContext context, bool inCart, int countInCart, CartProvider cart) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(width: double.infinity, height: 32),
          _buildBayrak(context),
          SizedBox(height: 24),
          _buildUlkeIsmiText(),
          SizedBox(height: 36),
          _buildTumDetaylar(),
          SizedBox(height: 24),
          // Ürün sepette kaç adet var bilgisi
          if (inCart)
            Text(
              'Sepetteki adet: $countInCart',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          SizedBox(height: 12),
          // Ekle-Çıkar butonları
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (inCart)
                ElevatedButton.icon(
                  icon: Icon(Icons.remove_shopping_cart),
                  label: Text('Sepetten Çıkar'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    cart.removeProduct(_urun);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${_urun.baslik} sepetten çıkarıldı.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              if (!inCart)
                ElevatedButton.icon(
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text('Sepete Ekle'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    cart.addProduct(_urun);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${_urun.baslik} sepete eklendi.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTumDetaylar() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetayRow("İsim: ", _urun.baslik),
          _buildDetayRow("Fiyat: ", "${_urun.fiyat} ₺"),
          _buildDetayRow("Açıklama: ", _urun.aciklama),
          _buildDetayRow("Kategori: ", _urun.kategori),
          _buildDetayRow(
            "Derecelendirme: ",
            _urun.derecelendirme + "/5",
          ),
        ],
      ),
    );
  }

  Widget _buildBayrak(BuildContext context) {
    return Image.network(
      _urun.resim,
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildUlkeIsmiText() {
    return Text(
      _urun.baslik,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDetayRow(String baslik, String detay) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            baslik,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          flex: 3,
          child: Text(
            detay,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
