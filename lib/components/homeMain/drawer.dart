import 'dart:io';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/chatSupport.dart';
import 'package:CarePay/screens/doctorScreens/doctorProfile.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerState();
  }
}

class DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeMainController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/images/X.png')),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: DoctorProfileScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.ECEBFF,
                        borderRadius: BorderRadius.circular(8 * fem)),
                    padding: EdgeInsets.fromLTRB(
                        10 * fem, 10 * fem, 10 * fem, 10 * fem),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: DoctorProfileScreen()),
                                    );
                                  },
                                  child: Container(
                                    width: 40 * fem,
                                    height: 40 * fem,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.secondaryOrange,
                                            width: 2 * fem),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.white,

                                        radius: 100,
                                        child: Text(
                                          controller.name.toString(),
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 14 * fem,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryPurple),
                                        ), //Text
                                      ),
                                    ),
                                  )),
                              SizedBox(width: 10),

                              // Container(
                              //   margin: EdgeInsets.fromLTRB(
                              //       0 * fem, 0 * fem, 8 * fem, 0 * fem),
                              //   width: 40,
                              //   height: 40,
                              //   decoration: BoxDecoration(
                              //       color: AppColors.white,
                              //       borderRadius: BorderRadius.circular(500),
                              //       border: Border.all(
                              //           color: AppColors.secondaryOrange,
                              //           width: 2 * fem)),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         TextConstant.dr,
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //             fontFamily: 'DM Sans',
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 16 * fem,
                              //             color: AppColors.primaryPurple),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: Text(
                                      '${TextConstant.dr}${''}${controller.response['name'].toString()}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 * fem,
                                          color:
                                              AppColors.black.withOpacity(0.8)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 3 * fem,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: Text(
                                      controller.response['speciality']
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14 * fem,
                                          color:
                                              AppColors.black.withOpacity(0.4)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15 * fem,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1,
                height: 10 * fem,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 70 * fem,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.primaryPurple.withOpacity(0.7),
                            width: 2 * fem),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4 * fem)),
                    child: ButtonTheme(
                        buttonColor: AppColors.white,
                        alignedDropdown: true,
                        child: DropdownButton(
                          underline: SizedBox(),
                          dropdownColor: AppColors.white,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          elevation: 2,
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(TextConstant.selectFromBelow),
                          ),
                          value: controller.clinicValue.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                          borderRadius: BorderRadius.circular(12 * fem),
                          items: controller.clinicsName.map((data) {
                            return DropdownMenuItem(
                                value: data,
                                child: Row(
                                  // mainAxisAlignment:
                                  // bankDropDownTagImageItems[
                                  // '${items}']
                                  //     .toString()
                                  //     .isEmpty
                                  //     ? MainAxisAlignment.center
                                  //     : MainAxisAlignment.start,
                                  children: [
                                    // if (data.toString().isNotEmpty) ...[
                                    //   SizedBox(
                                    //     width: 30,
                                    //     child: Image.asset(data.productImage),
                                    //   )
                                    // ],
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Expanded(
                                      child: Text(
                                        data,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (value) {
                            controller.setClinicValue(value);
                            // print(staffDropdownvalue);
                          },
                        )),
                  ),
                ],
              ),
              Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                  padding:
                      EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Center(
                              child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/qrLoader.gif",
                                  image: controller.response['qr_url'] ?? ''),
                              // child: Image.network(communityData['qrCodeUrl'] ?? ''
                            ),
                          ),

                          // <======== important ==========>

                          TextButton(
                            // onPressed: enableResend ? _resendCode : null,
                            onPressed: () {
                              _createPdf(context,
                                  controller.response['qr_url'].toString());
                            },
                            child: Text(
                              TextConstant.printQr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryPurple,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, -2.0),
                                    blurRadius: 0.0,
                                    color: AppColors.primaryPurple,
                                  ),
                                ],
                                // 'Work Sans',
                                fontFamily: 'DM Sans',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.1725 * ffem / fem,
                                color: AppColors.transparent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                            height: 10 * fem,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                        side: BorderSide(
                                            width: 2 * fem,
                                            color: AppColors.primaryPurple
                                                .withOpacity(0.7))),
                                    primary: AppColors.transparent,
                                    onSurface: AppColors.transparent,
                                    shadowColor: AppColors.transparent,
                                    backgroundColor: AppColors.white),
                                onPressed: () {
                                  controller.handleShareButton();
                                },
                                child: Container(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.center,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 8 * fem, 0 * fem, 8 * fem),
                                    // width: MediaQuery.of(context)
                                    //         .size
                                    //         .width /
                                    //     3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          TextConstant.shareLink,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "DM Sans",
                                            // 'Work Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.1725 * fem / fem,
                                            color: AppColors.primaryPurple,
                                            // letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7 * fem,
                                          height: 1,
                                        ),
                                        Icon(
                                          Icons.share,
                                          color: AppColors.primaryPurple,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: 1,
                height: 5 * fem,
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                padding:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: MediaQuery.of(context).size.width / 1.3,
                height: 2 * fem,
                color: AppColors.black.withOpacity(0.2),
              ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
              //   padding:
              //       EdgeInsets.fromLTRB(12 * fem, 0 * fem, 12 * fem, 0 * fem),
              //   width: MediaQuery.of(context).size.width / 1.3,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // Text(
              //       //   TextConstant.support,
              //       //   style: TextStyle(
              //       //       fontFamily: 'DM Sans',
              //       //       fontSize: 14 * fem,
              //       //       fontWeight: FontWeight.w700,
              //       //       color: AppColors.primaryPurple.withOpacity(0.6)),
              //       // )
              //     ],
              //   ),
              // ),
              Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                  padding:
                      EdgeInsets.fromLTRB(15 * fem, 0 * fem, 15 * fem, 0 * fem),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextConstant.support,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryPurple.withOpacity(0.6)),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: ChatSupportScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat,
                              color: AppColors.primaryPurple,
                            ),
                            SizedBox(
                              width: 20 * fem,
                              height: 1,
                            ),
                            Text(
                              TextConstant.chat,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: AppColors.black.withOpacity(0.8),
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 20 * fem,
                      ),
                      InkWell(
                        onTap: () async {
                          Uri phoneno =
                              Uri.parse('tel:${TextConstant.helpNumber}');
                          if (await launchUrl(phoneno)) {
                            //dialer opened
                          } else {
                            //dailer is not opened
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 25 * fem,
                              height: 25 * fem,
                              // padding: EdgeInsets.only(top: 25),
                              child: Image(
                                  image: AssetImage('assets/images/help.png')),
                            ),
                            SizedBox(
                              width: 20 * fem,
                              height: 1,
                            ),
                            Text(
                              TextConstant.call,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: AppColors.black.withOpacity(0.8),
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 1,
                      //   height: 20 * fem,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(
                      //       10 * fem, 0 * fem, 10 * fem, 0 * fem),
                      //   // group167cge (455:270)
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 20 * fem, 0 * fem, 0 * fem),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12 * fem),
                      //   ),
                      //   child: InkWell(
                      //       onTap: () {
                      //         controller.handleLogout(context);
                      //       },
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(
                      //             Icons.power_settings_new_rounded,
                      //             color: AppColors.primaryOrange,
                      //             size: 18 * fem,
                      //           ),
                      //           SizedBox(
                      //             width: 7 * fem,
                      //             height: 1,
                      //           ),
                      //           Text(
                      //             TextConstant.logout,
                      //             style: TextStyle(
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w400,
                      //                 fontSize: 14 * fem,
                      //                 color: AppColors.primaryOrange),
                      //           )
                      //         ],
                      //       )),
                      // ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDocument(String value) {
    Widget inter = Container();
    print(value);
    var uri = Uri.parse(value);
    uri.queryParameters.forEach((k, v) async {
      if (k == TextConstant.type && v == TextConstant.img ||
          k == TextConstant.type && v == TextConstant.jpg ||
          k == TextConstant.type && v == TextConstant.jpeg ||
          k == TextConstant.type && v == TextConstant.png) {
        inter = Container(
          // height: 80,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Image.network(value.toString()),
        );
      } else if (k == TextConstant.type && v == TextConstant.pdf) {
        print("$value");
        inter = Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 1.5,
          child: SfPdfViewer.network(value.toString()),
        );
      } else {
        inter = Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Image.network(
            value.toString(),
            fit: BoxFit.cover,
          ),
        );
      }
    });
    return inter;
  }

  void _createPdf(BuildContext context, value) async {
    final doc = pw.Document();
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    print("value");
    print(value);

    var uri = Uri.parse(value);
    print(uri);
    uri.queryParameters.forEach((k, v) async {
      print(k + v);
      if (k == TextConstant.type && v == TextConstant.pdf) {
        print("$value");
        var file = File('');
        if (Platform.isAndroid) {
          var status = await Permission.storage.status;
          if (status != PermissionStatus.granted) {
            status = await Permission.storage.request();
          }
          if (status.isGranted) {
            const downloadsFolderPath = '/storage/emulated/0/Download/';
            Directory dir = Directory(downloadsFolderPath);
            file = File('${dir.path}/qrPdf');
          }
        }
      } else if (k == TextConstant.type && v == TextConstant.img ||
          k == TextConstant.type && v == TextConstant.jpg ||
          k == TextConstant.type && v == TextConstant.jpeg ||
          k == TextConstant.type && v == TextConstant.png) {
        print("hello");
        final netImage = await networkImage(value.toString());
        doc.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(netImage),
              );
            }));

        /// print the document using the iOS or Android print service:
        await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => doc.save());
      }
    });
  }
}
