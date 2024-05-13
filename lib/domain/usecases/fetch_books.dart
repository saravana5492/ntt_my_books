import 'package:fpdart/fpdart.dart';
import 'package:my_books_ntt/core/error/failure.dart';
import 'package:my_books_ntt/domain/entities/book.dart';
import 'package:my_books_ntt/domain/repositories/book_repository.dart';

class FetchBooks {
  final BookRepository bookRepository;

  FetchBooks({required this.bookRepository});

  Future<Either<Failure, List<Book>>> execute() async {
    return bookRepository.fetchAllBooks();
  }
}
