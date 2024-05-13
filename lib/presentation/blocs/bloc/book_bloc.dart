import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books_ntt/domain/entities/book.dart';
import 'package:my_books_ntt/domain/usecases/fetch_books.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final FetchBooks _fetchBooks;
  BookBloc({required FetchBooks fetchBooks})
      : _fetchBooks = fetchBooks,
        super(BookInitial()) {
    on<BookFetchEvent>(_fetchBooksCall);
  }

  void _fetchBooksCall(BookFetchEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final res = await _fetchBooks.execute();
    res.fold(
      (failure) => emit(BookFailure(message: failure.message)),
      (books) => emit(BookSuccess(books: books)),
    );
  }
}
