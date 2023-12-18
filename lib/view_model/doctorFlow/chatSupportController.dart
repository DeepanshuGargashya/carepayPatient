import 'dart:async';
import 'dart:math';

import 'package:CarePay/components/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../respository/doctorResp/chatSupportRepository.dart';
import '../../utils/utils.dart';

class ChatSupportController with ChangeNotifier {
  Timer? mytimer;
  final _myRepo = ChatSupportRepository();

  TextEditingController sendController = TextEditingController();

  late BuildContext _context;
  get context => _context;

  var _response = null;
  get response => _response;

  var _doctorId = null;
  get doctorId => _doctorId;

  var _stopTimer = false;
  get stopTimer => _stopTimer;

  bool _loading = true;
  bool get loading => _loading;

  var _role = null;
  get role => _role;

  void initFetchData(context) async {
    Loader().fetchData(context);
    _loading = true;
    notifyListeners();
    setStopTimer(false);
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic identifier = pref.getString('doctorId');
    dynamic identifierType = pref.getString('role');
    _doctorId = identifier;
    _role = identifierType;
    var payload = {
      "identifierType": identifierType.toString(),
      "identifier": identifier.toString(),
    };
    notifyListeners();
    var res = await _myRepo.getChatSupportApi(payload);
    _response = res['data'];
    print(res['data']);
    // timer.cancel();
    notifyListeners();
    _loading = false;
    notifyListeners();
    Loader().loaderClose(context);
    // notifyListeners();
    timer(false);

    //
  }

  void timer(dispose) {
    mytimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      if (!stopTimer) {
        var payload = {
          "identifierType": role.toString(),
          "identifier": doctorId.toString(),
        };
        var res = await _myRepo.getChatSupportApi(payload);
        _response = res['data'];
        print(res['data']);
        // timer.cancel();
        notifyListeners();
      } else {
        timer.cancel();
        print("disposed going cancel the timer");
      }
    });
  }

  setStopTimer(value) {
    _stopTimer = value;
    notifyListeners();
  }

  handleSubmition(BuildContext context) async {
    if (sendController.text.toString().length > 0) {
      var msgPayload = {
        "body": sendController.text.toString(),
        "operationId": null,
      };
      _response = [msgPayload, ...response];
      notifyListeners();
      // Loader().fetchData(context);
      try {
        var payload = {
          "body": sendController.text.toString(),
          "identifierType": role.toString(),
          "identifier": doctorId.toString(),
        };
        print("payload");
        print(payload);
        var res = await _myRepo.chatSupportApi(payload);
        print(res);
        if (res['status'] == 200 || res['message'] == 'success') {
          sendController.clear();
          // Loader().loaderClose(context);
          // Navigator.push(
          //   context,
          //   PageTransition(
          //       type: PageTransitionType.rightToLeftWithFade,
          //       child: bank_details()),
          // );
        } else {
          Utils.toastMessage(res['data'].toString());
          // Loader().loaderClose(context);
        }
      } catch (e) {
        Utils.toastMessage("Check Internet Connection");
        // Loader().loaderClose(context);
      }
    }
  }
}
