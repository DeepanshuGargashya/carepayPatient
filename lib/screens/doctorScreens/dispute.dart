import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../res/textConstant.dart';
import '../../view_model/doctorFlow/disputeController.dart';

class Dispute extends StatefulWidget {
  var loanId = "";
  var userId = "";
  Dispute({required this.loanId, required this.userId});
  // @override
  @override
  State<Dispute> createState() => _DisputeState();
}

class _DisputeState extends State<Dispute> with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<DisputeController>(context, listen: false);
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

  final description = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DisputeController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                TextConstant.dispute,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              elevation: 1,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12 * fem),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 22),
                        child: Text(TextConstant.description,
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Form(
                          key: description,
                          child: TextFormField(
                            style: const TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16,
                                height: 1.5),
                            // controller: controller.pinCode,
                            controller: controller.descriptions,
                            // onChanged: (value) async {
                            //   if (value.length == 6) {
                            //     var res =
                            //     await descriptions();
                            //     if (res) {
                            //       description.currentState!.validate();
                            //     }
                            //   }
                            // },
                            // maxLength: 6,
                            // obscureText: true,

                            decoration: InputDecoration(
                                fillColor: AppColors.ECEBFF,
                                filled: true,
                                hintText: TextConstant.enterDescription,

                                // border : InputBorder.none,

                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem),
                                    borderSide: BorderSide.none)
                                // ),

                                ),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]
                            //
                            //     return TextConstant.pincode;
                            //   } else if (value.length < 6) {
                            //     return TextConstant.invalidPincode;
                            //   } else if (descriptions) {
                            //     return TextConstant.invalidPincode;
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(top: 22),
                        child: Text(TextConstant.screenshot,
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black)),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          controller.openFiles(TextConstant.sendPanCard);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>thank_you()));
                        },
                        child: GestureDetector(
                          child: Center(
                            child: controller.screenshot.toString().length > 2
                                ? Center(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 10 * fem, 0, 10 * fem),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryGreen
                                              .withOpacity(0.1),
                                          border: Border.all(
                                              color: AppColors.primaryGreen),
                                          borderRadius:
                                              BorderRadius.circular(4 * fem)),
                                      width: double.infinity,
                                      height: 100 * fem,
                                      // padding: EdgeInsets.only(top: 25),
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/success.png')),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    // width: 390,
                                    height: 100 * fem,
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
                                            TextConstant.uploadDocuments,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.grey),
                                          ),
                                          onPressed: () {
                                            controller.openFiles(
                                                TextConstant.sendPanCard);
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
                      SizedBox(height: 20 * fem),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 10 * fem, 0, 0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10, left: 0, right: 0),
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
                                      controller.handleSubmition(context,
                                          widget.loanId, widget.userId);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColors.primaryPurple,

                                        // fixedSize: Size(380, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4 * fem)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
