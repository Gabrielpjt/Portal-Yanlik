# 🚀 Search API Integration - Quick Start

Panduan cepat menggunakan Search API yang sudah terintegrasi.

## ⚡ 5 Menit Quick Start

### 1. Import Dependencies

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_layanan_publik_mobile/core/network/api_client.dart';
import 'package:portal_layanan_publik_mobile/features/search/data/datasources/search_remote_datasource.dart';
import 'package:portal_layanan_publik_mobile/features/search/data/repositories/search_repository_impl.dart';
import 'package:portal_layanan_publik_mobile/features/search/presentation/bloc/search_bloc.dart';
import 'package:portal_layanan_publik_mobile/features/search/presentation/bloc/search_event.dart';
import 'package:portal_layanan_publik_mobile/features/search/presentation/bloc/search_state.dart';
```

### 2. Initialize Search (Sudah di SearchPage)

```dart
// Di initState SearchPage
final apiClient = ApiClient();
final remoteDatasource = SearchRemoteDatasource(apiClient);
final repository = SearchRepositoryImpl(remoteDatasource);
_searchBloc = SearchBloc(repository);
```

### 3. Perform Search

```dart
// Search semua tipe
_searchBloc.add(SearchAllEvent('KTP'));

// Search spesifik
_searchBloc.add(SearchLayananEvent('KTP', page: 1, limit: 10));
_searchBloc.add(SearchFaqEvent('cara membuat'));
_searchBloc.add(SearchFasyankesEvent('Rumah Sakit'));
```

### 4. Listen to Results

```dart
BlocBuilder<SearchBloc, SearchState>(
  builder: (context, state) {
    if (state is SearchLoading) {
      return CircularProgressIndicator();
    }
    
    if (state is SearchSuccess) {
      return ListView.builder(
        itemCount: state.filteredResults.length,
        itemBuilder: (context, index) {
          final result = state.filteredResults[index];
          return ListTile(
            title: Text(result.title),
            subtitle: Text(result.description),
          );
        },
      );
    }
    
    if (state is SearchError) {
      return Text('Error: ${state.message}');
    }
    
    return Text('Start searching...');
  },
)
```

## 🎯 Use Cases

### Use Case 1: Basic Search

```dart
// User types in search box
void _onSearchSubmitted(String query) {
  _searchBloc.add(SearchAllEvent(query));
}

// Display results
BlocBuilder<SearchBloc, SearchState>(
  builder: (context, state) {
    if (state is SearchSuccess) {
      return Text('Found ${state.results.length} results');
    }
    return SizedBox.shrink();
  },
)
```

### Use Case 2: Filter by Category

```dart
// User selects filter
void _onFilterSelected(String filterKey) {
  SearchFilter filter;
  switch (filterKey) {
    case 'layanan':
      filter = SearchFilter.layanan;
      break;
    case 'informasi':
      filter = SearchFilter.informasiLayanan;
      break;
    case 'faq':
      filter = SearchFilter.faq;
      break;
    case 'fasyankes':
      filter = SearchFilter.fasyankes;
      break;
    default:
      filter = SearchFilter.all;
  }
  
  _searchBloc.add(ChangeSearchFilterEvent(filter));
}

// Display filtered results
if (state is SearchSuccess) {
  final filteredResults = state.filteredResults;
  // Display filteredResults
}
```

### Use Case 3: Search with Pagination

```dart
// Load more results
void _loadMore(int page) {
  final currentQuery = _searchController.text;
  _searchBloc.add(SearchLayananEvent(
    currentQuery,
    page: page,
    limit: 10,
  ));
}

