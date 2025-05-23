import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/text_styles.dart';

import 'package:task/app/styles/colors_manager.dart';
import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';

class SkuDeactivationScreen extends StatefulWidget {
  const SkuDeactivationScreen({super.key});

  @override
  State<SkuDeactivationScreen> createState() => _SkuDeactivationScreenState();
}

class _SkuDeactivationScreenState extends State<SkuDeactivationScreen> {
  String? selectedSku;

  void _deactivateSku() {
    if (selectedSku == null) {
      _showDialog('Error', 'Please select a SKU.');
      return;
    }

    final cubit = context.read<InventoryCubit>();
    final skuExists = cubit.state.any((item) => item.sku == selectedSku);

    if (!skuExists) {
      _showDialog('Error', 'SKU not found.');
      return;
    }

    cubit.deactivateItem(selectedSku!);
    _showDialog('Success', 'SKU $selectedSku has been deactivated.');
    setState(() {
      selectedSku = null;
    });
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<InventoryCubit>();
    final skuList = cubit.state.map((item) => item.sku).toList();

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
                'Deactivate SKU',
                style: CustomstextStyels.font20blackBold,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: ColorsManger.secondColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              DropdownButtonFormField<String>(
                value: selectedSku,
                decoration: InputDecoration(
                  labelText: "Select SKU",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                items:
                    skuList.map((sku) {
                      return DropdownMenuItem<String>(
                        value: sku,
                        child: Text(sku),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSku = value;
                  });
                },
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: _deactivateSku,
                child: Container(
                  width: 240.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ColorsManger.purbleColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Deactivate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
