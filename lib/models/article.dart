    List<Article> articleFromJson(List<dynamic> article) =>
      List<Article>.from(article.map((x) => Article.fromJson(x)));
    
    class Article {
      Article({
       required this.title,
       required this.description,
       required this.image,
       required this.createdAt,
       required this.updatedAt,
       required this.id,
      });
    
      String title;
      DateTime createdAt;
      String description;
      String image;
      int id;
      DateTime updatedAt;
    
      factory Article.fromJson(Map<dynamic, dynamic> json) {
       return Article(
         title: json['title'],
         description: json['description'],
         image: json['image'],
         createdAt: DateTime.parse(json['createdAt']),
         id: json['id'],
         updatedAt: DateTime.parse(json['updatedAt']));
      }
    }