import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/components/homeMain/eachTransactionCard.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/components/homeScreen/preBottom.dart';

class TransactionsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransactionsState();
  }
}

class TransactionsState extends State<TransactionsWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<HomeMainController>(context, listen: false);
      fetchData.initFetchData(context);
    });
    print(DateFormat('dd MMMM')
        .format(DateTime.fromMillisecondsSinceEpoch(1685085299314)));

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
      var fetchData = Provider.of<HomeMainController>(context, listen: false);
      fetchData.getThreeTransactions("");
    }); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeMainController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    // TODO: implement build
    return Container(
      // color: Colors.red,
      height: MediaQuery.of(context).size.height / 1.3,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(children: [
                Container(
                    child:
                        Image(image: AssetImage('assets/images/notebook.png'))),
                Text(TextConstant.transactions,
                    style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14 * fem))
              ]),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.25,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              // height: 300,

                              // width: size.width*0.44,
                              decoration: const BoxDecoration(
                                  color: AppColors.white10,
                                  borderRadius: BorderRadius.horizontal()),
                              child: TabBar(
                                physics: NeverScrollableScrollPhysics(),
                                isScrollable: false,
                                onTap: (index) {
                                  if (index == 0) {
                                    controller.getThreeTransactions("");
                                  } else if (index == 1) {
                                    controller
                                        .getThreeTransactions("disbursed");
                                  } else if (index == 2) {
                                    controller.getThreeTransactions("approved");
                                  }
                                },
                                labelColor: AppColors.primaryPurple,
                                unselectedLabelColor: AppColors.grey,
                                indicatorColor: AppColors.primaryPurple,
                                tabs: [
                                  Tab(
                                      child: Text(TextConstant.allLoans,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 12 * fem,
                                              fontWeight: FontWeight.w700))),
                                  Tab(
                                      child: Text(TextConstant.disbursed,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 12 * fem,
                                              fontWeight: FontWeight.w700))),
                                  Tab(
                                      child: Text(TextConstant.approved,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 12 * fem,
                                              fontWeight: FontWeight.w700))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: controller.transactionResponse != null
                              ? controller.transactionResponse.length < 1
                                  ? MediaQuery.of(context).size.height / 3
                                  : controller.transactionResponse.length < 2
                                      ? MediaQuery.of(context).size.height /
                                          3.25
                                      : controller.transactionResponse.length <
                                              3
                                          ? MediaQuery.of(context).size.height /
                                              1.9
                                          : MediaQuery.of(context).size.height /
                                              1.45
                              : MediaQuery.of(context).size.height / 4,
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              if (controller.transactionResponse.length > 0 &&
                                  controller.transactionResponse != null) ...[
                                EachTransactionWidget(),
                              ] else ...[
                                Center(
                                  child: FadeSlideTransition(
                                    additionalOffset: 0.0,
                                    animation: _formElementAnimation,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30 * fem),
                                        Container(
                                          // width: 153 * fem,
                                          // height: 153 * fem,
                                          child: Image.asset(
                                              "assets/images/transactions.png"),
                                        ),
                                        SizedBox(height: 18 * fem),
                                        Container(
                                          // width: 153 * fem,
                                          // height: 153 * fem,
                                          child: Image.asset(
                                              "assets/images/transactions.png"),
                                        ),
                                        SizedBox(height: 18 * fem),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              32 * fem, 0, 32 * fem, 0),
                                          child: Center(
                                            child: Text(
                                              TextConstant.sitBack,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12 * fem,
                                                  fontFamily: 'DM Sans',
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                              if (controller.transactionResponse.length > 0 &&
                                  controller.transactionResponse != null) ...[
                                EachTransactionWidget(),
                              ] else ...[
                                Center(
                                  child: FadeSlideTransition(
                                    additionalOffset: 0.0,
                                    animation: _formElementAnimation,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30 * fem),
                                        Container(
                                          // width: 153 * fem,
                                          // height: 153 * fem,
                                          child: Image.asset(
                                              "assets/images/transactions.png"),
                                        ),
                                        SizedBox(height: 18 * fem),
                                        Container(
                                          // width: 153 * fem,
                                          // height: 153 * fem,
                                          child: Image.asset(
                                              "assets/images/transactions.png"),
                                        ),
                                        SizedBox(height: 18 * fem),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              32 * fem, 0, 32 * fem, 0),
                                          child: Center(
                                            child: Text(
                                              TextConstant.sitBack,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12 * fem,
                                                  fontFamily: 'DM Sans',
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                              if (controller.transactionResponse.length > 0 &&
                                  controller.transactionResponse != null) ...[
                                EachTransactionWidget(),
                              ] else ...[
                                Center(
                                  child: FadeSlideTransition(
                                    additionalOffset: 0.0,
                                    animation: _formElementAnimation,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30 * fem),
                                        Container(
                                          // width: 153 * fem,
                                          // height: 153 * fem,
                                          child: Image.asset(
                                              "assets/images/transactions.png"),
                                        ),
                                        SizedBox(height: 18 * fem),
                                        Container(
                                          // width: 153 * fem,
                                          // height: 153 * fem,
                                          child: Image.asset(
                                              "assets/images/transactions.png"),
                                        ),
                                        SizedBox(height: 18 * fem),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              32 * fem, 0, 32 * fem, 0),
                                          child: Center(
                                            child: Text(
                                              TextConstant.sitBack,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12 * fem,
                                                  fontFamily: 'DM Sans',
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ])),
            ),
            SizedBox(height: 10),
            PreBottomWidget(showFaq: true)
          ]),
        ),
      ),
    );
  }
}
