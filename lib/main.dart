import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books_ntt/app.dart';
import 'package:my_books_ntt/init_dependencies.dart';
import 'package:my_books_ntt/presentation/blocs/bloc/book_bloc.dart';

void main() {
  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<BookBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
