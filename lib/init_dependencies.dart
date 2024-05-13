import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_books_ntt/data/datasources/book_remote_datasource.dart';
import 'package:my_books_ntt/data/repositories/book_repository_impl.dart';
import 'package:my_books_ntt/domain/repositories/book_repository.dart';
import 'package:my_books_ntt/domain/usecases/fetch_books.dart';
import 'package:my_books_ntt/presentation/blocs/bloc/book_bloc.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  _initBooks();

  // Http Client
  var httpClient = http.Client();
  serviceLocator.registerLazySingleton(() => httpClient);
}

void _initBooks() {
  // Datasource
  serviceLocator.registerFactory<BookRemoteDatasource>(
    () => BookRemoteDatasourceImpl(
      httpClient: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<BookRepository>(
    () => BookRepositoryImpl(
      remoteDatasource: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerFactory(
    () => FetchBooks(
      bookRepository: serviceLocator(),
    ),
  );

  // BLoC
  serviceLocator.registerFactory(
    () => BookBloc(
      fetchBooks: serviceLocator(),
    ),
  );
}