// Append results
BlocListener<SearchBloc, SearchState>(
  listener: (context, state) {
    if (state is SearchSuccess) {
      // Append to existing list
      _results.addAll(state.results);
    }
  },
  child: YourWidget(),
)
```

### Use Case 4: Clear Search

```dart
// User clears search
void _onClearSearch() {
  _searchController.clear();
  _searchBloc.add(ClearSearchEvent());
}
```

## 📊 Working with Results

### Access Different Result Types

```dart
if (state is SearchSuccess) {
  // All results
  final allResults = state.results;
  
  // By type
  final layananResults = state.layananResults;
  final infoResults = state.informasiLayananResults;
  final faqResults = state.faqResults;
  final fasyankesResults = state.fasyankesResults;
  
  // Filtered by current filter
  final filtered = state.filteredResults;
  
  // Check empty
  final isEmpty = state.isEmpty;
  final isFilteredEmpty = state.isFilteredEmpty;
}
```

### Display Result Card

```dart
Widget _buildResultCard(SearchResultEntity result) {
  return SearchResultCard(
    category: _getCategoryName(result),
    title: result.title,
    location: _getLocation(result),
    lastUpdated: 'Baru saja',
    description: result.description,
    onTap: () => _onResultTap(result),
  );
}

String _getCategoryName(SearchResultEntity result) {
  switch (result.type) {
    case SearchResultType.layanan:
      return 'Layanan';
    case SearchResultType.informasiLayanan:
      return 'Informasi Layanan';
    case SearchResultType.faq:
      return 'FAQ';
    case SearchResultType.fasyankes:
      return 'Fasilitas Kesehatan';
  }
}
```

## 🎨 UI Examples

### Search Bar with Live Search

```dart
TextField(
  controller: _searchController,
  decoration: InputDecoration(
    hintText: 'Cari layanan, informasi...',
    suffixIcon: IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        final query = _searchController.text;
        _searchBloc.add(SearchAllEvent(query));
      },
    ),
  ),
  onSubmitted: (query) {
    _searchBloc.add(SearchAllEvent(query));
  },
)
```

### Filter Chips

```dart
Wrap(
  spacing: 8,
  children: [
    FilterChip(
      label: Text('Semua (${state.results.length})'),
      selected: state.currentFilter == SearchFilter.all,
      onSelected: (_) {
        _searchBloc.add(ChangeSearchFilterEvent(SearchFilter.all));
      },
    ),
    FilterChip(
      label: Text('Layanan (${state.layananResults.length})'),
      selected: state.currentFilter == SearchFilter.layanan,
      onSelected: (_) {
        _searchBloc.add(ChangeSearchFilterEvent(SearchFilter.layanan));
      },
    ),
    // ... more filters
  ],
)
```

### Loading Indicator

```dart
if (state is SearchLoading)
  Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Mencari...'),
      ],
    ),
  )
```

### Empty State

```dart
if (state is SearchEmpty)
  Center(
    child: Column(
      children: [
        Icon(Icons.search_off, size: 64),
        SizedBox(height: 16),
        Text('Tidak ditemukan hasil untuk "${state.query}"'),
        SizedBox(height: 8),
        Text('Coba kata kunci lain'),
      ],
    ),
  )
```

### Error State

```dart
if (state is SearchError)
  Center(
    child: Column(
      children: [
        Icon(Icons.error_outline, size: 64, color: Colors.red),
        SizedBox(height: 16),
        Text(state.message),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _searchBloc.add(SearchAllEvent(_lastQuery)),
          child: Text('Coba Lagi'),
        ),
      ],
    ),
  )
```

## 🔧 Advanced Usage

### Debounced Search

```dart
import 'dart:async';

Timer? _debounce;

void _onSearchChanged(String query) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  
  _debounce = Timer(const Duration(milliseconds: 500), () {
    if (query.isNotEmpty) {
      _searchBloc.add(SearchAllEvent(query));
    }
  });
}

@override
void dispose() {
  _debounce?.cancel();
  super.dispose();
}
```

### Search History

```dart
class SearchHistory {
  static const _key = 'search_history';
  static const _maxHistory = 10;
  
