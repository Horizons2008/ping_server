class Resultat {
  Resultat({
    required this.id,
    required this.status,
    required this.date,
    required this.delai,
    required this.url,
  });
  late int id;
  late String status;
  late String date;
  late int delai;
  late String url;

/*
  Resultat.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'] ?? "";
    qrcode = json['qrcode'];
    token = json['token'];
    photo = json['photo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['qrcode'] = qrcode;
    _data['token'] = token;
    return _data;
  }*/
}
