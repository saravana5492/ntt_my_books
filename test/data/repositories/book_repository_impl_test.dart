import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:my_books_ntt/core/error/exception.dart';
import 'package:my_books_ntt/core/error/failure.dart';
import 'package:my_books_ntt/data/models/book_model.dart';
import 'package:my_books_ntt/data/repositories/book_repository_impl.dart';
import 'package:my_books_ntt/domain/entities/book.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockBookRemoteDatasource mockBookRemoteDatasource;
  late BookRepositoryImpl bookRepositoryImpl;

  List<BookModel> testBooksModel = [
    BookModel(
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
    )
  ];

  List<Book> testBooksEntities = [
    Book(
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
    )
  ];

  setUp(() {
    mockBookRemoteDatasource = MockBookRemoteDatasource();
    bookRepositoryImpl =
        BookRepositoryImpl(remoteDatasource: mockBookRemoteDatasource);
    provideDummy<Either<Failure, List<Book>>>(right(testBooksEntities));
  });

  group('get current books list', () {
    test('should return books when remote data source in success', () async {
      // arrange
      when(mockBookRemoteDatasource.fetchAllBooks())
          .thenAnswer((_) async => testBooksModel);

      // act
      final result = await bookRepositoryImpl.fetchAllBooks();
      final books = result.fold((l) => null, (r) => r);

      // assert
      expect(books, testBooksEntities);
    });

    test('should return server failure when data source is not success',
        () async {
      // arrange
      when(mockBookRemoteDatasource.fetchAllBooks())
          .thenThrow(const ServerException('Invalid response'));

      // act
      final result = await bookRepositoryImpl.fetchAllBooks();

      // assert
      expect(result,
          equals(left<Failure, List<Book>>(const Failure("Invalid response"))));
    });
  });
}
