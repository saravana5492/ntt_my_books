import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:my_books_ntt/core/error/exception.dart';
import 'package:my_books_ntt/core/network/netwrok_constants.dart';
import 'package:my_books_ntt/data/datasources/book_remote_datasource.dart';
import 'package:my_books_ntt/data/models/book_model.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late BookRemoteDatasourceImpl bookRemoteDatasourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    bookRemoteDatasourceImpl =
        BookRemoteDatasourceImpl(httpClient: mockHttpClient);
  });

  group('get books list', () {
    test('should return books list when the response code is 200', () async {
      // arrange
      var responseJson = """
        {
          "docs": [
           {
              "author_name": [
                "Crime and Punishment"
              ],
              "first_publish_year": 1866,
              "key": "/works/OL166894W",
              "publisher": [
                "LibriVox"
              ],
              "title": "Crime and Punishment",
              "type": "work"
            },
            {
              "author_name": [
                "Crime and Punishment"
              ],
              "first_publish_year": 2009,
              "key": "/works/OL24574391W",
              "publisher": [
                "Xist Publishing"
              ],
              "title": "Crime and Punishment",
              "type": "work"
            },
            {
              "author_name": [
                "Crime and Punishment"
              ],
              "first_publish_year": 2013,
              "key": "/works/OL21809822W",
              "publisher": [
                "Independently Published"
              ],
              "title": "Crime and Punishment",
              "type": "work"
            }
          ]
        }
      """;

      when(mockHttpClient.get(Uri.parse(Endpoint.fetchBooks)))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // act
      final result = await bookRemoteDatasourceImpl.fetchAllBooks();

      // assert
      expect(result, isA<List<BookModel>>());
    });

    test(
        'should throw a server execption when the status code is 200 and invalid response',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Endpoint.fetchBooks)))
          .thenAnswer((_) async => http.Response('', 200));

      // act
      final result = bookRemoteDatasourceImpl.fetchAllBooks();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });

    test('should throw a server execption when the status code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Endpoint.fetchBooks)))
          .thenAnswer((_) async => http.Response("Not found.", 404));

      // act
      final result = bookRemoteDatasourceImpl.fetchAllBooks();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
