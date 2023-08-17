import 'dart:html';

import 'services/course_news_service.dart';
import 'stores/calendar_store.dart';
import 'stores/course_news_store.dart';
import 'web/view_models/calendar_view.dart';

void main() async {
  if (window.location.href.contains('syllabus')) {
  } else {
    window.name = 'modern_manaba';
    //todo:load画面
    CalendarStore.instance().then((calendarStore){
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

      CourseNewsStore.instance().then((instance) {
        querySelector('.m-sidebar')!.innerHtml = '''
        
        ''';
      });

      cleanUp();
    });
  }
}

void cleanUp() {
  querySelector('body')?.remove();
}
