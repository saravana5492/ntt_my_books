class Endpoint {
  static const String _baseUrl = "https://openlibrary.org/search.json?";

  static const String fetchBooks =
      "${_baseUrl}q=crime+and+punishment&fields=key,title,author_name,first_publish_year,publisher,type";
}
