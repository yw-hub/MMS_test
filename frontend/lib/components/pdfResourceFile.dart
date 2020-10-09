class PdfResourcefile {
  final String id;
  final String pid;
  final String title;
  final DateTime date;
  final String link;

  PdfResourcefile({this.id, this.pid, this.title, this.link, this.date});

  factory PdfResourcefile.fromJson(Map<String, dynamic> json) {
    return PdfResourcefile(
        id: json['id'],
        pid: json['uid'],
        title: json['title'],
        link: json['link'],
        date: DateTime.parse(json['date']));
  }
}
