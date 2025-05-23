/* import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/presentaion/createQrCode/craete_qr_code.dart';
import 'package:task/presentaion/create_branch/create_brach_view.dart';
import 'package:task/presentaion/create_sku.dart/create_sku_view.dart'
    show SkuCreationScreen;
import 'package:task/presentaion/home/widgets/custom_button.dart';
import 'package:task/presentaion/search_sku/search_sku_view.dart';
import 'package:task/presentaion/skuDeactivation/sku_deactivation_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
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
                'SKU MANAGEMENT',
                style: CustomstextStyels.font20blackBold,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            CustomButton(
              title: 'Create Branch',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ()),
                );
              },
            ),
            SizedBox(height: 30.h),
            CustomButton(
              title: 'Create SKU',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SkuCreationScreen()),
                );
              },
            ),
            SizedBox(height: 30.h),
            CustomButton(
              title: 'Create QR Code',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QrBarcodeScreen()),
                );
              },
            ),
            SizedBox(height: 30.h),
            CustomButton(
              title: 'search SKU',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SearchSkuScreen()),
                );
              },
            ),
            SizedBox(height: 30.h),
            CustomButton(
              title: ' SKU Deactivation ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SkuDeactivationScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
 */
