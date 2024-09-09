import 'package:to_do/data/repository/case_repository_impl.dart';
import 'package:to_do/data/source/rest_source.dart';
import 'package:to_do/domain/cubit/remove_case_cubit.dart';
import 'package:to_do/domain/cubit/save_case_cubit.dart';
import 'package:to_do/domain/cubit/show_cases_cubit.dart';

final inj = Injection();

class Injection {
  final _restSourse = RestSource();
  late final caseRepository = CaseRepositoryImpl(restSource: _restSourse);

  SaveCaseCubit get addCubit => SaveCaseCubit(caseRepository);

  ShowCasesCubit get showCubit => ShowCasesCubit(caseRepository);

  RemoveCaseCubit get removeCubit => RemoveCaseCubit(caseRepository);
}
