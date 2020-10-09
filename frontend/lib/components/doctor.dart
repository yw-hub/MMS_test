class Doctor {
  final String name;
  final String bio;
  final String address;
  final String phone;
  final String fax;
  final String email;
  final String website;
  final String expertise;

  Doctor(
      {this.name,
        this.bio,
        this.address,
        this.phone,
        this.fax,
        this.email,
        this.website,
        this.expertise});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        name: json['name'],
        bio: json['bio'],
        address: json['address'],
        phone: json['phone'],
        fax: json['fax'],
        email: json['email'],
        website: json['website'],
        expertise: json['expertise']);
  }
}