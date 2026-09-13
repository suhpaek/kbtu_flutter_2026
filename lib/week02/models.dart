enum Genre {
  craft('Craft'),
  theory('Theory'),
  unknown('Unknown');

  const Genre(this.label);

  final String label;

  static Genre fromString(String? raw) {
    final value = raw?.trim().toLowerCase();
    for (final item in Genre.values) {
      if (item.name.toLowerCase() == value) {
        return item;
      }
    }
    return Genre.unknown;
  }
}

class Author {
  final String name;
  final String? country;

  const Author({required this.name, this.country});

  @override
  String toString() {
    return 'Author{name: $name, country: $country}';
  }
}

abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({required this.title, required this.year});

  String describe();

  bool get isOld => year < 2000;
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final title =
        json['title'] is String ? json['title'] as String : 'Unknown Title';
    final year = json['year'] is int
        ? json['year'] as int
        : json['year'] is num
            ? (json['year'] as num).toInt()
            : 0;
    final pages = json['pages'] is int
        ? json['pages'] as int
        : json['pages'] is num
            ? (json['pages'] as num).toInt()
            : 0;
    final authorName =
        json['author'] is String ? json['author'] as String : 'Unknown Author';
    final country =
        json['country'] is String ? json['country'] as String : null;

    return Book(
      title: title,
      year: year,
      pages: pages,
      author: Author(name: authorName, country: country),
      genre: Genre.fromString(
          json['genre'] is String ? json['genre'] as String : null),
      description:
          json['description'] is String ? json['description'] as String : null,
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String describe() {
    return '${title} by ${author.name} (${year})';
  }

  @override
  String toString() {
    return 'Book{title: $title, year: $year, pages: $pages, author: ${author.name}, genre: ${genre.label}, description: $description, isLong: $isLong}';
  }
}

class Magazine extends LibraryItem {
  final int issue;

  const Magazine({
    required super.title,
    required super.year,
    required this.issue,
  });

  @override
  String describe() {
    return '$title issue $issue (${year})';
  }
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrow $title';
}

class Ghost implements LibraryItem {
  @override
  final String title;

  @override
  final int year;

  const Ghost({required this.title, required this.year});

  @override
  String describe() {
    return '$title from $year';
  }

  @override
  bool get isOld => year < 2000;
}
