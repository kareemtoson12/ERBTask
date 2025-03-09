import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/presentaion/create_branch/cubit/branch_cubit.dart';
import 'package:task/presentaion/create_branch/widget/header.dart';
import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';
import 'package:task/domain/models/inventory_item.dart';
import 'package:task/presentaion/create_sku.dart/widgets/customsTextField.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.secondColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.dg),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header
                header(context, "Create SKU"),
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
                DropdownButtonFormField<String>(
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
                  ),
                ),
                SizedBox(height: 20.h),
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
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20.h),
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
                  onChanged: (value) => setState(() => _selectedBrand = value),
                  decoration: InputDecoration(
                    labelText: "Brand Name",
                    hintText: "Select a brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _createSku,
                  child: Container(
                    width: 240.w,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
