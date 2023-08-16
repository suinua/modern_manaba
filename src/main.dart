import 'dart:html';

import 'stores/CalendarStore.dart';
import 'web/calendar_script.dart';
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

      cleanUp();
    });
  }
}

void cleanUp() {
  querySelector('body')?.remove();
}
