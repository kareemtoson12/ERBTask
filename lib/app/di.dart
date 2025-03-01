import 'package:get_it/get_it.dart';
import 'package:task/data/DAO/Branch_dao.dart';
import 'package:task/presentaion/create_branch/cubit/branch_cubit.dart';

final getit = GetIt.instance;

Future<void> setUpGetIt() async {
  //BrachDao
  getit.registerFactory<BranchDao>(() => BranchDao());

  //create a new Brach
  getit.registerFactory<BranchCubit>(() => BranchCubit(getit<BranchDao>()));
}
