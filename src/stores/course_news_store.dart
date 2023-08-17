
import '../models/course_news.dart';
import '../services/course_news_service.dart';

class CourseNewsStore {
  static CourseNewsStore? _instance;

  CourseNewsStore._internal(this._newsList);

  static Future<void> _init() async {
    _instance ??= CourseNewsStore._internal(await CourseNewsService.fetchAllNews());
  }

  static Future<CourseNewsStore> instance() async {
    await _init();
    return _instance!;
  }

  final List<CourseNews> _newsList;

  List<CourseNews> get newsList => _newsList;
}
