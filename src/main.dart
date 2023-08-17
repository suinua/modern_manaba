import 'dart:html';

import 'stores/calendar_store.dart';
import 'stores/course_news_store.dart';
import 'view/calendar_view.dart';
import 'view/sidebar.dart';

void main() async {
  if (window.location.href.contains('syllabus')) {
  } else {
    var calendarStore = await CalendarStore.instance();
    var sidebarHtml = await SideBar.html();

    window.name = 'modern_manaba';
    //todo:load画面
    querySelector('html')?.children.add(DivElement()
      ..innerHtml = '''
    <div class="m-app">
      <div class="m-main">
        $sidebarHtml
        <div class="m-content">
          <div class="m-flex-content" id="m-calendar">
          ${CalendarView.html(calendarStore.calendar)}
          </div>
        </div>
      </div>
    </div>''');


    SideBar.setEvent();
    CourseNewsStore().updateAllNews();

    cleanUp();
  }
}

void cleanUp() {
  querySelector('body')?.remove();
}
