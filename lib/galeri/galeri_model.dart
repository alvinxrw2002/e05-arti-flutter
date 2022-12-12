class GaleriModel {
  final int pk;
  final String urlGambar;
  final String judul;
  final String kategori;
  final int harga;
  final String deskripsi;
  final String tanggal;

  GaleriModel({
    required this.pk,
    required this.urlGambar,
    required this.judul,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.tanggal,
  });

  factory GaleriModel.fromJson(Map<String, dynamic> json) => GaleriModel(
        pk: json["pk"],
        urlGambar: json["fields"]["gambar"],
        judul: json["fields"]["judul"],
        kategori: json["fields"]["kategori"],
        harga: json["fields"]["harga"],
        deskripsi: json["fields"]["deskripsi"],
        tanggal: json["fields"]["tanggal"],
      );
}
