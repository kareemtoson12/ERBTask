import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/models/inventory_item.dart';
import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      body: BlocBuilder<InventoryCubit, List<InventoryItem>>(
        builder: (context, items) {
          if (items.isEmpty) {
            return const Center(child: Text("No items available"));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text("SKU: ${item.sku} - ${item.category}"),
              );
            },
          );
        },
      ),
    );
  }
}
