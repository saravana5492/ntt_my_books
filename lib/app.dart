import 'package:flutter/material.dart';
import 'package:my_books_ntt/core/theme/theme.dart';
import 'package:my_books_ntt/presentation/screens/books_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Books',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeData,
      home: const BooksListScreen(),
    );
  }
}
