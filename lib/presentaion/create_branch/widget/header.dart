import 'package:flutter/material.dart' show IconButton, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/text_styles.dart';

Widget header(BuildContext context, String text) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      SizedBox(width: 60.dg),
      Text(text, style: CustomstextStyels.font20blackBold),
    ],
  );
}
