import '../models/calendar.dart';
import '../web/calendar_script.dart';

class CalendarStore {
  static CalendarStore? _instance;

  CalendarStore._internal(this._calendar);

  static Future<void> _init() async {
    _instance ??= CalendarStore._internal(await CalendarWeb.execute());
  }

  static Future<CalendarStore> instance() async {
    await _init();
    return _instance!;
  }

  final Calendar _calendar;

  Calendar get calendar => _calendar;
}
