import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/dashboard/support/support_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/components/transaction_details_component.dart';

import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen(
      {super.key,
      required this.amount,
      required this.referenceId,
      required this.status,
      required this.date,
      required this.type,
      required this.number,
      required this.subType});
  final String amount;
  final String referenceId;
  final String status;
  final String date;
  final String type;
  final String subType;
  final String number;

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor2,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.arrow_back)),
                  horizontalSpace(140),
                  Text(
                    'Details',
                    style: AppTextStyles.font18,
                  ),
                ],
              ),
              verticalSpace(27),
              RepaintBoundary(
                key: _globalKey,
                child: TransactionsDetailsWidget(
                  subType: widget.subType,
                  amount: widget.amount,
                  status: widget.status,
                  referenceId: widget.referenceId,
                  type: widget.type,
                  date: widget.date,
                  number: widget.number,
                ),
              ),
              verticalSpace(20),
              GestureDetector(
                onTap: () => nextScreen(context, SupportScreen()),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  // height: 88.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Any issue with this transaction?',
                        style: AppTextStyles.font14,
                      ),
                      verticalSpace(5),
                      Row(
                        children: [
                          const Icon(
                            Icons.support_agent_outlined,
                            color: AppColors.primaryColor,
                          ),
                          horizontalSpace(12),
                          Text(
                            'Contact customer service',
                            style: AppTextStyles.font14
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(100),
              ButtonWidget(
                text: 'Get Receipt',
                onTap: () {
                  getReceiptBottomSheet(context);
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<dynamic> getReceiptBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // height: 186.h,
            height: 150.h,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppColors.whiteColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 21),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'X',
                        style: AppTextStyles.font20,
                      ),
                    ),
                  ),
                ),
                // verticalSpace(18),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //     showModalBottomSheet(
                //         context: context,
                //         builder: (context) {
                //           return Container(
                //             height: 186.h,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: const BoxDecoration(
                //                 borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(24),
                //                   topRight: Radius.circular(24),
                //                 ),
                //                 color: AppColors.whiteColor),
                //             child: Column(
                //               children: [
                //                 Padding(
                //                   padding:
                //                       const EdgeInsets.only(right: 20, top: 21),
                //                   child: Align(
                //                     alignment: Alignment.topRight,
                //                     child: GestureDetector(
                //                         onTap: () => Navigator.pop(context),
                //                         child: SizedBox(
                //                           height: 16,
                //                           width: 16,
                //                           child: Image.asset(
                //                               'assets/icons/cancel_icon.png'),
                //                         )),
                //                   ),
                //                 ),
                //                 verticalSpace(18),
                //                 GestureDetector(
                //                   onTap: () {
                //                     Navigator.pop(context);
                //                     _generateAndDownloadPDF();
                //                   },
                //                   child: Text(
                //                     'PDF',
                //                     style: AppTextStyles.font14.copyWith(
                //                       color: const Color(0xff333333),
                //                     ),
                //                   ),
                //                 ),
                //                 verticalSpace(15),
                //                 Divider(
                //                   color: AppColors.blackColor.withOpacity(0.1),
                //                 ),
                //                 verticalSpace(15),
                //                 GestureDetector(
                //                   onTap: () {
                //                     Navigator.pop(context);
                //                     _captureAndDownloadImage();
                //                   },
                //                   child: Text(
                //                     'Image',
                //                     style: AppTextStyles.font14.copyWith(
                //                       color: const Color(0xff333333),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           );
                //         });
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Icon(
                //         Icons.download_outlined,
                //         color: Color(0xff333333),
                //       ),
                //       horizontalSpace(12),
                //       Text(
                //         'Download Receipt',
                //         style: AppTextStyles.font14.copyWith(
                //           color: const Color(0xff333333),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // verticalSpace(15),
                // Divider(
                //   color: AppColors.blackColor.withOpacity(0.1),
                // ),
                verticalSpace(15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 186.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                color: AppColors.whiteColor),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 21),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          'assets/icons/cancel_icon.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpace(18),
                                InkWell(
                                  onTap: () {
                                    _generateAndSharePDF();
                                  },
                                  child: Text(
                                    'PDF',
                                    style: AppTextStyles.font14.copyWith(
                                      color: const Color(0xff333333),
                                    ),
                                  ),
                                ),
                                verticalSpace(15),
                                Divider(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                ),
                                verticalSpace(15),
                                InkWell(
                                  onTap: () {
                                    _captureAndShareImage();
                                  },
                                  child: Text(
                                    'Image',
                                    style: AppTextStyles.font14.copyWith(
                                      color: const Color(0xff333333),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ios_share_outlined,
                        color: Color(0xff333333),
                      ),
                      horizontalSpace(12),
                      Text(
                        'Share Receipt',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

//Function to save and download data as image

  Future<void> _captureAndDownloadImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image to a file
      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/transaction_details.png').create();
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image downloaded to ${file.path}'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //function to save and download data as pdf

  Future<void> _generateAndDownloadPDF() async {
    final iconData = await rootBundle.load('assets/icons/success_icon.png');
    final iconImage = pw.MemoryImage(iconData.buffer.asUint8List());
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                height: 438.h,
                width: double.infinity,
                //MediaQuery.of(context).size.width,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(8),
                  color: PdfColors.white,
                ),
                child: pw.Column(children: [
                  pw.SizedBox(height: 16),

                  //    verticalSpace(16),
                  pw.Text('N${widget.amount}',
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)
                      //AppTextStyles.font20,
                      ),
                  pw.SizedBox(height: 16),
                  // verticalSpace(16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (widget.status == 'success')
                        pw.SizedBox(
                          height: 16,
                          width: 16,
                          child: pw.Image(iconImage),
                          // pw.Image(
                          //             pw.MemoryImage((await rootBundle.load('assets/icons/success_icon.png')).buffer.asUint8List()),
                          //           ),
                          // status == 'success'
                          //     ? Image.asset('assets/icons/success_icon.png')
                          //     : SizedBox.shrink(),
                        ),
                      pw.SizedBox(width: 5),
                      //   horizontalSpace(5),
                      pw.Text(
                        '${widget.status}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: widget.status == 'success'
                              ? PdfColors.green
                              : widget.status == 'pending'
                                  ? PdfColor.fromHex('#A6B309')
                                  : PdfColors.red,
                        ),

                        // AppTextStyles.font12.copyWith(
                        //     color: status == 'success'
                        //         ? Colors.green
                        //         : status == 'pending'
                        //             ? Color(0xffA6B309)
                        //             : Colors.red),
                      )
                    ],
                  ),

                  pw.SizedBox(height: 46),
                  // verticalSpace(46),
                  // const TransactionDetailsSection(
                  //   title: 'Recipient',
                  //   value: '08169784011',
                  // ),
                  // verticalSpace(24),
                  // pw.Row(
                  //   children: [
                  // TransactionDetailsSection(
                  //   title: 'Transaction ID',
                  //   value: '$referenceId',
                  //   iconData: Icons.copy,
                  // ),
                  //   ],
                  // ),
                  _transactionDetailsSection(
                      'Transaction ID', widget.referenceId, Icons.copy),
                  pw.SizedBox(height: 24),
                  // verticalSpace(24),
                  _transactionDetailsSection('Transaction Type', widget.type),
                  // TransactionDetailsSection(
                  //   title: 'Transaction Type',
                  //   value: '$type',
                  // ),
                  // verticalSpace(24),
                  // const TransactionDetailsSection(
                  //   title: 'Transaction Means',
                  //   value: 'Wallet',
                  // ),
                  // verticalSpace(24),
                  // const TransactionDetailsSection(
                  //   title: 'Payment method',
                  //   value: 'Wallet',
                  // ),
                  // verticalSpace(24),
                  pw.SizedBox(height: 24),
                  _transactionDetailsSection('Date', widget.date),
                  // TransactionDetailsSection(
                  //   title: 'Date',
                  //   value: date,
                  // ),
                ]),
              )),
    );

    final bytes = await pdf.save();
    await _downloadPDF(bytes);
  }

  Future<void> _downloadPDF(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/transaction_details.pdf');
    await file.writeAsBytes(bytes);
    log('download done');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF downloaded to ${file.path}'),
      ),
    );
  }

  //function to save and share data as image
  Future<void> _captureAndShareImage() async {
    try {
      // Capture the widget as an image
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image to a file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/shared_image.png').create();
      await file.writeAsBytes(pngBytes);

      // Share the image
      await Share.shareXFiles([XFile(file.path)], text: 'Transaction details');
    } catch (e) {
      print(e.toString());
    }
  }

  //function to save and share data as pdf
  Future<void> _generateAndSharePDF() async {
    final iconData = await rootBundle.load('assets/icons/success_icon.png');
    final iconImage = pw.MemoryImage(iconData.buffer.asUint8List());
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                height: 438.h,
                width: double.infinity,
                //MediaQuery.of(context).size.width,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(8),
                  color: PdfColors.white,
                ),
                child: pw.Column(children: [
                  pw.SizedBox(height: 16),

                  //    verticalSpace(16),
                  pw.Text('N${widget.amount}',
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)
                      //AppTextStyles.font20,
                      ),
                  pw.SizedBox(height: 16),
                  // verticalSpace(16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (widget.status == 'success')
                        pw.SizedBox(
                          height: 16,
                          width: 16,
                          child: pw.Image(iconImage),
                          // pw.Image(
                          //             pw.MemoryImage((await rootBundle.load('assets/icons/success_icon.png')).buffer.asUint8List()),
                          //           ),
                          // status == 'success'
                          //     ? Image.asset('assets/icons/success_icon.png')
                          //     : SizedBox.shrink(),
                        ),
                      pw.SizedBox(width: 5),
                      //   horizontalSpace(5),
                      pw.Text(
                        '${widget.status}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: widget.status == 'success'
                              ? PdfColors.green
                              : widget.status == 'pending'
                                  ? PdfColor.fromHex('#A6B309')
                                  : PdfColors.red,
                        ),

                        // AppTextStyles.font12.copyWith(
                        //     color: status == 'success'
                        //         ? Colors.green
                        //         : status == 'pending'
                        //             ? Color(0xffA6B309)
                        //             : Colors.red),
                      )
                    ],
                  ),

                  pw.SizedBox(height: 46),
                  // verticalSpace(46),
                  // const TransactionDetailsSection(
                  //   title: 'Recipient',
                  //   value: '08169784011',
                  // ),
                  // verticalSpace(24),
                  // pw.Row(
                  //   children: [
                  // TransactionDetailsSection(
                  //   title: 'Transaction ID',
                  //   value: '$referenceId',
                  //   iconData: Icons.copy,
                  // ),
                  //   ],
                  // ),
                  _transactionDetailsSection(
                      'Transaction ID', widget.referenceId),
                  pw.SizedBox(height: 24),
                  // verticalSpace(24),
                  _transactionDetailsSection('Transaction Type', widget.type),
                  // TransactionDetailsSection(
                  //   title: 'Transaction Type',
                  //   value: '$type',
                  // ),
                  // verticalSpace(24),
                  // const TransactionDetailsSection(
                  //   title: 'Transaction Means',
                  //   value: 'Wallet',
                  // ),
                  // verticalSpace(24),
                  // const TransactionDetailsSection(
                  //   title: 'Payment method',
                  //   value: 'Wallet',
                  // ),
                  // verticalSpace(24),
                  pw.SizedBox(height: 24),
                  _transactionDetailsSection('Date', widget.date),
                  // TransactionDetailsSection(
                  //   title: 'Date',
                  //   value: date,
                  // ),
                ]),
              )),
    );

    final bytes = await pdf.save();
    await _sharePDF(bytes);
  }

  pw.Widget _transactionDetailsSection(String title, String value,
      [IconData? iconData]) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text(
            '$title: ',
            style: pw.TextStyle(fontSize: 18),
          ),
        ),
        pw.SizedBox(width: 50),
        pw.Expanded(
          child: pw.Text(
            ' $value',
            style: pw.TextStyle(fontSize: 18),
          ),
        ),
        if (iconData != null)
          pw.Icon(pw.IconData(iconData.codePoint), size: 16),
      ],
    );
  }

  Future<void> _sharePDF(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/transaction_details.pdf');
    await file.writeAsBytes(bytes);

    final XFile xFile = XFile(
      file.path,
      mimeType: 'application/pdf',
      name: 'transaction_details.pdf',
    );
    await Share.shareXFiles([xFile], text: 'Here is your PDF file');
  }
}

