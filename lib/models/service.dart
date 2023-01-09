class Service {
  Service({
    required this.id,
    required this.namaService,
    required this.tarif,
  });

  int id;
  String namaService;
  String tarif;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    namaService: json["nama_service"],
    tarif: json["tarif"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_service": namaService,
    "tarif": tarif,
  };
}
