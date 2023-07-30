class Course {
  final String name;
  final int time;
  final String room;

  Course({required this.name, required this.time, required this.room});
}

class FreeTime extends Course {
  FreeTime(int time) : super(name: 'FreeTime', time: time, room: '');
}
