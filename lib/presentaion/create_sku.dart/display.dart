import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/domain/models/inventory_item.dart';
import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          backgroundColor: ColorsManger.purbleColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'sku creation list',
                style: CustomstextStyels.font20blackBold,
              ),
            ),
          ),
        ),
      ),
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
                onTap: () {
                  Clipboard.setData(ClipboardData(text: item.sku));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("SKU copied: ${item.sku}")),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
