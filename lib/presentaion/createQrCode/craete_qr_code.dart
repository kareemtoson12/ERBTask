import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:task/app/styles/colors_manager.dart';
import 'package:task/app/styles/text_styles.dart';
import 'package:task/presentaion/createQrCode/widget/custom_button.dart';
import 'package:task/presentaion/create_sku.dart/cubit/inventory_cubit.dart';

class QrBarcodeScreen extends StatefulWidget {
  const QrBarcodeScreen({super.key});

  @override
  State<QrBarcodeScreen> createState() => _QrBarcodeScreenState();
}

class _QrBarcodeScreenState extends State<QrBarcodeScreen> {
  String? selectedSku;
  String? scannedData;

  void _scanCode() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => Scaffold(
              appBar: AppBar(title: const Text("Scan QR/Barcode")),
              body: MobileScanner(
                onDetect: (barcode) {
                  final code =
                      barcode.barcodes.isNotEmpty
                          ? barcode.barcodes.first.rawValue
                          : null;
                  if (code != null) {
                    Navigator.of(context).pop();
                    setState(() {
                      scannedData = code;
                    });
                  }
                },
              ),
            ),
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
                'Qr Management',
                style: CustomstextStyels.font20blackBold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedSku,
              decoration: InputDecoration(
                labelText: "Select SKU",
                border: OutlineInputBorder(),
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
            const SizedBox(height: 20),
            if (selectedSku != null)
              CustomButtonQr(
                title: "Generate QR",
                onTap: () => setState(() {}),
              ),

            const SizedBox(height: 20),
            if (selectedSku != null)
              QrImageView(
                data: selectedSku!,
                version: QrVersions.auto,
                size: 200.0,
              ),
            const SizedBox(height: 20),
            CustomButtonQr(
              title: "Scan QR / Barcode",
              icon: Icons.qr_code_scanner,
              onTap: _scanCode,
            ),

            const SizedBox(height: 20),
            if (scannedData != null)
              Column(
                children: [
                  const Text(
                    "Scanned Data:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(scannedData!),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
