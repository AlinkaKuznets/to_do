import 'package:to_do/data/source/rest_source.dart';
import 'package:to_do/domain/model/case.dart';
import 'package:to_do/domain/repository/case_repository.dart';

class CaseRepositoryImpl implements CaseRepository {
  final RestSource restSource;

  CaseRepositoryImpl({required this.restSource});

  @override
  Future<void> addCase(String title, DateTime time, String description) {
    return restSource.addCase(title, time, description);
  }

  @override
  Future<List<Case>> getCases() {
    return restSource.getCases();
  }

  @override
  Future<void> removeCase(String id) {
    return restSource.removeCase(id);
  }
}
