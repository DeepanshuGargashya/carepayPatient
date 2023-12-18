import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class FetchLoader {
  void fetchData(BuildContext context,desc) {
    Future.delayed(Duration.zero, () {
      Utils.fetchLoader(context,desc.toString());
    });
  }

  void loaderClose(BuildContext context) {
    Navigator.of(context).pop();
  }
}
