import 'dart:convert';
import 'package:my_books_ntt/core/error/exception.dart';
import 'package:my_books_ntt/core/network/netwrok_constants.dart';
import 'package:my_books_ntt/data/models/book_model.dart';
import 'package:http/http.dart' as http;

abstract interface class BookRemoteDatasource {
  Future<List<BookModel>> fetchAllBooks();
}

class BookRemoteDatasourceImpl implements BookRemoteDatasource {
  final http.Client httpClient;

  BookRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<List<BookModel>> fetchAllBooks() async {
    try {
      var url = Uri.parse(Endpoint.fetchBooks);
      var response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body)["docs"];
        var books = fromResponseJson(parsed);
        return books;
      } else {
        throw const ServerException("Invalid response");
      }
    } catch (err) {
      throw ServerException(err.toString());
    }
  }
}
