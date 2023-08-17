import 'dart:convert';
import 'dart:html';
import 'package:html/parser.dart' as html_parser;

import '../models/course_news.dart';

class CourseNewsService {
  static Future<List<CourseNews>> fetchAllNews() async {
    var courseNewsList = <CourseNews>[];
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
        var newsUrl = 'https://room.chuo-u.ac.jp/ct/' + newsElement.children.first.attributes['href']!;
        var newsId = newsUrl.replaceFirst(RegExp('(.*)news_'), '');

        var res = await window.fetch(newsUrl);
        var text = await res.text();
        var html = html_parser.parse(text!);

        var title = html.querySelector('.msg-title')!.text;
        var body = html.querySelector('.msg-body')!.text;
        var read = !newsElement.classes.contains('unread');

        courseNewsList.add(CourseNews(
            newsId: newsId,
            courseNumber: courseNumber,
            title: title,
            body: body,
            read: read));
      }
    }

    return courseNewsList;
  }
}
