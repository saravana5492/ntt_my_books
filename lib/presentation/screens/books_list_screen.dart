import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books_ntt/presentation/blocs/bloc/book_bloc.dart';
import 'package:my_books_ntt/presentation/widgets/book_item.dart';

class BooksListScreen extends StatefulWidget {
  const BooksListScreen({super.key});

  @override
  State<BooksListScreen> createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(BookFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Books"),
        centerTitle: false,
      ),
      body: BlocBuilder<BookBloc, BookState>(builder: (context, state) {
        if (state is BookLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookFailure) {
          return Center(
            child: Text(
              key: const Key('books-error'),
              state.message,
            ),
          );
        }

        if (state is BookSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  return BookItem(book: state.books[index]);
                }),
          );
        }

        return Container();
      }),
    );
  }
}
