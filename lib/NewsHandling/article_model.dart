class Article {
  final Source source;
  final String? author; // Author can be nullable
  final String title;
  final String description;
  final String url;
  final String? urlToImage; // URL to image can be nullable
  final DateTime publishedAt;
  final String content;

  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'],
    );
  }
}

class Source {
  final String? id; // ID can be nullable
  final String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ApiResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();

    return ApiResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articleList,
    );
  }
}
