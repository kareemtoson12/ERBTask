import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:task/domain/models/branch.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/presentaion/create_branch/cubit/branch_cubit.dart';

class CreateBranch extends StatefulWidget {
  const CreateBranch({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBranchState createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: const Text('Success'),
          content: const Text('Branch Created Successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق الـ Dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق الـ Dialog
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.secondColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.dg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 60.dg),
                      Text(
                        'Create Branch',
                        style: CustomstextStyels.font20blackBold,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Branch Name
                  Text('Branch Name', style: CustomstextStyels.font18blackBold),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'e.g. Cairo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator:
                        (value) => value!.isEmpty ? 'Enter branch name' : null,
                  ),
                  SizedBox(height: 20.h),

                  // Address
                  Text('Address', style: CustomstextStyels.font18blackBold),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'e.g. 1234 street, Cairo, Egypt',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 70.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator:
                        (value) => value!.isEmpty ? 'Enter address' : null,
                  ),
                  SizedBox(height: 20.h),

                  // Phone Number
                  Text(
                    'Phone Number',
                    style: CustomstextStyels.font18blackBold,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'e.g. 02126211829',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator:
                        (value) => value!.isEmpty ? 'Enter phone number' : null,
                  ),
                  SizedBox(height: 20.h),

                  // Email Address
                  Text(
                    'Email Address',
                    style: CustomstextStyels.font18blackBold,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'e.g. abc@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter email';
                      if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                      ).hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 90.h),

                  // Create Button
                  BlocConsumer<BranchCubit, BranchState>(
                    listener: (context, state) {
                      if (state is BranchLoaded) {
                        _showSuccessDialog();
                      } else if (state is BranchError) {
                        _showErrorDialog(state.message);
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final branch = Branch(
                              name: _nameController.text,
                              address: _addressController.text,
                              phoneNumber: _phoneController.text,
                              email: _emailController.text,
                            );
                            context.read<BranchCubit>().addBranch(branch);
                          }
                        },
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
      ),
    );
  }
}
