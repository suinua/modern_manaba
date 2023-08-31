import 'dart:html';

import '../models/course.dart';
import '../models/course_news.dart';
import '../stores/calendar_store.dart';
import '../stores/course_news_store.dart';

class SideBar {
  static Future<String> html() async {
    var calendarStore = await CalendarStore.instance();

    var newBindHtml = '';
    var newsListHtml = '';
    calendarStore.calendar.allCourses().forEach((course) {
      if (course is! FreeTime) {
        var newsList = CourseNewsStore().getByCourseNumber(course.number);
        newBindHtml += '''
        <div class="m-news-thumbnail" id="m-news-thumbnail-${course.number}">
          <div class="m-news-course-name">${course.name}</div>
          <div class="m-news-unread-count">${CourseNewsStore().getUnreadByCourseNumber(course.number).length}</div>
          <div class="m-last-news-title">${newsList.isEmpty ? '' : newsList.first.title}</div>
        </div>
        ''';

        newsListHtml +=
            '''
            <div class="m-news-list-menu hide" id="m-news-list-menu-${course.number}">
            　<div class="m-news-list-header">
            　　<div class="m-news-list-close-button" id="m-news-list-close-button-${course.number}"></div>
            　 <div class="m-news-list-header-name">${course.name}</div>
            　</div>
            <div class="m-news-list">
            ''';

        for (var news in newsList) {
          newsListHtml += '''
            <div class="m-news">
                <div class="m-news-title">${news.title}</div>
                <div class="m-news-body">${news.body}</div>
            </div>
        ''';
        }

        newsListHtml += '''</div></div>''';
      }
    });

    return '''
    <div class="m-sidebar">
      <div class="m-news-thumbnail-list">
          $newBindHtml
      </div>
      
      <div class="m-news-lists">
          $newsListHtml
      </div>
    </div>
        ''';
  }

  static void setEvent() {
    CourseNewsStore().controller.stream.listen((news) {
      if (news is CourseNews) {
        querySelector('#m-news-thumbnail-${news.courseNumber}')!
        ..children[1].innerText = news.title
        ..children[2].innerText = CourseNewsStore()
              .getUnreadByCourseNumber(news.courseNumber)
              .length.toString();

        querySelector('#m-news-list-menu-${news.courseNumber}')!
            .children
            .add(Element.html('''
            <div class="m-news">
                <div class="m-news-title">${news.title}</div>
                <div class="m-news-body">${news.body}</div>
            </div>'''));
      }
    });

    for (var bindElement in querySelectorAll('.m-news-thumbnail')) {
      bindElement.onClick.listen((event) {
        var courseNumber = bindElement.id.replaceFirst(RegExp('(.*)-'), '');
        querySelector('.m-news-thumbnail-list')!.style.display = 'none';
        querySelector('#m-news-list-menu-$courseNumber')!.classes.remove('hide');
        querySelector('#m-news-list-menu-$courseNumber')!.classes.add('show');
      });
    }

    CalendarStore.instance().then((instance){
      var courseList = instance.calendar.allCourses();
      for (var course in courseList) {
        if (course is! FreeTime) {
          print('#m-news-list-close-button-${course.number}');
          querySelector('#m-news-list-close-button-${course.number}')!.onClick.listen((event) {
            querySelector('.m-news-thumbnail-list')!.style.display = '';
            querySelector('#m-news-list-menu-${course.number}')!.classes.add('hide');
            querySelector('#m-news-list-menu-${course.number}')!.classes.remove('show');
          });
        }
      }
    });
  }
}
