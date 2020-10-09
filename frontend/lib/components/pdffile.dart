class Pdffile {
  final String id;
  final String apptid;
  final String title;
  final String link;

  Pdffile(
      {this.id,
        this.apptid,
        this.title,
        this.link});

  factory Pdffile.fromJson(Map<String, dynamic> json) {
    return Pdffile(
        id: json['id'],
        apptid: json['apptid'],
        title: json['title'],
        link: json['link']);
  }
}