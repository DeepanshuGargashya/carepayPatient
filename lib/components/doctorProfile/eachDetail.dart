import 'package:CarePay/components/doctorProfile/modalBottomSheet.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/doctorProfileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:CarePay/res/textConstant.dart';

class EachDetailWidget extends StatefulWidget {
  final header;
  final formKey;
  final controller;
  final editController;

  const EachDetailWidget(
      {super.key,
      required this.header,
      required this.formKey,
      required this.controller,
      required this.editController});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EachDetailState();
  }
}

class EachDetailState extends State<EachDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DoctorProfileController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            // constraints: BoxConstraints(
            //   maxWidth: MediaQuery.of(context).size.width / 3.2,
            // ),
            padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 0 * fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.header.toString(),
                    style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: AppColors.black.withOpacity(0.4),
                        fontSize: 12 * fem,
                        fontWeight: FontWeight.w400)),
                ModalBottomSheetWidget(
                  formKey: widget.formKey,
                  controller: widget.editController,
                  editHeader: widget.header.toString(),
                  hintText:
                      "${TextConstant.enter} ${widget.header.toString()} ${TextConstant.here}",
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 10 * fem),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.ECEBFF, width: 2 * fem))),
            child: Container(
              width: double.infinity,
              // width: MediaQuery.of(context)
              //         .size
              //         .width /
              //     2.3,
              // constraints: BoxConstraints(
              //   maxWidth: MediaQuery.of(context).size.width / 2.6,
              // ),
              child: Text(widget.controller.text.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      color: AppColors.black.withOpacity(0.8),
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400)),
            ),
          )
        ]);
  }
}
