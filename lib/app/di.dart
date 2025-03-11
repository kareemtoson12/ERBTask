import 'package:get_it/get_it.dart';
import 'package:task/data/DAO/Branch_dao.dart';
import 'package:task/data/DAO/sku_inventory_dao.dart';
import 'package:task/presentaion/create_branch/cubit/branch_cubit.dart';
import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';
import 'package:task/presentaion/search_sku/cubit/search_cubit.dart';

final getit = GetIt.instance;

Future<void> setUpGetIt() async {
  //BrachDao
  getit.registerFactory<BranchDao>(() => BranchDao());

  //create a new Brach
  getit.registerFactory<BranchCubit>(() => BranchCubit(getit<BranchDao>()));
  //create sku dao

  getit.registerFactory<InventoryDao>(() => InventoryDao());
  //create a new Sku
  getit.registerFactory<InventoryCubit>(
    () => InventoryCubit(getit<InventoryDao>()),
  );
  //search for a sku
  getit.registerLazySingleton<SearchSkuCubit>(
    () => SearchSkuCubit(getit<InventoryDao>()),
  );
}
