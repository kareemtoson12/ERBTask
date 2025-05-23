import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/presentaion/createQrCode/craete_qr_code.dart';

import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';
import 'package:task/domain/models/inventory_item.dart';
import 'package:task/presentaion/create_sku.dart/display.dart';

import 'package:task/presentaion/create_sku.dart/widgets/customsTextField.dart';
import 'package:task/presentaion/search_sku/search_sku_view.dart';

class SkuCreationScreen extends StatefulWidget {
  const SkuCreationScreen({super.key});

  @override
  _SkuCreationScreenState createState() => _SkuCreationScreenState();
}

class _SkuCreationScreenState extends State<SkuCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  String? _selectedCategory;
  String? _selectedSubcategory;
  String? _selectedBrand;
  bool _autoGenerateSku = true;

  final List<String> categories = [
    'Electronics',
    'Clothing',
    'Home Appliances',
  ];
  final List<String> subcategories = ['Phones', 'Laptops', 'Accessories'];
  final List<String> brands = ['Apple', 'Samsung', 'Sony'];

  String _generateSku(String name, String category, String brand) {
    return '${name.substring(0, 3).toUpperCase()}-${category.substring(0, 3).toUpperCase()}-${brand.substring(0, 3).toUpperCase()}-${DateTime.now().millisecondsSinceEpoch % 10000}';
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

  void _createSku() {
    if (_formKey.currentState!.validate()) {
      final sku =
          _autoGenerateSku
              ? _generateSku(
                _nameController.text,
                _selectedCategory ?? '',
                _selectedBrand ?? '',
              )
              : _skuController.text;

      final newItem = InventoryItem(
        name: _nameController.text,
        sku: sku,
        category: _selectedCategory ?? '',
        subcategory: _selectedSubcategory ?? '',
        brand: _selectedBrand ?? '',
      );

      context.read<InventoryCubit>().addItem(newItem);
      _showDialog("Success", "SKU Created Successfully!\nSKU Code: $sku");
    } else {
      _showDialog("Error", "Please fill all required fields correctly.");
    }
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
              child: Text('SKU', style: CustomstextStyels.font20blackBold),
            ),
          ),
        ),
      ),
      backgroundColor: ColorsManger.secondColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.dg),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  SizedBox(height: 40.h),
                  // Item Name
                  CustomTextField(
                    controller: _nameController,
                    label: "Item Name",
                    validator:
                        (value) => value!.isEmpty ? 'Enter item name' : null,
                  ),
                  SizedBox(height: 10.h),
                  // Auto-generate SKU
                  Row(
                    children: [
                      Checkbox(
                        value: _autoGenerateSku,
                        onChanged: (value) {
                          setState(() => _autoGenerateSku = value!);
                        },
                      ),
                      const Text("Auto-generate SKU"),
                    ],
                  ),
                  if (!_autoGenerateSku)
                    CustomTextField(
                      controller: _skuController,
                      label: "SKU Code",
                      validator:
                          (value) => value!.isEmpty ? 'Enter SKU code' : null,
                    ),
                  SizedBox(height: 20.h),
                  // Category Dropdown
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items:
                          categories
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (value) => setState(() => _selectedCategory = value),
                      decoration: InputDecoration(
                        labelText: "Category",
                        hintText: "Select a category",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  // Subcategory Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedSubcategory,
                    items:
                        subcategories
                            .map(
                              (subcategory) => DropdownMenuItem(
                                value: subcategory,
                                child: Text(subcategory),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedSubcategory = value),
                    decoration: InputDecoration(
                      labelText: "Subcategory",
                      hintText: "Select a subcategory",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  // Brand Name Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedBrand,
                    items:
                        brands
                            .map(
                              (brand) => DropdownMenuItem(
                                value: brand,
                                child: Text(brand),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedBrand = value),
                    decoration: InputDecoration(
                      labelText: "Brand Name",
                      hintText: "Select a brand",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: _createSku,
                    child: Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorsManger.purbleColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Create Sku',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorsManger.purbleColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Product List',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchSkuScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorsManger.purbleColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Search Sku',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QrBarcodeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorsManger.purbleColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'qrcode',
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
        ),
      ),
    );
  }
}
