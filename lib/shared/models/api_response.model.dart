import 'character.model.dart';

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json['count'] as int,
    pages: json['pages'] as int,
    next: json['next'] as String?,
    prev: json['prev'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    'pages': pages,
    'next': next,
    'prev': prev,
  };
}

class ApiResponse {
  final Info info;
  final List<CharacterModel> results;

  ApiResponse({required this.info, required this.results});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    info: Info.fromJson(json['info'] as Map<String, dynamic>),
    results: (json['results'] as List<dynamic>)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'info': info.toJson(),
    'results': results.map((r) => r.toJson()).toList(),
  };
}
