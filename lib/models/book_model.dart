import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String topic;
  final String author;
  final String coverURL;
  final String yearPublished;
  final String synopsis;

  BookModel({
    required this.id,
    required this.topic,
    required this.author,
    required this.coverURL,
    required this.yearPublished,
    required this.synopsis,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "topic": topic,
        "author": author,
        "cover": coverURL,
        "yearPublihsed": yearPublished,
        "synopsis": synopsis,
      };

  factory BookModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return BookModel(
      id: data?["id"],
      topic: data?["topic"],
      author: data?["author"],
      coverURL: data?["coverURL"],
      yearPublished: data?["yearPublished"],
      synopsis: data?["synopsis"],
    );
  }

  factory BookModel.fromJSON(Map bookMap) {
    return BookModel(
      id: bookMap["id"],
      topic: bookMap["topic"],
      author: bookMap["author_name"],
      coverURL: bookMap["cover_i"],
      yearPublished: bookMap["first_publish_year"],
      synopsis: bookMap["first_sentence"],
    );
  }
}
