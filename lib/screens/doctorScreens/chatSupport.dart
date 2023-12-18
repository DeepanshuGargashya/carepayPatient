import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/chatSupportController.dart';
import 'package:flutter/material.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatSupportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatSupportState();
  }
}

class ChatSupportState extends State<ChatSupportScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final formKeySend = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<ChatSupportController>(context, listen: false);
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

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<ChatSupportController>(context, listen: false);
      fetchData.timer(true);
      fetchData.setStopTimer(true);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ChatSupportController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          controller.timer(true);
          controller.setStopTimer(true);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TextConstant.chatsupport,
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 18 * fem,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () async {
                    Uri phoneno =
                        Uri.parse('tel:${TextConstant.helpNumber.toString()}');
                    if (await launchUrl(phoneno)) {
                      //dialer opened
                    } else {
                      //dailer is not opened
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: AppColors.primaryPurple,
                      ),
                      SizedBox(
                        width: 10 * fem,
                        height: 1,
                      ),
                      Text(TextConstant.callUs,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.primaryPurple,
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          color: AppColors.primaryPurple, width: 1 * fem),
                      backgroundColor: AppColors.ECEBFF,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6 * fem))),
                )),
              ],
            ),
            elevation: 0.5,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: AppColors.white),
            ),
          ),
          body: Scaffold(
              backgroundColor: AppColors.white,
              // color: AppColors.white,
              body: Container(
                  color: AppColors.white,
                  width: double.infinity,
                  height: screenHeight / 1.16,
                  child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: [
                          Container(
                            width: screenWidth,
                            height: screenHeight / 1.27,
                            // color: Colors.red,
                            child: Queries(controller.response),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.D3D9E0,
                                          )
                                        ]),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 16,
                                            height: 1.5),
                                        autofocus: false,
                                        key: formKeySend,
                                        controller: controller.sendController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.E9ECF5),
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.E9ECF5),
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                          contentPadding: EdgeInsets.all(20),
                                          isDense: true,
                                          // suffixIcon: Container(
                                          //   margin: EdgeInsets.only(right: 5),
                                          //   width: 40,
                                          //   height: 40,
                                          //   decoration: BoxDecoration(
                                          //       color: AppColors.primaryPurple,
                                          //       // gradient: LinearGradient(
                                          //       //     begin: Alignment.centerLeft,
                                          //       //     end: Alignment.centerRight,
                                          //       //     colors: <Color>[
                                          //       //       HexColor('#FF6A92'),
                                          //       //       HexColor('##FF5C5D')
                                          //       //     ]),
                                          //       // color: Colors.red,
                                          //       borderRadius: BorderRadius.circular(6)),
                                          //   child: InkWell(
                                          //     child:
                                          //         Image.asset('assets/images/sendIcon.png'),
                                          //     onTap: (){
                                          //       print('hi');
                                          //       controller.handleSubmition(context);
                                          //     },
                                          //   ),
                                          // ),
                                          hintText: TextConstant.reply,
                                          hintStyle: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                          // labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  controller.handleSubmition(context);
                                },
                                child:
                                    Image.asset('assets/images/upperArrow.png'),
                              )
                            ],
                          )
                        ],
                      )))),
        ),
      ),
    );
  }
}

Widget Queries(messages) {
  return NotificationListener<ScrollEndNotification>(
    onNotification: (scrollEnd) {
      final metrics = scrollEnd.metrics;
      if (metrics.atEdge) {
        bool isTop = metrics.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the Bottom');
        }
      }
      return true;
    },
    child: ListView.builder(
      itemCount: messages?.length != null ? messages.length : 0,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: messages[index]["operationId"] != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (messages[index]["operationId"] != null) ...[
                  // Image.asset('assets/images/iconDefault.png')
                ],
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 3),
                  child: Align(
                    alignment: (messages[index]["operationId"] != null
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.3),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                          color: AppColors.ECEBFF,
                          borderRadius: messages[index]["operationId"] != null
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(2),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                        ),
                        padding: EdgeInsets.all(13),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                              messages[index]["operationId"] != null
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                          children: [
                            Text(
                              messages[index]['body'].toString(),
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.ff182D64),
                            ),
                            // SizedBox(
                            //   height: 12,
                            // ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   mainAxisAlignment:
                            //       messages[index]["operationId"] != null
                            //           ? MainAxisAlignment.end
                            //           : MainAxisAlignment.start,
                            //   children: [
                            //     // Text(
                            //     //   "22 Dec 2022",
                            //     //   style: TextStyle(fontFamily: 'DM Sans',
                            //     //       color: AppColors.ff7681A1, fontSize: 11),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.symmetric(horizontal: 5),
                            //     //   width: 4,
                            //     //   height: 4,
                            //     //   decoration: BoxDecoration(
                            //     //       color: Colors.black,
                            //     //       borderRadius: BorderRadius.circular(50)),
                            //     // ),
                            //     // Text("3:00 pm",
                            //     //     style: TextStyle(fontFamily: 'DM Sans',
                            //     //         color: AppColors.ff7681A1, fontSize: 11))
                            //   ],
                            // ),
                          ],
                        )),
                  ),
                ),
                if (messages[index]["operationId"] == null) ...[
                  // Image.asset('assets/images/iconDefault.png')
                ]
              ],
            ),
          ),
        );
      },
    ),
  );
}
