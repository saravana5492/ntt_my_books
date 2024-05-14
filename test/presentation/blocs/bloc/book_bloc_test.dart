import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:my_books_ntt/core/error/failure.dart';
import 'package:my_books_ntt/domain/entities/book.dart';
import 'package:my_books_ntt/presentation/blocs/bloc/book_bloc.dart';

import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockFetchBooks mockFetchAllBooksUseCase;
  late BookBloc bookBloc;

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
    mockFetchAllBooksUseCase = MockFetchBooks();
    bookBloc = BookBloc(fetchBooks: mockFetchAllBooksUseCase);
    provideDummy<Either<Failure, List<Book>>>(right(testBooksEntity));
  });

  test('initial state should be intial', () {
    // assert
    expect(bookBloc.state, BookInitial());
  });

  blocTest<BookBloc, BookState>(
    'should emit [BookLoading, BookSuccess] when get data successfully',
    build: () {
      when(mockFetchAllBooksUseCase.execute())
          .thenAnswer((_) async => right(testBooksEntity));
      return bookBloc;
    },
    act: (bloc) => bloc.add(BookFetchEvent()),
    wait: const Duration(microseconds: 500),
    expect: () =>
        <BookState>[BookLoading(), BookSuccess(books: testBooksEntity)],
  );

  blocTest<BookBloc, BookState>(
    'should emit [BookLoading, BookFailure] when get data successfully',
    build: () {
      when(mockFetchAllBooksUseCase.execute())
          .thenAnswer((_) async => left(const Failure("Server failure")));
      return bookBloc;
    },
    act: (bloc) => bloc.add(BookFetchEvent()),
    wait: const Duration(microseconds: 500),
    expect: () =>
        <BookState>[BookLoading(), BookFailure(message: "Server failure")],
  );
}
