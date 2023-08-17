class CourseNews {
  final String newsId;
  final String courseNumber;
  final String title;
  final String body;
  final bool read;

  CourseNews(
      {required this.newsId,
      required this.courseNumber,
      required this.title,
      required this.body,
      required this.read});

  Map toJson() {
    return {
      'news_id': newsId,
      'course_number': courseNumber,
      'title': title,
      'body': body,
      'read': read
    };
  }

  CourseNews.fromJson(Map json)
      : newsId = json['news_id'],
        courseNumber = json['course_number'],
        title = json['title'],
        body = json['body'],
        read = json['read'];

  @override
  bool operator ==(Object other) {
    if (other is CourseNews) {
      return other.newsId == newsId;
    }

    return false;
  }
}
