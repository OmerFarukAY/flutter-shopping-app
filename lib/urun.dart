class Urun {
  int urunKodu;
  String baslik;
  double fiyat;
  String aciklama;
  String kategori;
  String resim;
  String derecelendirme;

  Urun.fromMap(Map<String, dynamic> urunMap)
    : urunKodu = urunMap["id"],
      baslik = urunMap["title"],
      fiyat = urunMap["price"].toDouble(),
      aciklama = urunMap["description"],
      kategori = urunMap["category"],
      resim = urunMap["image"],
        derecelendirme = urunMap["rating"]["rate"].toString();
}
