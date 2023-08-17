import 'dart:html';

import '../models/course.dart';
import '../stores/calendar_store.dart';
import '../stores/course_news_store.dart';

class SideBar {
  static Future<String> html()  async {
    var calendarStore = await CalendarStore.instance();
    var courseNewsStore = await CourseNewsStore.instance();

    var newBindHtml = '';
    var newsListHtml = '';
    calendarStore.calendar.allCourses().forEach((course) {
      if (course is! FreeTime) {
        var newsList = courseNewsStore.getByCourseNumber(course.number);
        newBindHtml += '''
        <div class="m-news-bind" id="m-news-bind-${course.number}">
          <div class="m-news-course-name">${course.name}</div>
          <div class="m-last-news-title">${newsList.isEmpty ? '' : newsList.first.title}</div>
          <div class="m-news-unread-count">${courseNewsStore.getUnreadByCourseNumber(course.number).length}</div>
        </div>
        ''';

        newsListHtml +=
        '''<div class="m-news-list hide" id="m-news-list-${course.number}">''';

        for (var news in newsList) {
          newsListHtml += '''
            <div class="m-news">
                <div class="m-news-title">${news.title}</div>
                <div class="m-news-body">${news.body}</div>
            </div>
        ''';
        }

        newsListHtml += '''</div>''';
      }
    });

    return '''
    <div class="m-sidebar">
      <div class="m-news-bind-list">
          $newBindHtml
      </div>
      
      <div class="m-news-list-bind">
          $newsListHtml
      </div>
    </div>
        ''';
  }

  static void setEvent() {
    for (var bindElement in querySelectorAll('.m-news-bind')) {
      bindElement.onClick.listen((event) {
        var courseNumber = bindElement.id.replaceFirst(RegExp('(.*)-'), '');
        querySelector('.m-news-bind-list')!.style.display = 'none';
        querySelector('#m-news-list-$courseNumber')!.classes.remove('hide');
        querySelector('#m-news-list-$courseNumber')!.classes.add('show');
      });
    }
  }
}
