import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/data/DAO/sku_inventory_dao.dart';

import 'package:task/domain/models/inventory_item.dart';
import 'package:task/presentaion/search_sku/cubit/search_state.dart';

class SearchSkuCubit extends Cubit<SearchSkuState> {
  final InventoryDao _inventoryDao;

  SearchSkuCubit(this._inventoryDao) : super(SearchSkuInitial());

  Future<void> searchSku(String sku) async {
    emit(SearchSkuLoading());
    try {
      final items = await _inventoryDao.getAllItems();
      final item = items.firstWhere(
        (element) => element.sku == sku,
        orElse: () => InventoryItem.empty(),
      );
      if (item.id != null) {
        emit(SearchSkuSuccess(item));
      } else {
        emit(SearchSkuNotFound());
      }
    } catch (e) {
      emit(SearchSkuError("Failed to search SKU: ${e.toString()}"));
    }
  }
}
