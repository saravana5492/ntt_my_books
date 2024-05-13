import 'package:flutter/material.dart';
import 'package:my_books_ntt/core/theme/color.dart';
import 'package:my_books_ntt/core/utils/array_to_string.dart';
import 'package:my_books_ntt/domain/entities/book.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 10),
      height: 160,
      width: MediaQuery.of(context).size.width - 40,
      decoration: const BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title ?? "Book title",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 10),
            Text(
              "Authors: ${arrayToString(book.authorName ?? [], ", ")}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 10),
            Text(
              "Publishers: ${arrayToString(book.publisher ?? [], ", ")}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Wrap(
              children: [
                if (book.firstPublishYear != null)
                  Chip(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    label: Text("${book.firstPublishYear!}"),
                  ),
                const SizedBox(width: 12),
                if (book.type != null)
                  Chip(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    label: Text(book.type!.toUpperCase()),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
