import 'dart:html';

import 'stores/CalendarStore.dart';
import 'web/view_models/calendar_view.dart';

void main() {
  querySelector('html')?.children.add(DivElement()
    ..innerHtml = '''
    <div class="m-app">
      <div class="m-main">
        <div class="m-sidebar">サイドバー</div>
        <div class="m-content">
          <div class="m-flex-content" id="m-calendar">
          ${CalendarView.html(CalendarStore().calendar)}
          </div>
        </div>
      </div>
    </div>''');

  cleanUp();
}

void cleanUp() {
  querySelector('body')?.remove();
}
