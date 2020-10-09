class Resource {
  final String name;
  final String website; //include: website and text
  final DateTime date;

  Resource({this.name, this.website, this.date});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
        name: json['name'],
        website: json['content'],
        date: DateTime.parse(json['date']));
  }
}

// class Resource {
//   final String pid;
//   final String name;
//   final String website;
//   final String message;

//   Resource (
//       {
//         this.pid,
//         this.name,
//         this.website,
//         this.message,
//         });

//   factory Resource.fromJson(Map<String, dynamic> json) {
//     return Resource(

//         pid: json['uid'],
//         name: json['name'],
//         website: json['website'],
//         message: json['message'],

//     );
//   }
// }
