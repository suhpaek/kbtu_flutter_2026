import 'models.dart';

class Library {
  final List<LibraryItem> items;

  Library({List<LibraryItem>? items}) : items = items ?? <LibraryItem>[];

  void add(LibraryItem item) {
    items.add(item);
  }

  List<Book> get books => items.whereType<Book>().toList();

  Book? findByTitle(String title) {
    final matches = books.where((book) => book.title == title);
    return matches.isEmpty ? null : matches.first;
  }

  String countryOf(String title) {
    final match = items.whereType<Book>().firstWhere(
          (book) => book.title == title,
          orElse: () => const Book(
            title: '',
            year: 0,
            pages: 0,
            author: Author(name: '', country: null),
            genre: Genre.unknown,
          ),
        );
    return match.author.country ?? 'unknown';
  }

  late final DateTime openedAt;

  void open() {
    openedAt = DateTime.now();
  }

  String? _cachedReport;

  String get report {
    return _cachedReport ??= _buildReport();
  }

  String _buildReport() {
    final titles = allTitles.join(', ');
    return 'Library report: $titles';
  }

  List<String> get allTitles => items.map((item) => item.title).toList();

  List<Book> get booksAfter2010 =>
      books.where((book) => book.year > 2010).toList();

  double get averagePages {
    return books.isEmpty
        ? 0
        : books.fold<int>(0, (sum, book) => sum + book.pages) / books.length;
  }

  Map<String, int> get authorCounts => Map<String, int>.fromEntries(
        books.map(
          (book) => MapEntry(
            book.author.name,
            books
                .where((entry) => entry.author.name == book.author.name)
                .length,
          ),
        ),
      );

  Set<String> get distinctAuthors =>
      books.map((book) => book.author.name).toSet();

  Set<Genre> get genres => books.map((book) => book.genre).toSet();

  List<String> get displayList => <String>[
        'CATALOGUE',
        ...books.map((book) => '${book.title} (${book.year})'),
        ...distinctAuthors,
        if (books.any((book) => book.pages == 0)) '(incomplete data)',
      ];
}
