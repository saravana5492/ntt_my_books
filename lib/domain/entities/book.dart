// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Book extends Equatable {
  List<String>? authorName;
  int? firstPublishYear;
  String? key;
  List<String>? publisher;
  String? title;
  String? type;

  Book({
    this.authorName,
    this.firstPublishYear,
    this.key,
    this.publisher,
    this.title,
    this.type,
  });

  @override
  List<Object?> get props => [
        authorName,
        firstPublishYear,
        key,
        publisher,
        title,
        type,
      ];
}
