class PesanModel {
  int pk;
  String nama;
  String isi;

  PesanModel({
    required this.pk,
    required this.nama,
    required this.isi,
  });

  factory PesanModel.fromJson(Map<String, dynamic> json) => PesanModel(
        pk: json["pk"],
        nama: json["fields"]["nama"],
        isi: json["fields"]["isi"],
      );
}
