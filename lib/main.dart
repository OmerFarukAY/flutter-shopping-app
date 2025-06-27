import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alisveris_uygulamasi/ana_Sayfa.dart';
import 'package:alisveris_uygulamasi/providers/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: AnaUygulama(),
    ),
  );
}

class AnaUygulama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnaSayfa(),
    );
  }
}
