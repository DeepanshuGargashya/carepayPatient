import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/screens/doctorScreens/chatSupport.dart';
import 'package:CarePay/screens/doctorScreens/faqScreen.dart';
import 'package:CarePay/view_model/doctorFlow/prebottomController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PreBottomWidget extends StatefulWidget {
  final showFaq;

  PreBottomWidget({required this.showFaq});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PreBottomState();
  }
}

class PreBottomState extends State<PreBottomWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<PreBottomController>(context, listen: false);
      fetchData.initFetchData(
        context,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PreBottomController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    // TODO: implement build
    return Column(
      children: [
        if (widget.showFaq) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.ECEBFF,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    children: [
                      // Container(
                      //   // padding: EdgeInsets.only(top: 25),
                      //   child: Image(image: AssetImage('assets/images/think.png')),
                      // ),
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image(
                                image:
                                    AssetImage('assets/images/thinkEmoji.png')),
                          ),
                          Text(TextConstant.faqs,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color:
                                      AppColors.primaryPurple.withOpacity(0.7),
                                  fontSize: 24 * fem,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: AppColors.black.withOpacity(0.05)))),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 8 * fem, right: 8 * fem),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 1.32,
                          child: Text(
                            TextConstant.howMuch,
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: AppColors.black,
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: FaqScreen(
                                    TextConstant.howMuch,
                                  )),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                          ))
                      // TextFormField(
                      //
                      //   decoration: InputDecoration(
                      //     hintText: 'How much time does it take to get loan processed?',
                      //   ),
                      //
                      //
                      // )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: AppColors.black.withOpacity(0.05)))),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 8 * fem, right: 8 * fem),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TextConstant.anyChanges,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: FaqScreen(
                                    TextConstant.anyChanges,
                                  )),
                            );
                          },
                          icon:
                              Icon(Icons.arrow_forward_ios_outlined, size: 20))
                      // TextFormField(
                      //
                      //   decoration: InputDecoration(
                      //     hintText: 'How much time does it take to get loan processed?',
                      //   ),
                      //
                      //
                      // )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: AppColors.black.withOpacity(0.05)))),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 8 * fem, right: 8 * fem),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TextConstant.isLoan,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: FaqScreen(TextConstant.isLoan)),
                            );
                          },
                          icon:
                              Icon(Icons.arrow_forward_ios_outlined, size: 20))
                      // TextFormField(
                      //
                      //   decoration: InputDecoration(
                      //     hintText: 'How much time does it take to get loan processed?',
                      //   ),
                      //
                      //
                      // )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: FaqScreen()),
                          );
                        },
                        child: Text(
                          TextConstant.allFaqs,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryPurple,
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w700),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],

        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
              color: AppColors.tertiaryGreen,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Center(
                  child: Text(
                    TextConstant.needHelp,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14 * fem),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                  child: Text(TextConstant.helpYou,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.primaryGreen.withOpacity(0.7),
                          fontSize: 24 * fem,
                          fontWeight: FontWeight.w700))),
              SizedBox(height: 25),
              Center(
                child: Container(
                  height: 41,
                  width: 180,
                  // color: Colors.white,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Uri phoneno = Uri.parse(
                          'tel:${TextConstant.helpNumber.toString()}');
                      if (await launchUrl(phoneno)) {
                        //dialer opened
                      } else {
                        //dailer is not opened
                      }
                    },
                    label: Text(
                      TextConstant.call,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryGreen),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: StadiumBorder(),
                        backgroundColor: Colors.white),
                    icon: Icon(Icons.phone, color: AppColors.primaryGreen),
                  ),
                ),
              )
            ],
          ),
        ),
        // SizedBox(height:20),
        if (controller.authenticate) ...[
          Container(
            padding: EdgeInsets.all(26),
            child: Center(
                child: Text(
              TextConstant.advices,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * fem),
            )),
          ),
          // SizedBox(height:10),
          Center(
              child: Text(TextConstant.someAdvice,
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      color: AppColors.secondaryOrange,
                      fontSize: 24 * fem,
                      fontWeight: FontWeight.w700))),
          SizedBox(height: 20),

          Center(
            child: Container(
              height: 41,
              width: 170,
              // color: Colors.white,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: ChatSupportScreen()),
                  );
                },
                label: Text(
                  TextConstant.chat,
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: StadiumBorder(),
                    backgroundColor: AppColors.secondaryOrange),
                icon: Icon(Icons.chat, color: AppColors.white),
              ),
            ),
          ),

          SizedBox(height: 30),
        ],

        //
      ],
    );
  }
}
