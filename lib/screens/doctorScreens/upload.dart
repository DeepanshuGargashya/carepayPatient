import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/view_model/doctorFlow/uploadDoctorDetailController.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/utils.dart';
import 'bank_details.dart';

class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<UploadDetailController>(context, listen: false);
      fetchData.initFetchData(context);
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);

    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.4,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    _animationController.forward();
    super.initState();
  }

  // bool isButtonActive = false;
  final formKey = GlobalKey<FormState>();

  // bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UploadDetailController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: bank_details()),
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                centerTitle: false,
                automaticallyImplyLeading: false,
                elevation: 0,
                leadingWidth: 0 * fem,
                backgroundColor: AppColors.white,
                title: Column(
                  children: [
                    SizedBox(height: 14 * fem),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 125 * fem,
                            height: 50 * fem,
                            // padding: EdgeInsets.only(top: 25),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/carePayLogo.png')),
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
                            child: Container(
                              width: 32 * fem,
                              height: 32 * fem,
                              // padding: EdgeInsets.only(top: 25),
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/headphone.png')),
                            ),
                          ),
                        ]),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(28.0 * fem),
                  child: Container(
                    padding: EdgeInsets.only(top: 16),
                    child: BreadCrumb(
                      items: <BreadCrumbItem>[
                        BreadCrumbItem(
                            content: Text(TextConstant.personal,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 14 * fem,
                                    color: AppColors.primaryPurple))),
                        BreadCrumbItem(
                            content: Text(TextConstant.practice,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 14 * fem,
                                    color: AppColors.primaryPurple))),
                        BreadCrumbItem(
                            content: Text(
                          TextConstant.address,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              // fontWeight: FontWeight.w600,
                              fontSize: 14 * fem,
                              color: AppColors.primaryPurple),
                        )),
                        BreadCrumbItem(
                            content: Text(
                              TextConstant.bankDetails,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  // fontWeight: FontWeight.w400,
                                  fontSize: 14 * fem,
                                  color: AppColors.primaryPurple),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: bank_details()),
                              );
                            }),
                        BreadCrumbItem(
                            content: Text(TextConstant.documents,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24 * fem,
                                    color: AppColors.primaryPurple))),
                      ],
                      divider:
                          Icon(Icons.arrow_right_sharp, color: AppColors.white),
                      overflow: ScrollableOverflow(
                        physics: ScrollPhysics(),
                        // keepLastDivider: true,
                        reverse: true,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.25,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.panCardOptional,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  if (controller.panCardUploadName.length ==
                                      0) {
                                    controller.openModal(
                                        context, TextConstant.sendPanCard);
                                  } else {}
                                  ;
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                },
                                child: GestureDetector(
                                  child: Center(
                                    child: controller.panCardUploadName.length >
                                            0
                                        ? Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10 * fem, 0, 10 * fem),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.primaryGreen
                                                  //     .withOpacity(0.1),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryPurple),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              width: double.infinity,
                                              height: 80 * fem,
                                              // padding: EdgeInsets.only(top: 25),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/uploaded.png'),
                                                color: AppColors.primaryPurple,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            // width: 390,
                                            height: 80,
                                            // padding: EdgeInsets.only(top: 20),
                                            color: AppColors.ECEBFF,
                                            child: Center(
                                              child: Center(
                                                child: TextButton.icon(
                                                  icon: Icon(
                                                    Icons.cloud_download,
                                                    color: AppColors.grey,
                                                  ),

                                                  label: Text(
                                                    TextConstant
                                                        .uploadDocuments,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        fontFamily: 'DM Sans',
                                                        color: AppColors.black
                                                            .withOpacity(0.4)),
                                                  ),
                                                  onPressed: () {
                                                    controller.openModal(
                                                        context,
                                                        TextConstant
                                                            .sendPanCard);
                                                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                                  },

                                                  // style: ElevatedButton.styleFrom(
                                                  //   primary: Color(0xff00000066),
                                                  //   // fixedSize: Size(350,50),
                                                  // )
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 6),
                              if (controller.panCardUploadName.length > 0) ...[
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller.openModal(context,
                                                  TextConstant.sendPanCard);
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                            },
                                            child: Text(TextConstant.reUpload,
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color:
                                                        AppColors.primaryPurple,
                                                    fontSize: 14 * fem,
                                                    fontFamily: 'DM Sans'))),
                                        InkWell(
                                            onTap: () {
                                              Utils.showDocumentDialogue(
                                                  context,
                                                  _showDocument(controller
                                                      .panCardUploadName));
                                              // _showDocument(controller.panCardUploadName))
                                            },
                                            child: Text(
                                              TextConstant.viewDocument,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryPurple,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14 * fem),
                                            ))
                                      ]),
                                ),
                              ],
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                // padding: EdgeInsets.only(top: 20),
                                child: Text(TextConstant.cheque,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.chequeUploadName.length == 0) {
                                    controller.openModal(
                                        context, TextConstant.sendChecque);
                                  } else {}
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                },
                                child: GestureDetector(
                                  child: controller.chequeUploadName.length > 0
                                      ? Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10 * fem, 0, 10 * fem),
                                            decoration: BoxDecoration(
                                                // color: AppColors.primaryGreen
                                                //     .withOpacity(0.1),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryPurple),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            width: double.infinity,
                                            height: 80 * fem,
                                            // padding: EdgeInsets.only(top: 25),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/uploaded.png'),
                                              color: AppColors.primaryPurple,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: 80,
                                          // padding: EdgeInsets.only(top: 40),
                                          color: AppColors.ECEBFF,
                                          child: Center(
                                            child: TextButton.icon(
                                              icon: Icon(Icons.cloud_download,
                                                  color: AppColors.grey),
                                              label: Text(
                                                TextConstant.uploadDocuments,
                                                // controller.chequeUploadName
                                                //     .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    fontFamily: 'DM Sans',
                                                    color: AppColors.black
                                                        .withOpacity(0.4)),
                                              ),

                                              onPressed: () {
                                                controller.openModal(context,
                                                    TextConstant.sendChecque);
                                                // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                              },

                                              // style: ElevatedButton.styleFrom(
                                              //   primary: Color(0xff00000066),
                                              //   // fixedSize: Size(350,50),
                                              // )
                                            ),
                                          ),
                                        ),
                                ),
                              ),

                              if (controller.chequeError) ...[
                                Text(
                                  "This field is required ",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.red),
                                ),
                              ],
                              SizedBox(height: 6),

                              if (controller.chequeUploadName.length > 0) ...[
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller.openModal(context,
                                                  TextConstant.sendChecque);
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                            },
                                            child: Text(TextConstant.reUpload,
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color:
                                                        AppColors.primaryPurple,
                                                    fontSize: 14 * fem,
                                                    fontFamily: 'DM Sans'))),
                                        InkWell(
                                            onTap: () {
                                              Utils.showDocumentDialogue(
                                                  context,
                                                  _showDocument(controller
                                                      .chequeUploadName));
                                            },
                                            child: Text(
                                              TextConstant.viewDocument,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryPurple,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14 * fem),
                                            ))
                                      ]),
                                ),
                              ],

                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                // padding: EdgeInsets.only( top: 20),
                                child: Text(TextConstant.gstinOptional,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.gstindUploadName.length == 0) {
                                    controller.openModal(
                                        context, TextConstant.sendGST);
                                  } else {}
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                },
                                child: GestureDetector(
                                  child: controller.gstindUploadName.length > 0
                                      ? Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10 * fem, 0, 10 * fem),
                                            decoration: BoxDecoration(
                                                // color: AppColors.primaryGreen
                                                //     .withOpacity(0.1),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryPurple),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            width: double.infinity,
                                            height: 80 * fem,
                                            // padding: EdgeInsets.only(top: 25),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/uploaded.png'),
                                              color: AppColors.primaryPurple,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 390,
                                          height: 80,
                                          // padding: EdgeInsets.only(top: 40),
                                          color: AppColors.ECEBFF,
                                          child: Center(
                                            child: TextButton.icon(
                                              icon: Icon(Icons.cloud_download,
                                                  color: AppColors.grey),
                                              label: Text(
                                                TextConstant.uploadDocuments,
                                                // controller.gstindUploadName
                                                //     .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    fontFamily: 'DM Sans',
                                                    color: AppColors.black
                                                        .withOpacity(0.4)),
                                              ),

                                              onPressed: () {
                                                controller.openModal(context,
                                                    TextConstant.sendGST);
                                                // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                              },

                                              // style: ElevatedButton.styleFrom(
                                              //   primary: Color(0xff00000066),
                                              //   // fixedSize: Size(350,50),
                                              // )
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 6),

                              if (controller.gstindUploadName.length > 0) ...[
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller.openModal(context,
                                                  TextConstant.sendGST);
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                                            },
                                            child: Text(TextConstant.reUpload,
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color:
                                                        AppColors.primaryPurple,
                                                    fontSize: 14 * fem,
                                                    fontFamily: 'DM Sans'))),
                                        InkWell(
                                            onTap: () {
                                              Utils.showDocumentDialogue(
                                                  context,
                                                  _showDocument(controller
                                                      .gstindUploadName));
                                            },
                                            child: Text(
                                              TextConstant.viewDocument,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryPurple,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14 * fem),
                                            ))
                                      ]),
                                ),
                              ],
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                // margin: EdgeInsets.only(right: 200),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        activeColor: AppColors.primaryPurple,
                                        checkColor: AppColors.white,
                                        value: controller.isChecked,
                                        onChanged: (bool? newValue) {
                                          controller.setIsChecked(newValue);
                                        }),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: TextConstant.accept,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontSize: 14 * fem,
                                                  color: AppColors.black)),
                                          TextSpan(
                                              text:
                                                  TextConstant.termsConditions,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontSize: 14 * fem,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      controller.isCheckedError
                                                          ? AppColors.red
                                                          : AppColors.black)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 0, right: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15 * fem, 0, 15 * fem),
                                              child: Text(
                                                TextConstant.submit,
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14 * fem),
                                              ),
                                            ),
                                            onPressed: () {
                                              controller
                                                  .handleSubmition(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.primaryPurple,
                                                // fixedSize: Size(380, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4 * fem)))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Container(
                              //   // controller : nameController,
                              //   padding: EdgeInsets.only(top: 15),
                              //
                              //   child: Center(
                              //     child: ElevatedButton(
                              //         child: Text(
                              //           TextConstant.submit,
                              //           style: TextStyle(
                              //               fontFamily: 'DM Sans',
                              //               fontWeight: FontWeight.w700,
                              //               fontSize: 14 * fem),
                              //         ),
                              //         onPressed: () {
                              //           controller.handleSubmition(context);
                              //         },
                              //         style: ElevatedButton.styleFrom(
                              //             backgroundColor:
                              //                 AppColors.primaryPurple,
                              //             fixedSize: Size(370, 50),
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10)))),
                              //   ),
                              // ),
                              SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _showDocument(value) {
    Widget inter = Container();
    print(value);
    var uri = Uri.parse(value);
    uri.queryParameters.forEach((k, v) async {
      if (k == TextConstant.type && v == TextConstant.img ||
          k == TextConstant.type && v == TextConstant.jpg ||
          k == TextConstant.type && v == TextConstant.jpeg ||
          k == TextConstant.type && v == TextConstant.png) {
        inter = Container(
          height: MediaQuery.of(context).size.height / 2.5,
          // height: 80,
          width: double.infinity,
          child: Center(
            child: FadeInImage.assetNetwork(
                placeholder: "assets/images/loadImage.gif", image: value ?? ''),
            // child: Image.network(communityData['qrCodeUrl'] ?? ''
          ),
        );
      } else if (k == TextConstant.type && v == TextConstant.pdf) {
        print("$value");
        inter = Container(
          height: MediaQuery.of(context).size.height / 2.5,
          // height: 80,
          width: double.infinity,
          child: SfPdfViewer.network(value),
        );
      } else {
        inter = Container(
          height: MediaQuery.of(context).size.height / 2.5,
          // height: 80,
          width: double.infinity,
          child: Center(
            child: FadeInImage.assetNetwork(
                placeholder: "assets/images/loadImage.gif", image: value ?? ''),
            // child: Image.network(communityData['qrCodeUrl'] ?? ''
          ),
        );
      }
    });
    return inter;
  }
}
