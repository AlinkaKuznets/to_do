import 'package:to_do/domain/model/case.dart';

abstract class CaseRepository {
  Future<void> addCase(String title, DateTime time, String description);

  Future<List<Case>> getCases();

  Future<void> removeCase(String id);
}
