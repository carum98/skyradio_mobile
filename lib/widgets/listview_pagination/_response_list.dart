part of 'sk_listview_pagination.dart';

class ResponsePagination<T> {
  final List<T> items;
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  ResponsePagination({
    required this.items,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory ResponsePagination.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    final items =
        json['data'].map<T>((item) => fromJson(item)).toList() as List<T>;

    return ResponsePagination(
      items: items,
      page: json['pagination']['page'],
      perPage: json['pagination']['per_page'],
      total: json['pagination']['total'],
      totalPages: json['pagination']['total_pages'],
    );
  }
}
