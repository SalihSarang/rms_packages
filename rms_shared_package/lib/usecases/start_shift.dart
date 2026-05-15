import '../models/shift_models/shift_session.dart';
import '../models/staff_model/staff_model.dart';
import '../repositories/shift_repository.dart';

class StartShift {
  final ShiftRepository repository;

  StartShift(this.repository);

  Future<ShiftSession> call(StaffModel staff) {
    return repository.startShift(staff);
  }
}