  static Future<void> addSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_key) ?? [];
    
    // Remove if exists
    history.remove(query);
    
    // Add to front
    history.insert(0, query);
    
    // Limit size
    if (history.length > _maxHistory) {
      history = history.sublist(0, _maxHistory);
    }
    
    await prefs.setStringList(_key, history);
  }
  
  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
```

### Search Suggestions

```dart
Widget _buildSuggestions() {
  return FutureBuilder<List<String>>(
    future: SearchHistory.getHistory(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return SizedBox.shrink();
      
      final history = snapshot.data!;
      
      return ListView.builder(
        shrinkWrap: true,
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text(history[index]),
            onTap: () {
              _searchController.text = history[index];
              _searchBloc.add(SearchAllEvent(history[index]));
            },
          );
        },
      );
    },
  );
}
```

## 🧪 Testing

### Unit Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('SearchBloc', () {
    late SearchBloc searchBloc;
    late MockSearchRepository mockRepository;

    setUp(() {
      mockRepository = MockSearchRepository();
      searchBloc = SearchBloc(mockRepository);
    });

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchSuccess] when search succeeds',
      build: () {
        when(() => mockRepository.searchAll('test'))
            .thenAnswer((_) async => [mockLayananResult]);
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchAllEvent('test')),
      expect: () => [
        SearchLoading(),
        SearchSuccess(
          results: [mockLayananResult],
          currentFilter: SearchFilter.all,
          query: 'test',
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchEmpty] when no results',
      build: () {
        when(() => mockRepository.searchAll('xyz'))
            .thenAnswer((_) async => []);
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchAllEvent('xyz')),
      expect: () => [
        SearchLoading(),
        SearchEmpty('xyz'),
      ],
    );
  });
}
```

## 📝 Best Practices

### 1. Always Check State Type

```dart
// ✅ Good
if (state is SearchSuccess) {
  final results = state.results;
}

// ❌ Bad
final results = (state as SearchSuccess).results; // Can crash!
```

### 2. Handle All States

```dart
// ✅ Good
Widget build(BuildContext context) {
  return BlocBuilder<SearchBloc, SearchState>(
    builder: (context, state) {
      if (state is SearchLoading) return LoadingWidget();
      if (state is SearchSuccess) return ResultsWidget(state.results);
      if (state is SearchError) return ErrorWidget(state.message);
      if (state is SearchEmpty) return EmptyWidget();
      return InitialWidget();
    },
  );
}
```

### 3. Dispose Bloc

```dart
@override
void dispose() {
  _searchBloc.close(); // Important!
  super.dispose();
}
```

### 4. Use Const Constructors

```dart
// ✅ Good
const SearchAllEvent('query')
const SearchFilter.all

// ❌ Bad  
SearchAllEvent('query')
SearchFilter.all
```

## 🐛 Common Issues

### Issue 1: "State not updating"

**Solution**: Make sure you're using `BlocProvider.value` or `BlocBuilder`

```dart
// ✅ Correct
BlocProvider.value(
  value: _searchBloc,
  child: YourWidget(),
)
```

### Issue 2: "Duplicate results"

**Solution**: Clear previous results before new search

```dart
// Add clear event before search
_searchBloc.add(ClearSearchEvent());
_searchBloc.add(SearchAllEvent(query));
```

### Issue 3: "API timeout"

**Solution**: Increase timeout in `AppConfig`

```dart
// lib/app/config/app_config.dart
int get apiTimeout => 60000; // 60 seconds
```

## 📚 Next Steps

1. ✅ Basic search implemented
2. ✅ Filter implemented
3. ⏳ Add pagination
4. ⏳ Add sort
5. ⏳ Add debounce
6. ⏳ Add search history
7. ⏳ Add navigation to details

## 🔗 Resources

- [Full README](README.md) - Complete documentation
- [BLoC Pattern](https://bloclibrary.dev) - State management
- [API Docs](http://217.217.254.139:4003/docs) - API endpoints

---

**Ready to search!** 🔍✨

Gunakan SearchPage yang sudah terintegrasi atau buat custom search widget sendiri!
