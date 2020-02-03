class News {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  News({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      author: json['author'],
      content: json['content'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      url: json['url'],
      urlToImage: json['urlToImage'],
    );
  }
}
