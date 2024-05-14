import "package:mockito/annotations.dart";
import "package:http/http.dart" as http;
import "package:my_books_ntt/data/datasources/book_remote_datasource.dart";
import "package:my_books_ntt/domain/repositories/book_repository.dart";
import "package:my_books_ntt/domain/usecases/fetch_books.dart";

@GenerateMocks([
  BookRepository,
  BookRemoteDatasource,
  FetchBooks
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}
