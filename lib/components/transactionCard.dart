import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransactionCardState();
  }
}

class TransactionCardState extends State<TransactionCard>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5))),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
            child: FadeSlideTransition(
              additionalOffset: space,
              animation: _formElementAnimation,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '12/05/22 ',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        Text(
                          '04:55 PM',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        SizedBox(
                          width: 10 * fem,
                          height: 1,
                        ),
                        TextButton(
                          onPressed: null,
                          child: Row(
                            children: [
                              Text(
                                'Paid',
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.primaryGreen,
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5 * ffem)),
                            primary: AppColors.primaryGreen,
                            backgroundColor: AppColors.tertiaryGreen,
                            // onSurface: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: null,
                    child: Row(
                      children: [
                        Text(
                          'Share',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.white,
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 5 * fem,
                          height: 1,
                        ),
                        Icon(
                          Icons.share,
                          size: 20,
                          color: AppColors.white,
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5 * ffem)),
                      primary: AppColors.white,
                      backgroundColor: AppColors.primaryPurple,
                      // onSurface: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 0 * fem),
              child: FadeSlideTransition(
                  additionalOffset: space,
                  animation: _formElementAnimation,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TRSC675423AA',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12 * fem),
                            ),
                            SizedBox(
                              width: 1,
                              height: 10 * fem,
                            ),
                            Text(
                              'Transaction ID',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12 * fem),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹ 30,000',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12 * fem),
                            ),
                            SizedBox(
                              width: 1,
                              height: 10 * fem,
                            ),
                            Text(
                              'Amount',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12 * fem),
                            ),
                          ],
                        ),
                      ])))
        ],
      ),
    );
  }
}
