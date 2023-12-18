import 'package:CarePay/components/homeMain/drawer.dart';
import 'package:CarePay/components/homeMain/insight.dart';
import 'package:CarePay/components/homeMain/transactions.dart';
import 'package:CarePay/screens/doctorScreens/addPatient.dart';
import 'package:CarePay/screens/doctorScreens/aiAssistant.dart';
import 'package:CarePay/screens/doctorScreens/bottom_bar.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';

class homeMain extends StatefulWidget {
  const homeMain({Key? key}) : super(key: key);

  @override
  State<homeMain> createState() => _homeMainState();
}

class _homeMainState extends State<homeMain>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<HomeMainController>(context, listen: false);
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
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeMainController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.white,
        key: _key,
        drawer: Drawer(
            width: MediaQuery.of(context).size.width / 1.2,
            child: DrawerWidget()),
        appBar: AppBar(
            backgroundColor: AppColors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: AppColors.white),
            ),
            //leading: Padding(padding:EdgeInsets.only(top: 100),),
            title: Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.menu,
                    size: 30,
                    color: AppColors.primaryPurple.withOpacity(0.7),
                  ),
                  onTap: () {
                    _key.currentState?.openDrawer();
                  },
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5 * fem),
                      Container(
                        width: 115 * fem,
                        height: 45 * fem,
                        // padding: EdgeInsets.only(top: 25),
                        child: Image(
                            image: AssetImage('assets/images/carePayLogo.png')),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: AddPatientScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryPurple),
                        color: AppColors.ECEBFF,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6))),
                    child: Padding(
                      padding: EdgeInsets.all(6 * fem),
                      child: Text(TextConstant.addPatient,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.primaryPurple,
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                )
              ],
            )),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0 * fem, 5 * fem, 0, 0),
          child: Container(
            // color: Colors.blue,
            child: SingleChildScrollView(
              child: Column(children: [
                if (!controller.loading) ...[
                  DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Container(
                        // color: Colors.red,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.6,
                                height: 30,
                                // margin:EdgeInsets.fromLTRB(40, 0, 40, 0),

                                // width: size.width*0.44,
                                decoration: BoxDecoration(
                                    color: AppColors.ECEBFF,
                                    borderRadius: BorderRadius.circular(6)),
                                child: TabBar(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 3),

                                  // labelPadding: EdgeInsets.only(top: 5,bottom:5),
                                  labelColor: AppColors.primaryPurple,
                                  unselectedLabelColor: AppColors.primaryPurple,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColors.white,
                                  ),
                                  tabs: [
                                    Tab(
                                        child: Text(TextConstant.insight,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12 * fem))),
                                    Tab(
                                        child: Text(TextConstant.transaction,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12 * fem))),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.0),
                                child: Container(
                                    height: 1.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColors.black.withOpacity(0.05)),
                              ),
                              SizedBox(height: 5),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                // decoration: BoxDecoration(
                                //     border: Border(top: BorderSide(
                                //         color: Colors.grey, width: 0.5))
                                // ),
                                child: TabBarView(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          InsightWidget(),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        TransactionsWidget(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      )),
                ]
              ]),
            ),
          ),
        ),
      )),
    );
  }
}
