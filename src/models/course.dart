class Course {
  final String name;
  final int time;
  final String roomNumber;

  final String number;
  final String url;
  final String syllabus;

  Course({required this.name, required this.time, required this.roomNumber, required this.number, required this.url, required this.syllabus});

}

class FreeTime extends Course {
  FreeTime(int time) : super(name: '', time: time, roomNumber: '', number: '', url: '', syllabus: '');
}
