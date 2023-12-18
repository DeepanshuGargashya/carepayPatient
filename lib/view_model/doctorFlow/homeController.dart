import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/doctorResp/homeRepository.dart';
import 'package:CarePay/screens/doctorScreens/bottom_bar.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController with ChangeNotifier {
  final _myRepo = HomeRepository();

  late BuildContext _context;
  get context => _context;

  var _doctorId = null;
  get doctorId => _doctorId;

  var _name = "";
  get name => _name;

  void initFetchData(context) async {
    // Loader().fetchData(context);
    print('initS');
    _context = context;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    _doctorId = getDoctorId;
    // Loader().loaderClose(context);
    await getDoctorDetails();
    await getDoctorVerificationStatus();
    notifyListeners();
  }

  getDoctorDetails() async {
    _name = "";
    notifyListeners();
    var res = await _myRepo.getDoctorDetailApi(doctorId.toString());
    print(res);
    var tempName = res['data']['name'].toString().split(" ");
    // var tempNameCond = tempName.length>2?2

    // print(tempName);
    print(tempName.length);
    print(tempName[0][0]);
    for (int i = 0; i < (tempName.length > 2 ? 2 : tempName.length); i++) {
      _name = name + tempName[i][0];
      notifyListeners();
    }
  }

  getDoctorVerificationStatus() async {
    try {
      Loader().fetchData(context);
      var res = await _myRepo.getDoctorVerificationStatus(doctorId.toString());
      // print(res);
      // print(res['status']);
      // print(res['data'].toString());
      // print(name.split(" "));
      // print(name.split(" ")[0][1]);

      notifyListeners();
      if (res['status'] == 200) {
        print("status 200");
        Loader().loaderClose(context);
        if (res['data'].toString() == "VERIFIED") {
          print("data verified");
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: bottomBar()),
          );
        } else {
          print("under verification");

          Utils.toastMessage("Under Verification Process");
        }
        // notifyListeners();
      }
    } catch (e) {
      Loader().loaderClose(context);
      print("error");
      print(e);
    }
  }
}
