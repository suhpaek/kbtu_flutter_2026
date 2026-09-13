import 'models.dart';

sealed class ShelfState {
  const ShelfState();
}

class Empty extends ShelfState {
  const Empty();
}

class Ready extends ShelfState {
  final List<Book> books;

  const Ready(this.books);
}

class Broken extends ShelfState {
  final String message;

  const Broken(this.message);
}

String describe(ShelfState state) {
  return switch (state) {
    Empty() => 'Empty shelf',
    Ready(books: final items) => 'Ready: ${items.length} books',
    Broken(message: final text) => 'Broken: $text',
  };
}

({int count, double avgPages}) statsOf(List<Book> books) {
  final count = books.length;
  final avgPages = count == 0
      ? 0.0
      : books.fold<int>(0, (sum, book) => sum + book.pages) / count;
  return (count: count, avgPages: avgPages);
}
