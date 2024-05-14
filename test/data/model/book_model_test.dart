import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_books_ntt/data/models/book_model.dart';
import 'package:my_books_ntt/domain/entities/book.dart';

import '../../helper/json_reader.dart';

void main() {
  BookModel testBookModel = BookModel(
    authorName: const [
      "Фёдор Михайлович Достоевский",
    ],
    firstPublishYear: 2009,
    key: "/works/OL24574391W",
    publisher: const [
      "Xist Publishing",
      "Simon & Brown",
      "Skyhorse Publishing Company, Incorporated"
    ],
    title: "Crime and Punishment",
    type: "work",
  );

  test('should be a subsclass of Book Entity', () async {
    // assert
    expect(testBookModel, isA<Book>());
  });

  test('should return valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helper/dummy_data/dummy_book_response.json'));

    // act
    final result = BookModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testBookModel));
  });

  test('should return a json map which contains proper data', () async {
    // act
    final result = testBookModel.toJson();

    final Map<String, dynamic> expectedJsonMap =
        json.decode(readJson('helper/dummy_data/dummy_book_response.json'));

    // assert
    expect(result, expectedJsonMap);
  });
}
