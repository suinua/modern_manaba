import 'dart:html';

import '../models/calendar.dart';
import '../models/course.dart';

class CalendarWeb {
  static Future<Calendar> execute() async {
    var calendarElement = querySelector('.stdlist>tbody')!;

    List<List<Course>> courseList = [[], [], [], [], [], []];

    var dayCount = 0;
    var time = 1;

    for (var rowElement in calendarElement.children) {
      if (rowElement.text!.contains('月火水木金土')) continue;
      for (var courseTdElement in rowElement.children) {
        if (courseTdElement.className == 'period') continue;
        if (courseTdElement.classes.contains('course-cell')) {
          var courseNumber =
              (courseTdElement.querySelector('a') as AnchorElement)
                      .href
                      ?.replaceFirst(RegExp('(.*)course_'), '') ??
                  '';

          courseList[dayCount].add(Course(
              name: courseTdElement.text!,
              time: time,
              roomNumber: await _getRoomNumber(courseNumber),
              number: courseNumber,
              url: 'https://room.chuo-u.ac.jp/ct/course_$courseNumber',
              syllabus: 'https://room.chuo-u.ac.jp/ct/syllabus_$courseNumber'));
        } else {
          courseList[dayCount].add(FreeTime(time));
        }

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
        monday: CalendarDay.monday(mondayCourseList),
        tuesday: CalendarDay.tuesday(tuesdayCourseList),
        wednesday: CalendarDay.wednesday(wednesdayCourseList),
        thursday: CalendarDay.thursday(thursdayCourseList),
        friday: CalendarDay.friday(fridayCourseList),
        saturday: CalendarDay.saturday(saturdayCourseList));
  }

  static Future<String> _getRoomNumber(String courseNumber) async {
    var data = window.localStorage.cast();
    if (data.keys.contains(courseNumber)) {
      return window.localStorage[courseNumber]!;
    } else {
      var res = await window.fetch('https://room.chuo-u.ac.jp/ct/syllabus_$courseNumber');
      var text = await res.text();
      data = window.localStorage.cast();

      var roomNumber = text!
          .replaceAll(RegExp('\r?\n|\r'), '')
          .replaceAll(RegExp('(.*)キャンパス・'), '')
          .replaceAll(RegExp('履修条件・関連科目等(.*)'), '')
          .replaceAll(RegExp('※(.*)'), '')
          .split(' ')
          .first;
      window.localStorage[courseNumber] = roomNumber.toString();
      return roomNumber;
    }
  }
}
