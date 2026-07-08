/// Wraps a paginated API response.
///
/// Use this when an endpoint returns a list of items with page metadata.
///
/// ```dart
/// final paginated = PaginatedResponse<PostModel>(
///   items: [post1, post2],
///   currentPage: 1,
///   totalPages: 5,
///   totalItems: 50,
/// );
/// ```
class PaginatedResponse<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    bool? hasNextPage,
  }) : hasNextPage = hasNextPage ?? (currentPage < totalPages);
}
