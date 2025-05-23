import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/presentaion/create_sku.dart/widgets/customsTextField.dart';
import 'package:task/presentaion/search_sku/cubit/search_cubit.dart';

import 'package:task/domain/models/inventory_item.dart';
import 'package:task/presentaion/search_sku/cubit/search_state.dart';
import 'package:task/presentaion/skuDeactivation/sku_deactivation_view.dart';

class SearchSkuScreen extends StatefulWidget {
  const SearchSkuScreen({super.key});

  @override
  _SearchSkuScreenState createState() => _SearchSkuScreenState();
}

class _SearchSkuScreenState extends State<SearchSkuScreen> {
  final TextEditingController _skuController = TextEditingController();

  void _searchSku() {
    if (_skuController.text.isNotEmpty) {
      context.read<SearchSkuCubit>().searchSku(_skuController.text);
    }
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
                ' SKU Search',
                style: CustomstextStyels.font20blackBold,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: ColorsManger.secondColor,

      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CustomTextField(controller: _skuController, label: "Enter SKU"),
            SizedBox(height: 50.h),
            Center(
              child: GestureDetector(
                onTap: _searchSku,
                child: Container(
                  width: 240.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ColorsManger.purbleColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Search ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            BlocListener<SearchSkuCubit, SearchSkuState>(
              listener: (context, state) {
                if (state is SearchSkuSuccess) {
                  _showDialog("Success", "SKU found: ${state.item.sku}");
                } else if (state is SearchSkuNotFound) {
                  _showDialog(
                    "Not Found",
                    "The SKU you searched for does not exist.",
                  );
                } else if (state is SearchSkuError) {
                  _showDialog("Error", state.message);
                }
              },
              child: BlocBuilder<SearchSkuCubit, SearchSkuState>(
                builder: (context, state) {
                  if (state is SearchSkuLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSkuSuccess) {
                    return Center(child: _buildSkuDetails(state.item));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SkuDeactivationScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 240.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ColorsManger.purbleColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'deactivate ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkuDetails(InventoryItem item) {
    return Column(
      children: [
        SizedBox(height: 70.h),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ${item.name}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text("SKU: ${item.sku}", style: TextStyle(fontSize: 14.sp)),
                SizedBox(height: 5.h),
                Text(
                  "Category: ${item.category}",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Subcategory: ${item.subcategory}",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Text("Brand: ${item.brand}", style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
