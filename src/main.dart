import 'dart:html';

import 'models/course.dart';
import 'stores/calendar_store.dart';
import 'stores/course_news_store.dart';
import 'web/view_models/calendar_view.dart';

void main() async {
  if (window.location.href.contains('syllabus')) {
  } else {
    var calendarStore = await CalendarStore.instance();
    var courseNewsStore = await CourseNewsStore.instance();

    window.name = 'modern_manaba';
    //todo:load画面
    querySelector('html')?.children.add(DivElement()
      ..innerHtml = '''
    <div class="m-app">
      <div class="m-main">
        <div class="m-sidebar">サイドバー</div>
        <div class="m-content">
          <div class="m-flex-content" id="m-calendar">
          ${CalendarView.html(calendarStore.calendar)}
          </div>
        </div>
      </div>
    </div>''');

    var newBindHtml = '';
    var newListHtml = '';
    calendarStore.calendar.allCourses().forEach((course) {
      if (course is! FreeTime) {
        var newsList = courseNewsStore.getByCourseNumber(course.number);
        newBindHtml += '''
        <div class="m-news-bind">
          <div class="m-news-course-name">${course.name}</div>
          <div class="m-last-news-title">${newsList.isEmpty ? '' : newsList.first.title}</div>
          <div class="m-news-unread-count">${courseNewsStore.getUnreadByCourseNumber(course.number).length}</div>
        </div>
        ''';

        newListHtml +=
            '''<div class="m-news-list" id="m-news-list-${course.number}">''';

        var index = 0;
        for (var news in newsList) {
          newListHtml += '''
            <div class="m-news">
                <div class="m-news-title">${news.title}</div>
                <div class="m-news-body">${news.body}</div>
            </div>
        
        ''';
          index++;
          if (index == newsList.length) {
            newListHtml += '''</div>''';
          }
        }
      }
    });

    querySelector('.m-sidebar')!.innerHtml = '''
    <div class="m-news-bind-list">
      <div class="m-news-bind">
          $newBindHtml
      </div>
    </div>
    
    <div class="m-news-list">
        $newListHtml
    </div>
        ''';

    cleanUp();
  }
}

void cleanUp() {
  querySelector('body')?.remove();
}
