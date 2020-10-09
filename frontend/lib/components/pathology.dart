class Pathology {
  final String name;
  final String address;
  final String phone;
  final String hours;
  final String website;

  Pathology(
      {this.name,
        this.address,
        this.phone,
        this.hours,
        this.website});

  factory Pathology.fromJson(Map<String, dynamic> json) {
    return Pathology(
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        hours: json['hours'],
        website: json['website']);
  }
}