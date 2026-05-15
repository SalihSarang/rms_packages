import '../models/shift_models/shift_schedule.dart';
import '../repositories/shift_repository.dart';

class GetTodayShiftSchedule {
  final ShiftRepository repository;

  GetTodayShiftSchedule(this.repository);

  Future<ShiftSchedule?> call(String staffId) {
    return repository.getTodayShiftSchedule(staffId);
  }
}
