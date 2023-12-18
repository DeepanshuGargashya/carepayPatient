import 'package:CarePay/components/doctorProfile/eachDetail.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/chatSupport.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:CarePay/view_model/doctorFlow/doctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:CarePay/res/textConstant.dart';

class DocumentTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DocumentTabState();
  }
}

class DocumentTabState extends State<DocumentTabScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyEditName = GlobalKey<FormState>();
  final _formKeyEditEmail = GlobalKey<FormState>();
  final _formKeyEditPan = GlobalKey<FormState>();
  final _formKeyEditMob = GlobalKey<FormState>();

  final _formKeyEditBuilding = GlobalKey<FormState>();
  final _formKeyEditLocality = GlobalKey<FormState>();
  final _formKeyEditPincode = GlobalKey<FormState>();
  final _formKeyEditCity = GlobalKey<FormState>();

  final _formKeyEditLicense = GlobalKey<FormState>();
  final _formKeyEditClinicName = GlobalKey<FormState>();
  final _formKeyEditBuisnessEntity = GlobalKey<FormState>();

  final _formKeyEditAccount = GlobalKey<FormState>();
  final _formKeyEditHolderName = GlobalKey<FormState>();
  final _formKeyEditIFSC = GlobalKey<FormState>();
  final _formKeyEditBankName = GlobalKey<FormState>();
  final _formKeyEditBranchName = GlobalKey<FormState>();

  @override
  void initState() {
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

  var editModalHeight = 200;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DoctorProfileController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;

    return Container(
      padding: EdgeInsets.fromLTRB(10 * fem, 0, 10 * fem, 0),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(top: 20),
                      child: Text(TextConstant.dpPanCard,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (controller.panCardUploadName.length > 0) ...[
                            IconButton(
                                onPressed: () => {
                                      Utils.showDocumentDialogue(
                                          context,
                                          _showDocument(
                                              controller.panCardUploadName))
                                      // _showDocument(controller.panCardUploadName))
                                    },
                                icon: Icon(
                                  Icons.remove_red_eye_sharp,
                                  size: 20 * fem,
                                )),
                          ],
                          IconButton(
                              onPressed: () => {
                                    controller.openModal(
                                        context, TextConstant.sendPanCard)
                                  },
                              icon: Icon(Icons.edit, size: 20 * fem)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(top: 20),
                      child: Text(TextConstant.dpCheque,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (controller.chequeUploadName.length > 0) ...[
                            IconButton(
                                onPressed: () => {
                                      Utils.showDocumentDialogue(
                                          context,
                                          _showDocument(
                                              controller.chequeUploadName))
                                      // _showDocument(controller.panCardUploadName))
                                    },
                                icon: Icon(
                                  Icons.remove_red_eye_sharp,
                                  size: 20 * fem,
                                )),
                          ],
                          IconButton(
                              onPressed: () => {
                                    controller.openModal(
                                        context, TextConstant.sendChecque)
                                  },
                              icon: Icon(Icons.edit, size: 20 * fem)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.only( top: 20),
                      child: Text(TextConstant.dpGstin,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (controller.gstindUploadName.length > 0) ...[
                              IconButton(
                                  onPressed: () => {
                                        Utils.showDocumentDialogue(
                                            context,
                                            _showDocument(
                                                controller.gstindUploadName))
                                        // _showDocument(controller.panCardUploadName))
                                      },
                                  icon: Icon(
                                    Icons.remove_red_eye_sharp,
                                    size: 20 * fem,
                                  )),
                            ],
                            IconButton(
                                onPressed: () => {
                                      controller.openModal(
                                          context, TextConstant.sendGST)
                                    },
                                icon: Icon(Icons.edit, size: 20 * fem)),
                          ]),
                    )
                  ],
                ),
                // InkWell(
                //   onTap: () {
                //     if (controller.gstindUploadName.length == 0) {
                //       controller.openModal(context, TextConstant.sendGST);
                //     } else {}
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                //   },
                //   child: GestureDetector(
                //     child: controller.gstindUploadName.length > 0
                //         ? Center(
                //             child: Container(
                //               padding:
                //                   EdgeInsets.fromLTRB(0, 10 * fem, 0, 10 * fem),
                //               decoration: BoxDecoration(
                //                   // color: AppColors.primaryGreen
                //                   //     .withOpacity(0.1),
                //                   border: Border.all(
                //                       color: AppColors.primaryPurple),
                //                   borderRadius: BorderRadius.circular(12)),
                //               width: double.infinity,
                //               height: 100 * fem,
                //               // padding: EdgeInsets.only(top: 25),
                //               child: Image(
                //                 image: AssetImage('assets/images/uploaded.png'),
                //                 color: AppColors.primaryPurple,
                //               ),
                //             ),
                //           )
                //         : Container(
                //             width: 390,
                //             height: 80,
                //             // padding: EdgeInsets.only(top: 40),
                //             color: AppColors.ECEBFF,
                //             child: Center(
                //               child: TextButton.icon(
                //                 icon: Icon(Icons.cloud_download,
                //                     color: AppColors.grey),
                //                 label: Text(TextConstant.uploadDocuments,
                //                     style: TextStyle(
                //                         fontFamily: 'DM Sans',
                //                         color: AppColors.grey)),
//                 onPressed: () {
                //                   controller.openModal(
                //                       context, TextConstant.sendGST);
                //                   // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                //                 },
//                 // style: ElevatedButton.styleFrom(
                //                 //   primary: Color(0xff00000066),
                //                 //   // fixedSize: Size(350,50),
                //                 // )
                //               ),
                //             ),
                //           ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
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
