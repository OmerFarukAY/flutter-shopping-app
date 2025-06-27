import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:alisveris_uygulamasi/sepet.dart';
import 'package:alisveris_uygulamasi/ortak_liste.dart';
import 'package:alisveris_uygulamasi/urun.dart';

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final String _apiUrl = "https://fakestoreapi.com/products";
  List<Urun> _butunUrunler = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _urunleriInternettenCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Tüm Ürünler"),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    if (_butunUrunler.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (_currentIndex == 0) {
      return OrtakListe(_butunUrunler);
    } else {
      return Sepet();
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Ürünler",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Sepet",
        ),
      ],
    );
  }

  void _urunleriInternettenCek() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);

    _butunUrunler = parsedResponse.map((e) => Urun.fromMap(e)).toList();

    setState(() {});
  }
}
