import 'package:equatable/equatable.dart';
import 'package:task/domain/models/inventory_item.dart';

abstract class SearchSkuState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchSkuInitial extends SearchSkuState {}

class SearchSkuLoading extends SearchSkuState {}

class SearchSkuSuccess extends SearchSkuState {
  final InventoryItem item;
  SearchSkuSuccess(this.item);

  @override
  List<Object?> get props => [item];
}

class SearchSkuNotFound extends SearchSkuState {}

class SearchSkuError extends SearchSkuState {
  final String message;
  SearchSkuError(this.message);

  @override
  List<Object?> get props => [message];
}
