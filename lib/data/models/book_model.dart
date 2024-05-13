// ignore_for_file: must_be_immutable

import 'package:my_books_ntt/domain/entities/book.dart';

List<BookModel> fromResponseJson(List<dynamic> listDynamic) {
  return List<BookModel>.from(listDynamic.map((x) => BookModel.fromJson(x)));
}

class BookModel extends Book {
  BookModel({
    super.authorName,
    super.firstPublishYear,
    super.key,
    super.publisher,
    super.title,
    super.type,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        authorName: json["author_name"] == null
            ? []
            : List<String>.from(json["author_name"]!.map((x) => x)),
        firstPublishYear: json["first_publish_year"],
        key: json["key"],
        publisher: json["publisher"] == null
            ? []
            : List<String>.from(json["publisher"]!.map((x) => x)),
        title: json["title"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName == null
            ? []
            : List<dynamic>.from(authorName!.map((x) => x)),
        "first_publish_year": firstPublishYear,
        "key": key,
        "publisher": publisher == null
            ? []
            : List<dynamic>.from(publisher!.map((x) => x)),
        "title": title,
        "type": type,
      };

  Book toEntity() {
    return Book(
      authorName: authorName,
      firstPublishYear: firstPublishYear,
      key: key,
      publisher: publisher,
      title: title,
      type: type,
    );
  }
}
