class Hospital {
  final String name;
  final String address;
  final String emergencyDept;
  final String phone;
  final String aftPhone;
  final String fax;
  final String email;
  final String website;

  Hospital(
      {this.name,
        this.address,
        this.emergencyDept,
        this.phone,
        this.aftPhone,
        this.fax,
        this.email,
        this.website});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
        name: json['name'],
        address: json['address'],
        emergencyDept: json['emergencyDept'],
        phone: json['phone'],
        aftPhone: json['aftPhone'],
        fax: json['fax'],
        email: json['email'],
        website: json['website']);
  }
}