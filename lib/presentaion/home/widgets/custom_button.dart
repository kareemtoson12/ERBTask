import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManger.purbleColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(title, style: CustomstextStyels.font18blackBold),
          ),
        ),
      ),
    );
  }
}
