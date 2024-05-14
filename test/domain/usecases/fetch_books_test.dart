import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_books_ntt/core/error/failure.dart';
import 'package:my_books_ntt/domain/entities/book.dart';
import 'package:my_books_ntt/domain/usecases/fetch_books.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late FetchBooks fetchAllBooksUseCase;
  late MockBookRepository mockBookRepository;

  List<Book> testBooksEntity = [
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
    mockBookRepository = MockBookRepository();
    fetchAllBooksUseCase = FetchBooks(bookRepository: mockBookRepository);
    provideDummy<Either<Failure, List<Book>>>(right(testBooksEntity));
  });

  test('should get list of books from the repository', () async {
    // arrange
    when(mockBookRepository.fetchAllBooks())
        .thenAnswer((_) async => right(testBooksEntity));

    // act
    final result = await fetchAllBooksUseCase.execute();

    // assert
    expect(result, right(testBooksEntity));
  });
}
