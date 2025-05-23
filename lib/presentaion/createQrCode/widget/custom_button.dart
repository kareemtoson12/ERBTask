import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';

class CustomButtonQr extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData? icon;

  const CustomButtonQr({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManger.purbleColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child:
                icon == null
                    ? Text(title, style: CustomstextStyels.font18blackBold)
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: Colors.black),
                        SizedBox(width: 10.w),
                        Text(title, style: CustomstextStyels.font18blackBold),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
