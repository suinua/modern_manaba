import 'dart:html';

import '../../models/calendar.dart';
import '../../models/course.dart';

class CalendarView {
  static String html(Calendar calendar) {
    return '''
   <table class="m-calendar">
    <tr class="m-week-name">
        <th></th>
        <td>月</td>
        <td>火</td>
        <td>水</td>
        <td>木</td>
        <td>金</td>
        <td>土</td>
    </tr>
    <tr class="m-course-list">
        <th>
            <div class="m-period-start-time">9:00</div>
            <div class="m-period">1</div>
            <div class="m-period-finish-time">10:40</div>
        </th>
        ${calendar.getCourses(1).map(_CourseView.html).join()}
    </tr>
    <tr class="m-course-list">
        <th>
            <div class="m-period-start-time">10:50</div>
            <div class="m-period">2</div>
            <div class="m-period-finish-time">12:30</div>  
        </th>
        ${calendar.getCourses(2).map(_CourseView.html).join()}
    </tr>
        <tr class="m-course-list">
        <th>
            <div class="m-period-start-time">13:20</div>
            <div class="m-period">3</div>
            <div class="m-period-finish-time">15:00</div>
        </th>
        ${calendar.getCourses(3).map(_CourseView.html).join()}
    </tr>
        <tr class="m-course-list">
        <th>
            <div class="m-period-start-time">15:10</div>
            <div class="m-period">4</div>
            <div class="m-period-finish-time">16:40</div>
        </th>
        ${calendar.getCourses(4).map(_CourseView.html).join()}
    </tr>
    <tr class="m-course-list">
        <th>
            <div class="m-period-start-time">17:00</div>
            <div class="m-period">5</div>
            <div class="m-period-finish-time">18:40</div>
        </th>
        ${calendar.getCourses(5).map(_CourseView.html).join()}
    </tr>
    <tr class="m-course-list">
        <th>
            <div class="m-period-start-time">18:50</div>
            <div class="m-period">6</div>
            <div class="m-period-finish-time">20:30</div>
        </th>
        ${calendar.getCourses(6).map(_CourseView.html).join()}
    </tr>
</table>
    ''';
  }
}

class _CourseView {
  static String html(Course course) {
    return '''
<td>
   <div class="m-course">${course.name}</div>
   <div class="m-course-room">${course.room}</div>
</td>''';
  }
}
