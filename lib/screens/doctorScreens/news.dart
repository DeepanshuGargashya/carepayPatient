import 'package:CarePay/components/newsCard.dart';
import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/fade_slide_transition.dart';
import '../../view_model/doctorFlow/newsController.dart';

class newsScreen extends StatefulWidget {
  const newsScreen({Key? key}) : super(key: key);

  @override
  State<newsScreen> createState() => _newsState();
}

class _newsState extends State<newsScreen> with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<NewsDetailController>(context, listen: false);
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
    final controller = Provider.of<NewsDetailController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            // automaticallyImplyLeading: false,
            elevation: 0,
            leadingWidth: 12 * fem,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 115 * fem,
                  height: 45 * fem,
                  child: Image.asset('assets/images/carePayLogo.png'),
                ),
                // IconButton(
                //   onPressed: null,
                //   icon: Image.asset('assets/images/filter.png'),
                //   iconSize: 36 * fem,
                // )
              ],
            ),
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                child: (controller.response != null &&
                        controller.response.length > 0)
                    ? ListView.builder(
                        itemBuilder: (_, i) => ListTile(
                            title: NewsCard(eachNews: controller.response[i])),
                        itemCount: controller.response.length,
                      )
                    : Center(
                        child: FadeSlideTransition(
                          additionalOffset: 0.0,
                          animation: _formElementAnimation,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150 * fem,
                                child: Image.asset("assets/images/noData.png"),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(
                                    25 * fem, 0 * fem, 25 * fem, 3 * fem),
                                child: Text(
                                  "No News FOund",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
          )),
        ),
      ),
    );
  }
}
