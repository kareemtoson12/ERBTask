import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/DAO/sku_inventory_dao.dart';
import 'package:task/domain/models/inventory_item.dart';

class InventoryCubit extends Cubit<List<InventoryItem>> {
  final InventoryDao _repository;

  InventoryCubit(this._repository) : super([]);

  Future<void> addItem(InventoryItem item) async {
    await _repository.insertItem(item);
    final updatedList = await _repository.getAllItems();
    emit(updatedList);
  }
}
