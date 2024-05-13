import 'package:fpdart/fpdart.dart';
import 'package:my_books_ntt/core/error/exception.dart';
import 'package:my_books_ntt/core/error/failure.dart';
import 'package:my_books_ntt/core/network/internet_checker.dart';
import 'package:my_books_ntt/data/datasources/book_remote_datasource.dart';
import 'package:my_books_ntt/domain/entities/book.dart';
import 'package:my_books_ntt/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDatasource remoteDatasource;

  BookRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<Book>>> fetchAllBooks() async {
    try {
      if (!await InternetChecker.isInternetConnected()) {
        return left(const Failure("Internet connection appears to be offline"));
      }
      final bookModels = await remoteDatasource.fetchAllBooks();
      final bookEntities = bookModels.map((e) => e.toEntity()).toList();
      return right(bookEntities);
    } on ServerException catch (err) {
      return left(Failure(err.message));
    }
  }
}