class TransactionsDetailsWidget extends StatelessWidget {
  const TransactionsDetailsWidget({
    super.key,
    required this.amount,
    required this.status,
    required this.referenceId,
    required this.type,
    required this.date,
    required this.number,
    required this.subType,
  });

  final String amount;
  final String status;
  final String referenceId;
  final String type;
  final String date;
  final String number;
  final String subType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      height: 438.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),
      child: Column(children: [
        verticalSpace(16),
        Text(
          'N$amount',
          style: AppTextStyles.font20,
        ),
        verticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 16,
              width: 16,
              child: status == 'success'
                  ? Image.asset('assets/icons/success_icon.png')
                  : SizedBox.shrink(),
            ),
            horizontalSpace(5),
            Text(
              '$status',
              style: AppTextStyles.font14.copyWith(
                  fontWeight: FontWeight.w400,
                  color: status == 'success'
                      ? Colors.green
                      : status == 'pending'
                          ? Color(0xffA6B309)
                          : Colors.red),
            )
          ],
        ),
        verticalSpace(46),
        // const TransactionDetailsSection(
        //   title: 'Recipient',
        //   value: '08169784011',
        // ),
        // verticalSpace(24),
        TransactionDetailsSection(
          title: 'Transaction ID',
          value: '$referenceId',
          // iconData: Icons.copy,
        ),
        verticalSpace(24),
        TransactionDetailsSection(
          title: 'Transaction Type',
          value: '$type'.capitalize(),
        ),
        // verticalSpace(24),
        // const TransactionDetailsSection(
        //   title: 'Transaction Means',
        //   value: 'Wallet',
        // ),
        verticalSpace(24),
        TransactionDetailsSection(
          title: 'Type',
          value: subType.capitalize(),
        ),
        verticalSpace(24),
        TransactionDetailsSection(
          title: 'Date',
          value: date,
        ),
      ]),
    );
  }
}
