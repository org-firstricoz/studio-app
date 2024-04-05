import 'package:flutter_riverpod_base/src/core/type_def.dart';

abstract class SearchViewRepository {
  FutureEither<Map<String, dynamic>> getSearchResults(String searchTerm);
}
