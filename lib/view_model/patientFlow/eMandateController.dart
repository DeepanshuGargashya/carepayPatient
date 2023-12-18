import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/patientResp/kycVerificationRepository.dart';
// import 'package:CarePay/screens/patientScreens/allUnderProcessScreens/bankUnderProcess.dart';
// import 'package:CarePay/screens/patientScreens/creditAgreement.dart';
// import 'package:CarePay/screens/patientScreens/kycScreens/documentKYC.dart';
// import 'package:CarePay/screens/patientScreens/kycVerification.dart';
// import 'package:CarePay/screens/patientScreens/verified.dart';
import 'package:CarePay/utils/utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EMandateController with ChangeNotifier {
  final _myRepo = KYCVerificationRepository();

  late BuildContext _context;
  get context => _context;

  bool _framLoader = true;
  bool get frameLoader => _framLoader;

  dynamic _webViewController = null;
  get webViewController => _webViewController;

  void emptyFrameLink() {
    _webViewController = null;
    notifyListeners();
  }

  void initFetchData(BuildContext context) async {
    _context = context;
    _framLoader = true;
    notifyListeners();
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString('userId').toString();
      var res =
          await _myRepo.getInitiateFlowApi(userId.toString(), "esign_verified");
      if (res['status'] == 200) {
        if (res['data'].toString() != "") {
          _framLoader = false;
          notifyListeners();
          _webViewController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse('${res['data'].toString()}'));
          notifyListeners();
        } else {
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
        Utils.toastMessage(res['data'].length > 0
            ? res['data'].toString()
            : "Please Try Again");
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void getLoanDetail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userId').toString();
    var res = await _myRepo.getCreditDetails(userId.toString());
  }
}
