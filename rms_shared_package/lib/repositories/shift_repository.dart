import '../models/shift_models/shift_schedule.dart';
import '../models/shift_models/shift_session.dart';
import '../models/staff_model/staff_model.dart';

abstract class ShiftRepository {
  Future<ShiftSchedule?> getTodayShiftSchedule(String staffId);
  Future<ShiftSession?> getCurrentShiftSession(String staffId);
  Future<List<ShiftSession>> getShiftHistory(String staffId, {int limit = 10});
  Future<ShiftSession> startShift(StaffModel staff);
  Future<ShiftSession> pauseShift(String staffId);
  Future<ShiftSession> resumeShift(String staffId);
  Future<ShiftSession> endShift(String staffId);
}
