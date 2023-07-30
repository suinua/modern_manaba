import '../models/calendar.dart';
import '../web/calendar_script.dart';

class CalendarStore {
  static CalendarStore? _instance;

  CalendarStore._internal(this._calendar);

  factory CalendarStore() {
    _instance ??= CalendarStore._internal(CalendarWeb.execute());
    return _instance!;
  }

  final Calendar _calendar;

  Calendar get calendar => _calendar;
}
