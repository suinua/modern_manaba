import '../models/calendar.dart';
import '../services/calendar_service.dart';

class CalendarStore {
  static CalendarStore? _instance;

  CalendarStore._internal(this._calendar);

  static Future<void> _init() async {
    _instance ??= CalendarStore._internal(await CalendarService.scriptCalendarData());
  }

  static Future<CalendarStore> instance() async {
    if (_instance == null) await _init();
    return _instance!;
  }

  final Calendar _calendar;

  Calendar get calendar => _calendar;
}
