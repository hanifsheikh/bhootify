class File {
  String thumbnailURL;
  String fileURL;
  String author;
  String title;
  String duration;

  File(
      {required this.thumbnailURL,
      required this.fileURL,
      required this.author,
      required this.title,
      required this.duration});

  static File fromJson(json) => File(
        thumbnailURL: json['thumbnailURL'],
        fileURL: json['fileURL'],
        author: json['author'],
        title: json['title'],
        duration: json['duration'],
      );
}
