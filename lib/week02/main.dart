import 'catalogue.dart';
import 'data.dart';
import 'models.dart';
import 'shelf_state.dart';

void main() {
  final library = Library();
  for (final entry in rawBooks) {
    library.add(Book.fromJson(entry));
  }

  print('Titles: ${library.allTitles}');
  print(
      'Books after 2010: ${library.booksAfter2010.map((book) => book.title).toList()}');
  print('Average pages: ${library.averagePages}');
  print('Author counts: ${library.authorCounts}');
  print('Distinct authors: ${library.distinctAuthors}');
  print('Genres: ${library.genres}');
  print('Country of Design Patterns: ${library.countryOf('Design Patterns')}');
  print('Find by title: ${library.findByTitle('Refactoring')}');
  print('Display list: ${library.displayList}');
  print('Stats: ${statsOf(library.books)}');
  print('State Empty: ${describe(const Empty())}');
  print('State Ready: ${describe(Ready(library.books))}');
  print('State Broken: ${describe(const Broken('missing data'))}');
}
