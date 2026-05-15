import '../models/shift_models/shift_session.dart';
import '../repositories/shift_repository.dart';

class EndShift {
  final ShiftRepository repository;

  EndShift(this.repository);

  Future<ShiftSession> call(String staffId) {
    return repository.endShift(staffId);
  }
}
