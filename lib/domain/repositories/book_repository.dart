import 'package:fpdart/fpdart.dart';
import 'package:my_books_ntt/core/error/failure.dart';
import 'package:my_books_ntt/domain/entities/book.dart';

abstract interface class BookRepository {
  Future<Either<Failure, List<Book>>> fetchAllBooks();
}
