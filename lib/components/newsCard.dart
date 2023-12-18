import 'package:cached_network_image/cached_network_image.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:CarePay/view_model/doctorFlow/newsController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../res/textConstant.dart';

class NewsCard extends StatefulWidget {
  var eachNews;
  NewsCard({required this.eachNews});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsCardState();
  }
}

class NewsCardState extends State<NewsCard>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  var splitTile = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<NewsDetailController>(context, listen: false);
      var res = fetchData.getSplitTitle(widget.eachNews['title'].toString());
      if (res.toString().length > 0) {
        print("res.toString().length");
        print(res.toString().length);
        print(res.toString());
        setState(() {
          splitTile = res.toString();
        });
      }
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

  var newsShow = false;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewsDetailController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    return Container(
      // decoration: BoxDecoration(
      //     border: Border(
      //         bottom: BorderSide(
      //             color: AppColors.black.withOpacity(0.2), width: 2))),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 0 * fem),
      margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8 * fem),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:
                      //  CachedNetworkImage(
                      //   imageUrl: widget.eachNews['newsImage'],
                      //   imageBuilder: (context, imageProvider) => Container(
                      //     height: double.infinity,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //         image: imageProvider,
                      //         fit: BoxFit.fill,
                      //       ),
                      //     ),
                      //     // color: Colors.purple,
                      //   ),
                      // ),
                      (widget.eachNews['newsImage'] != null &&
                              widget.eachNews['newsImage'].toString() != "" &&
                              widget.eachNews['newsImage']
                                  .toString()
                                  .contains('http'))
                          ? Image.network(
                              '${widget.eachNews['newsImage'].toString()}',
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/defaultImage.png',
                              fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            width: 1,
            height: 10 * fem,
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //       type: PageTransitionType
                    //           .rightToLeftWithFade,
                    //       child: DoctorProfileScreen()),
                    // );
                  },
                  child: Container(
                    width: 40 * fem,
                    height: 40 * fem,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.black, width: 2 * fem),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: AppColors.black,

                        radius: 100,
                        child: Text(
                          splitTile.toString(),
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ), //Text
                      ),
                    ),
                  )),
              SizedBox(
                width: 10 * fem,
                height: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.eachNews['title'].toString()}',
                    style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 18 * fem,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black.withOpacity(0.8)),
                  ),
                  SizedBox(
                    width: 1,
                    height: 5 * fem,
                  ),
                  Container(
                    // color: AppColors.red,
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Wrap(
                      children: [
                        Text(
                          '${DateFormat('MMMM dd, yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.eachNews['addedOn']))}',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 10 * fem,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.4)),
                        ),
                        Text(
                          '${TextConstant.updatedOn} ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.eachNews['updatedOn']))} IST',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 10 * fem,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.4)),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            width: 1,
            height: 10 * fem,
          ),

          Container(
            width: double.infinity,
            child: widget.eachNews['body'].toString().length < 33
                ? Text(
                    '${widget.eachNews['body'].toString()}',
                    style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: AppColors.black.withOpacity(0.8),
                        fontSize: 14 * fem,
                        height: 1.2 * fem,
                        fontWeight: FontWeight.w500),
                  )
                : !newsShow
                    ? Text(
                        '${widget.eachNews['body'].toString().substring(0, 30)}',
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: AppColors.black.withOpacity(0.8),
                            fontSize: 14 * fem,
                            height: 1.2 * fem,
                            fontWeight: FontWeight.w500),
                      )
                    : Text(
                        '${widget.eachNews['body'].toString()}',
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: AppColors.black.withOpacity(0.8),
                            fontSize: 14 * fem,
                            height: 1.2 * fem,
                            fontWeight: FontWeight.w500),
                      ),
          ),
          // SizedBox(
          //   width: 1,
          //   height: 10 * fem,
          // ),
          // Container(
          //   width: double.infinity,
          //   child: Text(
          //     'The video clipping was viral in all the social media groups. I desisted from seeing it but the flak it drew from multiple quarters, lured me into watching it again and again. A renowned cardiologist and a modern medical visionary was being interviewed by a western news channel about his views on the COVID 19, and towards the end.',
          //     style: TextStyle(fontFamily: 'DM Sans',
          //         color: AppColors.black.withOpacity(0.8),
          //         fontSize: 14 * fem,
          //         height: 1.2 * fem,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          SizedBox(
            width: 1,
            height: 5 * fem,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      child: IconButton(
                        onPressed: null,
                        icon: Image.asset('assets/images/openNewsIcon.png'),
                        iconSize: 7 * fem,
                      ),
                    ),
                    TextButton(
                      // onPressed: enableResend ? _resendCode : null,
                      onPressed: () {
                        setState(() {
                          newsShow = !newsShow;
                        });
                      },
                      child: Text(
                        widget.eachNews['body'].toString().length < 33
                            ? ""
                            : newsShow
                                ? 'Close news'
                                : 'Open news',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            // 'Work Sans',
                            decoration: TextDecoration.underline,
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.1725 * ffem / fem,
                            color: AppColors.primaryPurple),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   child: Row(
              //     children: [
              //       IconButton(
              //           onPressed: () {
              //             Utils.dialogueMessage(
              //                 context,
              //                 'Thank You',
              //                 'For your valuable feedback, We will remember this, as it will help us improve',
              //                 'Okay');
              //           },
              //           icon: Icon(
              //             Icons.thumb_up,
              //             color: AppColors.primaryPurple.withOpacity(0.4),
              //           )),
              //       SizedBox(
              //         width: 6 * fem,
              //         height: 1,
              //       ),
              //       IconButton(
              //           onPressed: () {
              //             Utils.dialogueMessage(
              //                 context,
              //                 'Thank You',
              //                 'For your valuable feedback, We will remember this, as it will help us improve',
              //                 'Okay');
              //           },
              //           icon: Icon(
              //             Icons.thumb_down,
              //             color: AppColors.secondaryOrange,
              //           )),
              //     ],
              //   ),
              // )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 0 * fem),
                width: MediaQuery.of(context).size.width / 1.8,
                height: 1.5 * fem,
                color: AppColors.black.withOpacity(0.3),
              ),
            ],
          )
        ],
      ),
    );
  }
}
