part of 'book_bloc.dart';

@immutable
sealed class BookState extends Equatable {
  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookFailure extends BookState {
  final String message;
  BookFailure({required this.message});
}

final class BookSuccess extends BookState {
  final List<Book> books;
  BookSuccess({required this.books});
}
