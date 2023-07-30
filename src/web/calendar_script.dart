import 'dart:html';

import '../models/calendar.dart';
import '../models/course.dart';

class CalendarWeb {
  static Calendar execute() {
    var calendarElement = querySelector('.stdlist>tbody')!;

    List<List<Course>> courseList = [[], [], [], [], [], []];

    var dayCount = 0;
    var time = 1;

    for (var row in calendarElement.children) {
      if (row.text!.contains('月火水木金土')) continue;
      for (var course in row.children) {
        if (course.className == 'period') continue;
        courseList[dayCount].add(course.text == null
            ? FreeTime(time)
            : Course(name: course.text!, time: time, room: '0'));
        dayCount++;
      }
      time++;
      dayCount = 0;
    }

    List<Course> mondayCourseList = courseList[0];
    List<Course> tuesdayCourseList = courseList[1];
    List<Course> wednesdayCourseList = courseList[2];
    List<Course> thursdayCourseList = courseList[3];
    List<Course> fridayCourseList = courseList[4];
    List<Course> saturdayCourseList = courseList[5];

    return Calendar(
      monday: CalendarDay(name:'monday',courseList:mondayCourseList),
      tuesday: CalendarDay(name:'tuesday',courseList:tuesdayCourseList),
      wednesday: CalendarDay(name:'wednesday',courseList:wednesdayCourseList),
      thursday: CalendarDay(name:'thursday',courseList:thursdayCourseList),
      friday: CalendarDay(name:'friday',courseList:fridayCourseList),
      saturday: CalendarDay(name:'saturday',courseList:saturdayCourseList)
    );
  }
}
