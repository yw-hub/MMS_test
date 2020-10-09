class Radiology {
  final String name;
  final String address;
  final String phone;
  final String fax;
  final String hours;
  final String email;
  final String website;

  Radiology({this.name,
    this.address,
    this.phone,
    this.fax,
    this.hours,
    this.email,
    this.website});

  factory Radiology.fromJson(Map<String, dynamic> json) {
    return Radiology(
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        fax: json['fax'],
        hours: json['hours'],
        email: json['email'],
        website: json['website']);
  }
}