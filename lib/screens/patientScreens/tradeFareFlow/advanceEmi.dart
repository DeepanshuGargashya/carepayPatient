import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdvanceEmi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdvanceEmiState();
  }
}

class AdvanceEmiState extends State<AdvanceEmi> {
  var borrowFor = ["Myself", "Someone else"];

  var _borrowForValue = "";
  get borrowForValue => _borrowForValue;

  setBorrowFor(value) {
    _borrowForValue = value;
    // notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 360;
    double ffem = fem * 0.97;
    // TODO: implement build

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0 * fem),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: false,
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Credit application',
            style: TextStyle(
                fontSize: 18 * fem,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.8)),
          ),
          automaticallyImplyLeading: false,
          // actions: [Text('Charging Status')],

          elevation: 2,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20 * fem,
              ),
              Text('Advance Payment',
                  style: TextStyle(
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              SizedBox(
                height: 10 * fem,
              ),
              Text(
                  'You have selected an EMI plan with Rs. 30,000 advance payment, this will result in final credit amount of Rs 60,000 only.',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff071329))),
              SizedBox(
                height: 20 * fem,
              ),
              Text('Treatment amount',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8))),
              SizedBox(height: 10 * fem),
              Text('Rs 90,000',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              SizedBox(
                height: 20 * fem,
              ),
              Text('Final credit amount',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8))),
              SizedBox(height: 10 * fem),
              Text('Rs 90,000',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              SizedBox(
                height: 20 * fem,
              ),
              Text('Advance payment',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8))),
              SizedBox(height: 10 * fem),
              Text('Rs 90,000',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              SizedBox(height: 20 * fem),
              Container(
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    //   // width: 5,
                    // ),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color(0xff514C9F),
                    //       spreadRadius: 0,
                    //       blurRadius: 0,
                    //       offset: const Offset(-4, 6)
                    //   )
                    // ],
                    color: Color(0xFFFAE1CD),
                    borderRadius: BorderRadius.circular(5 * fem)),
                child: Text(
                    'You will have to make this advance payment of Rs. 30,000 to the clinic/doctor/hospital to start your treatment.',
                    style: TextStyle(
                        fontSize: 14 * fem,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff071329))),
              ),
              SizedBox(height: 15 * fem),
              Container(
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    //   // width: 5,
                    // ),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color(0xff514C9F),
                    //       spreadRadius: 0,
                    //       blurRadius: 0,
                    //       offset: const Offset(-4, 6)
                    //   )
                    // ],
                    color: Color(0xFFECEBFF),
                    borderRadius: BorderRadius.circular(5 * fem)),
                child: Text(
                  'Share the breakdown of payment with clinic/doctor/hospital',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff071329)),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 0 * fem, left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 15 * fem, 0, 15 * fem),
                              child: Text(
                                "Share and proceed",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14 * fem),
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff514C9F),
                                // fixedSize: Size(380, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)))),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20 * fem,
              ),
              Text(
                'Or select another EMI plan to change the advance payment amount',
                style: TextStyle(
                    fontSize: 14 * fem,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff071329)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10 * fem),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 10 * fem, left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 15 * fem, 0, 15 * fem),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xff514C9F),
                                  ),
                                  Text(
                                    "Change EMI plan",
                                    style: TextStyle(
                                        color: Color(0xff514C9F),
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14 * fem),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Color(0xffECEBFF),
                                // fixedSize: Size(380, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)))),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20 * fem),
              SizedBox(height: 20 * fem),
              Center(
                  child: Text('For more details and enquiries, reach out to us',
                      style: TextStyle(
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black.withOpacity(0.8)))),
              SizedBox(height: 15 * fem),
              InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute<void>(
                    //   builder: (BuildContext context) =>  AddChargers(),
                    // ),);
                  },
                  child: Center(
                      child: Text('Contact Support',
                          style: TextStyle(
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF514C9F),
                              decoration: TextDecoration.underline)))),
            ],
          ),
        ),
      ),
    );
  }
}
