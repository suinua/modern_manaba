import 'course.dart';

class Calendar {
  final CalendarDay monday;
  final CalendarDay tuesday;
  final CalendarDay wednesday;
  final CalendarDay thursday;
  final CalendarDay friday;
  final CalendarDay saturday;

  List<Course> allCourses() {
    return monday.courseList +
        tuesday.courseList +
        wednesday.courseList +
        thursday.courseList +
        friday.courseList +
        saturday.courseList;
  }

  List<Course> getCourses(int time) {
    return allCourses().where((element) => element.time == time).toList();
  }

  Calendar(
      {required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday});
}

class CalendarDay {
  final String name;
  final List<Course> courseList;

  CalendarDay.monday(this.courseList) : name = 'monday';
  CalendarDay.tuesday(this.courseList) : name = 'tuesday';
  CalendarDay.wednesday(this.courseList) : name = 'wednesday';
  CalendarDay.thursday(this.courseList) : name = 'thursday';
  CalendarDay.friday(this.courseList) : name = 'friday';
  CalendarDay.saturday(this.courseList) : name = 'saturday';

  CalendarDay({required this.name, required this.courseList});
}
