import 'package:CarePay/components/loader.dart';
import 'package:CarePay/screens/doctorScreens/professional.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CarePay/respository/doctorResp/addressDetailRepository.dart';
import 'package:CarePay/respository/doctorResp/personalDetailRepository.dart';
import 'package:CarePay/screens/doctorScreens/bank_details.dart';
import 'package:CarePay/utils/utils.dart';

class AddressDoctorDetailsController with ChangeNotifier {
  final _myRepo = AddressDetailRepository();

  TextEditingController building = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateController = TextEditingController();

  String? _stateDropdownValue;
  String? get stateDropdownValue => _stateDropdownValue;

  var _response = null;
  get response => _response;

  bool _pinCodeErrorCode = false;
  bool get pinCodeErrorCode => _pinCodeErrorCode;

  var _doctorId = null;
  get doctorId => _doctorId;

  late BuildContext _context;
  get context => _context;

  bool isEmpty() {
    // setState(() {
    if ((stateDropdownValue != null)) {
      return true;
    } else {
      return false;
    }
  }

  setstateTypeValue(value) {
    _stateDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  var stateTypeDropDown = ["A", "g", "C", "D"];

  fetchPinCodeDetail() async {
    Loader().fetchData(context);
    print("here");
    try {
      print("going to hit pincode detail API");
      dynamic res = await _myRepo.getDetailsByPinCode(pinCode.text.toString());

      if (res['status'] == "success" && res['status'] != null) {
        print("inside not null");
        print(res);

        _pinCodeErrorCode = false;

        this.city.text = res['city'] != null ? res['city'].toString() : "";
        this.stateController.text =
            res['state'] != null ? res['state'].toString() : "";
        notifyListeners();
        Loader().loaderClose(context);
      } else {
        this.city.text = "";
        this.stateController.text = "";

        Loader().loaderClose(context);
        print("inside null");
        Utils.toastMessage('Invalid Pin Code');

        _pinCodeErrorCode = true;
        notifyListeners();
      }
      return true;
    } catch (e) {
      this.city.text = "";
      this.stateController.text = "";
      Loader().loaderClose(context);
      // setState(() {
      _pinCodeErrorCode = true;
      notifyListeners();
      // });
      Utils.toastMessage("Check Internet Connection");
      return true;
    }
  }

  void initFetchData(context) async {
    Loader().fetchData(context);
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    _doctorId = getDoctorId;
    // print(number.toString());
    var res = await _myRepo.getAddressDetailApi(getDoctorId.toString());
    _response = res['data'];
    print(res['data']);

    //   setState(() {
    setController(res['data']);
    notifyListeners();
    Loader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != null) {
      this.building.text =
          response['building'] != null ? response['building'].toString() : "";
      this.locality.text =
          response['locality'] != null ? response['locality'].toString() : "";
      this.pinCode.text =
          response['pinCode'] != null ? response['pinCode'].toString() : "";
      this.city.text =
          response['city'] != null ? response['city'].toString() : "";
      if (response['state'] != null && response['state'].toString() != "null") {
        this.stateController.text =
            response['state'] != null && response['state'].toString() != "null"
                ? response['state'].toString()
                : "";
      }
    }
    // print(mob.text.toString());
  }

  handleSubmition(BuildContext context) async {
    Loader().fetchData(context);
    try {
      var payload;
      if (response != null) {
        payload = {
          ...response,
          "building": building.text.toString(),
          "locality": locality.text.toString(),
          "pinCode": pinCode.text.toString(),
          "city": city.text.toString(),
          "state": stateController.text.toString()
        };
      } else {
        payload = {
          "doctorId": doctorId.toString(),
          "building": building.text.toString(),
          "locality": locality.text.toString(),
          "pinCode": pinCode.text.toString(),
          "city": city.text.toString(),
          "state": stateController.text.toString()
        };
      }

      var res = await _myRepo.addressDetailApi(payload);
      print(res);
      if (res['status'] == 200) {
        Loader().loaderClose(context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: bank_details()),
        );
      } else {
        Utils.toastMessage(res['data'].toString());
        Loader().loaderClose(context);
      }
    } catch (e) {
      Utils.toastMessage("Check Internet Connection");
      Loader().loaderClose(context);
    }
  }
}
