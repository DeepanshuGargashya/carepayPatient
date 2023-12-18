import 'package:CarePay/view_model/doctorFlow/personalDetailController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:url_launcher/url_launcher.dart';

class details extends StatefulWidget {
  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final formKeyMob = GlobalKey<FormState>();
  final formKeyName = GlobalKey<FormState>();
  final formKeyPan = GlobalKey<FormState>();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyDob = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<PersonalDetailsController>(context, listen: false);
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

  Widget build(BuildContext context) {
    final controller = Provider.of<PersonalDetailsController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        return false;
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
                        // SizedBox(height: 7 * fem),
                        Container(
                          width: 125 * fem,
                          height: 50 * fem,
                          // padding: EdgeInsets.only(top: 25),
                          child: Image(
                              image:
                                  AssetImage('assets/images/carePayLogo.png')),
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
                                image:
                                    AssetImage('assets/images/headphone.png')),
                          ),
                        ),
                      ]),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(28.0 * fem),
                child: Container(
                  // padding: EdgeInsets.only(top: 15),
                  margin: EdgeInsets.fromLTRB(10, 18, 0, 0),
                  child: BreadCrumb(
                    items: <BreadCrumbItem>[
                      BreadCrumbItem(
                          content: Text(
                        TextConstant.personal,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 22 * fem,
                            color: AppColors.primaryPurple),
                      )),
                      BreadCrumbItem(
                          content: Text(
                        TextConstant.practice,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            // fontWeight: FontWeight.w600,
                            fontSize: 14 * fem,
                            color: AppColors.grey),
                      )),
                      BreadCrumbItem(
                          content: Text(
                        TextConstant.address,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            // fontWeight: FontWeight.w600,
                            fontSize: 14 * fem,
                            color: AppColors.grey),
                      )),
                      BreadCrumbItem(
                          content: Text(TextConstant.bankDetails,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 14 * fem,
                                  color: AppColors.grey))),
                      BreadCrumbItem(
                          content: Text(TextConstant.documents,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 14 * fem,
                                  color: AppColors.grey))),
                    ],
                    divider: Icon(
                      Icons.saved_search_outlined,
                      color: AppColors.white,
                    ),
                    overflow: ScrollableOverflow(
                      keepLastDivider: true,
                      reverse: false,
                      direction: Axis.horizontal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.19,
                    // constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.height/1.25),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                TextConstant.phoneNumber,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontFamily: 'DM Sans',
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              // child : Text(numberValue.toString()),
                              child: Form(
                                key: formKeyMob,
                                child: TextFormField(
                                  controller: controller.mob,
                                  // controller : email,
                                  enabled: false,

                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  decoration: InputDecoration(
                                    fillColor: AppColors.ECEBFF,
                                    filled: true,
                                    hintText: TextConstant.enterPhoneNumber,

                                    // border : InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                        borderSide: BorderSide.none),
                                  ),
                                  // validator: (value){
                                  //   if(value!.isEmpty ||value.length<10){
                                  //     // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]
                                  //
                                  //     return 'Please enter correct mobile number';
                                  //   }else{
                                  //     return null;
                                  //   }
                                  // },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.fullName,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontFamily: 'DM Sans',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyName,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  onChanged: (value) {
                                    if (value.length > 2) {
                                      formKeyName.currentState!.validate();
                                    }
                                  },
                                  controller: controller.name,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterFullName,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return TextConstant.enterFullNamee;
                                    } else if (value.length < 2) {
                                      return TextConstant.invalidName;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.pan,
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyPan,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  maxLength: 10,
                                  onChanged: (value) {
                                    if (value.length > 8) {
                                      formKeyPan.currentState!.validate();
                                    }
                                    controller.pan.value = TextEditingValue(
                                        text: value.toUpperCase(),
                                        selection: controller.pan.selection);
                                  },
                                  controller: controller.pan,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterPan,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return TextConstant.enterPann;
                                    } else if (value.length < 10 ||
                                        value.length > 10) {
                                      return TextConstant.invalidPan;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.email,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontFamily: 'DM Sans',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyEmail,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  onChanged: (value) {
                                    if (value.length > 8) {
                                      formKeyEmail.currentState!.validate();
                                    }
                                  },
                                  controller: controller.emailId,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterEmail,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                      )

                                      // border : InputBorder.none,

                                      ,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                      return TextConstant.enterEmaill;
                                    } else if (!RegExp(r'\S+@\S+\.\S+')
                                        .hasMatch(value)) {
                                      return TextConstant.validEmail;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.dateOfBirth,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontFamily: 'DM Sans',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Form(
                                    key: formKeyDob,
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 16,
                                          height: 1.5),
                                      controller: controller.dob,
                                      // enabled: false,
                                      keyboardType: TextInputType.none,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors
                                                .redError, // or any other color
                                          ),
                                          suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              color: AppColors.primaryPurple),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText:
                                              TextConstant.enterDateOfBirth,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none)),
                                      onTap: () async {
                                        var res = await controller
                                            .showDatePickerr(context);
                                        if (res) {
                                          formKeyDob.currentState!.validate();
                                        }
                                      },
                                      validator: (value) {
                                        print(value);
                                        if (value == null || value.isEmpty) {
                                          return TextConstant.enterDateOfBirth;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12 * fem, width: 1),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10 * fem, left: 0, right: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15 * fem, 0, 15 * fem),
                                            child: Text(
                                              TextConstant.next,
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14 * fem),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (formKeyMob.currentState!.validate() &&
                                                formKeyName.currentState!
                                                    .validate() &&
                                                formKeyEmail.currentState!
                                                    .validate() &&
                                                formKeyPan.currentState!
                                                    .validate() &&
                                                formKeyDob.currentState!
                                                    .validate()) {
                                              controller
                                                  .handleSubmition(context);
                                            } else {
                                              print('andalsecondition');
                                              formKeyMob.currentState!
                                                  .validate();
                                              formKeyName.currentState!
                                                  .validate();
                                              formKeyEmail.currentState!
                                                  .validate();
                                              formKeyPan.currentState!
                                                  .validate();
                                              formKeyDob.currentState!
                                                  .validate();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
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
                            //   padding: EdgeInsets.only(top: 20),
                            //   child: Center(
                            //     child: ElevatedButton(
                            //         child: Text(
                            //           TextConstant.next,
                            //           style: TextStyle(
                            //               fontFamily: 'DM Sans',
                            //               fontWeight: FontWeight.w700,
                            //               fontSize: 14 * fem),
                            //         ),
                            //         onPressed: () {
                            //           if (formKeyMob.currentState!.validate() &&
                            //               formKeyName.currentState!
                            //                   .validate() &&
                            //               formKeyEmail.currentState!
                            //                   .validate() &&
                            //               formKeyPan.currentState!.validate() &&
                            //               formKeyDob.currentState!.validate()) {
                            //             controller.handleSubmition(context);
                            //           } else {
                            //             print('andalsecondition');
                            //             formKeyMob.currentState!.validate();
                            //             formKeyName.currentState!.validate();
                            //             formKeyEmail.currentState!.validate();
                            //             formKeyPan.currentState!.validate();
                            //             formKeyDob.currentState!.validate();
                            //           }
                            //         },
                            //         style: ElevatedButton.styleFrom(
                            //             backgroundColor:
                            //                 AppColors.primaryPurple,
                            //             fixedSize: Size(370, 50),
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(4*fem)))),
                            //   ),
                            // ),
                            SizedBox(height: 40 * fem),
                            // SizedBox(height: 20),
                            // Container(
                            //   child: Center(
                            //     child: dataResponse == null
                            //         ? Container()
                            //         : Text(dataResponse!['doctorId'].toString()),
                            //     // print( Text(dataResponse!['doctorId'].toString()),)
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
