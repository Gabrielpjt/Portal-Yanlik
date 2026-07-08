# Search Feature - API Integration

Complete API integration for search functionality following Clean Architecture pattern.

## 📁 Structure

```
search/
├── data/
│   ├── datasources/
│   │   └── search_remote_datasource.dart     # API calls
│   ├── models/
│   │   └── search_result_model.dart          # Data models
│   └── repositories/
│       └── search_repository_impl.dart        # Repository implementation
├── domain/
│   ├── entities/
│   │   └── search_result_entity.dart         # Domain entities
│   └── repositories/
│       └── search_repository.dart             # Repository interface
└── presentation/
    ├── bloc/
    │   ├── search_bloc.dart                   # Business logic
    │   ├── search_event.dart                  # Events
    │   └── search_state.dart                  # States
    ├── pages/
    │   └── search_page.dart                   # Search UI with Bloc
    └── widgets/
        ├── search_header.dart
        └── search_result_card.dart
```

## 🔌 API Endpoints

Base URL: `http://217.217.254.139:4002`

### 1. Search Layanan
```
GET /publik/layanan?q={keyword}&page={page}&limit={limit}
```

### 2. Search Informasi Layanan
```
GET /publik/informasi-layanan?q={keyword}&page={page}&limit={limit}
```

### 3. Search FAQ
```
GET /publik/faq?q={keyword}&page={page}&limit={limit}
```

### 4. Search Fasyankes
```
GET /publik/fasyankes?q={keyword}&page={page}&limit={limit}&jenis_sarana={type}
```

## 🎯 Features

### Search Types

- **Search All**: Search across all content types (Layanan, Informasi Layanan, FAQ, Fasyankes)
- **Search Layanan**: Search services only
- **Search Informasi Layanan**: Search service information only
- **Search FAQ**: Search frequently asked questions only
- **Search Fasyankes**: Search health facilities only

### Filter Options

- All Results
- Layanan only
- Informasi Layanan only
- FAQ only
- Fasyankes only

### State Management

Using **BLoC pattern** for:
- Loading states
- Success with results
- Empty results
- Error handling
- Filter changes

## 📝 Usage Example

### Basic Search

```dart
// Initialize dependencies
final apiClient = ApiClient();
final remoteDatasource = SearchRemoteDatasource(apiClient);
final repository = SearchRepositoryImpl(remoteDatasource);
final searchBloc = SearchBloc(repository);

// Perform search
searchBloc.add(SearchAllEvent('KTP'));

// Listen to results
searchBloc.stream.listen((state) {
  if (state is SearchSuccess) {
    print('Found ${state.results.length} results');
  }
});
```

### Filter Results

```dart
// Change filter
searchBloc.add(ChangeSearchFilterEvent(SearchFilter.layanan));

// Access filtered results
if (state is SearchSuccess) {
  final layananOnly = state.layananResults;
  final faqOnly = state.faqResults;
}
```

### Search Specific Type

```dart
// Search layanan only
searchBloc.add(SearchLayananEvent('KTP', page: 1, limit: 10));

// Search FAQ only
searchBloc.add(SearchFaqEvent('cara membuat', page: 1, limit: 10));

// Search Fasyankes with filter
searchBloc.add(SearchFasyankesEvent(
  'Rumah Sakit',
  jenisSarana: 'RUMAH_SAKIT',
));
```

## 🧪 Testing

### Test API Connection

```dart
void main() async {
  final apiClient = ApiClient();
  final datasource = SearchRemoteDatasource(apiClient);
  
  try {
    final results = await datasource.searchLayanan('KTP');
    print('Success: ${results.length} results');
  } catch (e) {
    print('Error: $e');
  }
}
```

## 🔧 Configuration

### API Timeout

Edit `lib/app/config/app_config.dart`:

```dart
int get apiTimeout => 30000; // 30 seconds
```

### Base URL

Edit `lib/app/config/app_config.dart`:

```dart
String get baseUrl {
  return 'http://217.217.254.139:4002';
}
```

## 📊 Response Format

### API Response Structure

```json
{
  "success": true,
  "code": 200,
  "message": "Berhasil",
  "data": [
    {
      "id": 1,
      "nama": "Pembuatan KTP",
      "deskripsi": "Layanan pembuatan KTP elektronik",
      "ikon_layanan": "icon.png",
      "status": "PUBLISHED"
    }
  ]
}
```

### Pagination Support

```json
{
  "data": {
    "items": [...],
    "meta": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 50
    }
  }
}
```

## 🎨 UI Components

### Search Page States

1. **Initial**: Empty search, show placeholder
2. **Loading**: Show loading indicator
3. **Success**: Display results with filters
4. **Empty**: No results found message
5. **Error**: Error message with retry button

### Filter Chips

- Show count for each category
- Highlight active filter
- Update results on filter change

## 🚀 Performance

### Optimization

- Debounce search input (500ms)
- Cache recent searches
- Lazy load results on scroll
- Parallel API calls for "Search All"

### Best Practices

```dart
// Debounce search
Timer? _debounce;

void _onSearchChanged(String query) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    _searchBloc.add(SearchAllEvent(query));
  });
}
```

## 🐛 Troubleshooting

### Common Issues

**1. No results returned**
- Check API baseUrl in AppConfig
- Verify network connection
- Check API logs in console

**2. Timeout errors**
- Increase timeout in AppConfig
- Check server availability
- Verify endpoint URL

**3. Parse errors**
- Check API response format
- Verify model mappings
- Enable debug logging

### Debug Mode

Enable detailed logs:

```dart
// In search_remote_datasource.dart
Logger.log('API Response: $response', tag: 'SearchAPI');
```

## 📖 Related Documentation

- [API Swagger Documentation](http://217.217.254.139:4003/docs)
- [Clean Architecture Guide](../../README.md)
- [BLoC Pattern](https://bloclibrary.dev)

## ✅ Checklist

Integration complete when:

- [x] All entities defined
- [x] All models created
- [x] Remote datasource implemented
- [x] Repository implemented
- [x] BLoC created (events, states, bloc)
- [x] UI integrated with BLoC
- [x] Error handling implemented
- [x] Loading states handled
- [x] Empty states handled
- [x] Filters working
- [ ] Pagination working (TODO)
- [ ] Sort working (TODO)
- [ ] Navigation to details (TODO)

## 🔜 Next Steps

1. Implement pagination
2. Add sort functionality
3. Add navigation to detail pages
4. Add search history/suggestions
5. Add debounce to search input
6. Add unit tests
7. Add integration tests

---

**Created**: July 2, 2026  
**API Version**: 2.0  
**Status**: ✅ Complete (Basic Integration)
