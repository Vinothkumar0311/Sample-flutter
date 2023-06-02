class Comments {
  int? id;
  String? title;
  int? postId;

  Comments({
    required this.id,
    required this.title,
    required this.postId,
  });

  factory Comments.formJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      title: json['body'],
      postId: json['postId'],
    );
  }
}

class PostValue {
  int? id;
  String? title;

  PostValue({
    required this.id,
    required this.title,
  });

  factory PostValue.formJson(Map<String, dynamic> json) {
    return PostValue(
      id: json['id'],
      title: json['title'],
    );
  }
}
