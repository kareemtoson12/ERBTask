import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:task/domain/models/branch.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/presentaion/create_branch/cubit/branch_cubit.dart';
import 'package:task/presentaion/create_branch/widget/header.dart';
import 'package:task/presentaion/create_branch/widget/show_dialogs.dart';

class CreateBranch extends StatefulWidget {
  const CreateBranch({super.key});

  @override
  _CreateBranchState createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _createBranch() {
    if (_formKey.currentState!.validate()) {
      final branch = Branch(
        name: _nameController.text,
        address: _addressController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
      );
      context.read<BranchCubit>().addBranch(branch);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CustomstextStyels.font18blackBold),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'e.g. ${label.split(' ')[0]}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: maxLines > 1 ? 70.0 : 20.0,
              horizontal: 10.0,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.secondColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.dg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(context, 'Create Branch'),
                SizedBox(height: 30.h),
                _buildTextField(
                  label: 'Branch Name',
                  controller: _nameController,
                  validator:
                      (value) => value!.isEmpty ? 'Enter branch name' : null,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: 'Address',
                  controller: _addressController,
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Enter address' : null,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator:
                      (value) => value!.isEmpty ? 'Enter phone number' : null,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return 'Enter email';
                    if (!RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
                    ).hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 90.h),
                BlocConsumer<BranchCubit, BranchState>(
                  listener: (context, state) {
                    if (state is BranchLoaded) {
                      showSuccessDialog(context);
                    } else if (state is BranchError) {
                      showErrorDialog(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: _createBranch,
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ColorsManger.purbleColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child:
                              state is BranchLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'Create Branch',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
