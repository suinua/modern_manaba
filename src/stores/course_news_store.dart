
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:html/parser.dart' as html_parser;

import '../models/course_news.dart';

class CourseNewsStore {
  static CourseNewsStore? _instance;
  static StreamController<CourseNews>? _controller;

  CourseNewsStore._internal();

  factory CourseNewsStore() {
    if (_instance == null) {
      _newsList = _getNewsFromStorage();
      _controller = StreamController<CourseNews>();
      _instance = CourseNewsStore._internal();
    }

    return _instance!;
  }

  static List<CourseNews> _newsList = [];

  List<CourseNews> get newsList => _newsList;
  StreamController get controller => _controller!;

  List<CourseNews> getByCourseNumber(String courseNumber) {
    return _newsList.where((news) => news.courseNumber == courseNumber).toList();
  }

  List<CourseNews> getUnreadByCourseNumber(String courseNumber) {
    return _newsList.where((news) => news.courseNumber == courseNumber && !news.read).toList();
  }

  static List<CourseNews> _getNewsFromStorage() {
    return (jsonDecode(window.localStorage['course-news-list'] ?? '[]') as List).map((e) => CourseNews.fromJson(e)).toList();
  }

  Future<void> updateAllNews() async {
    var courseNumbers =
        jsonDecode(window.localStorage['course_room_numbers']!).keys;
    for (String courseNumber in courseNumbers) {
      var res = await window
          .fetch('https://room.chuo-u.ac.jp/ct/course_${courseNumber}_news');
      String text = await res.text();

      var html = html_parser.parse(text);
      var newsElementList = html.querySelectorAll('.newstext');
      if (newsElementList.isEmpty) continue;
      for (var newsElement in newsElementList) {
        _fun() async {
          var newsUrl = 'https://room.chuo-u.ac.jp/ct/' + newsElement.children.first.attributes['href']!;
          var newsId = newsUrl.replaceFirst(RegExp('(.*)news_'), '');

          var res = await window.fetch(newsUrl);
          var text = await res.text();
          var html = html_parser.parse(text!);

          var title = html.querySelector('.msg-title')!.text;
          var body = html.querySelector('.msg-body')!.text;
          var read = !newsElement.classes.contains('unread');

          var news = CourseNews(
              newsId: newsId,
              courseNumber: courseNumber,
              title: title,
              body: body,
              read: read);

          if (!_newsList.contains(news)) {
            _newsList.add(news);
            window.localStorage['course-news-list'] = jsonEncode(_newsList.map((e) => e.toJson()).toList());

            _controller!.sink.add(news);
          }
        }

        _fun();
      }
    }
  }
}
