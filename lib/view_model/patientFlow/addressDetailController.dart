import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/patientResp/addressDetailRepository.dart';
import 'package:CarePay/respository/patientResp/cibilDataDecentro.dart';
// import 'package:CarePay/screens/patientScreens/employmentDetails.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/fetchLoader.dart';

class AddressDetailController with ChangeNotifier {
  final _myRepo = AddressDetailRepository();
  final _myCibilRepo = CibilDataDecentro();

  final lineController = TextEditingController();
  final localityController = TextEditingController();
  final landmarkController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  // final stateController = TextEditingController();

  var _response = null;
  get response => _response;

  var _cibilResponse = null;
  get cibilResponse => _cibilResponse;

  var _userId;
  get userId => _userId;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  bool _cibilVisibility = false;
  bool get cibilVisibility => _cibilVisibility;

  String? _addressDropdownValue;
  String? get addressDropdownValue => _addressDropdownValue;

  String? _allAddressesDropdownValue;
  String? get allAddressesDropdownValue => _allAddressesDropdownValue;

  String? _stateDropdownValue;
  String? get stateDropdownValue => _stateDropdownValue;

  late BuildContext _context;
  get context => _context;

  bool _pinCodeErrorCode = false;
  bool get pinCodeErrorCode => _pinCodeErrorCode;

  var allAddressesDropDown = [];
  var addressDropDown = [
    "Owned by self",
    "Owned by Parents",
    "Rented by self",
    "Rented by parents",
    "Rented with friends",
    "current",
    "permanent",
    "temporary"
  ];
  var stateDropDown = [
    "Select state",
  ];

  void initFetchData(context) async {
    FetchLoader().fetchData(context, 'Fetching address details');
    _cibilVisibility = false;
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId').toString();
    print(userId.toString());
    var res = await _myRepo.getAddressDetail(userId.toString());
    _response = res['data'];
    notifyListeners();
    print(res['data']);
    if (res['status'] == 200) {
      if (res['data'] != null &&
          res['data'] != "" &&
          res['data']['city'] != null) {
        setController(res['data']);
      }
    } else {
      var fullName = pref.getString('fullNamePan');
      var decentroResponse = await _myCibilRepo.getCibilDataDecentro(
          fullName.toString(), userId.toString());
      if (decentroResponse['status'] == 200) {
        if (decentroResponse['data']?['data']?['cCRResponse']
                    ?['cirreportDataLst']?[0]?['cirreportData']
                ?['idandContactInfo'] !=
            null) {
          setControllersForDecentro(decentroResponse['data']['data']
                  ['cCRResponse']['cirreportDataLst'][0]['cirreportData']
              ['idandContactInfo']);
        }
      }
    }
    notifyListeners();
    FetchLoader().loaderClose(context);
  }

  setControllersForDecentro(response) async {
    _cibilResponse = response;

    var tempSet = [];
    print(response);
    if (response != null && response != "") {
      for (var item in response['addressInfo']) {
        tempSet = [...tempSet, item['address'].toString()];
      }

      allAddressesDropDown = tempSet;
      if (tempSet != null && tempSet.length != null && tempSet.length != 0) {
        _allAddressesDropdownValue = tempSet[0];
        this.lineController.text = tempSet[0];
        this.pincodeController.text =
            response['addressInfo']?[0]?['postal'] != null
                ? response['addressInfo'][0]['postal'].toString()
                : "";
        notifyListeners();
        if (response['addressInfo']?[0]?['postal'] != null) {
          await fetchPinCodeDetail();
        }
      }
      _cibilVisibility = true;
      notifyListeners();
    } else {
      // this.mob.text = number.toString();
    }
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != "") {
      // print(response['mobileNumber']);
      if (response['addressType'] != null &&
          response['addressType'].toString() != "null") {
        _addressDropdownValue = response['addressType'] != null
            ? response['addressType'].toString()
            : "";
      }
      this.lineController.text =
          response['address'] != null ? response['address'].toString() : "";

      this.localityController.text =
          response['locality'] != null ? response['locality'].toString() : "";
      this.landmarkController.text =
          response['landmark'] != null ? response['landmark'].toString() : "";
      this.pincodeController.text =
          response['pincode'] != null ? response['pincode'].toString() : "";
      this.cityController.text =
          response['city'] != null ? response['city'].toString() : "";
      if (response['state'] != null) {
        stateDropDown = ["Select state", response['state'].toString()];
        _stateDropdownValue = response['state'] != null
            ? response['state'].toString()
            : "Select state";
      }
    } else {}
  }

  setAllAddressesValue(value) async {
    _allAddressesDropdownValue = value.toString();
    notifyListeners();

    for (var item in cibilResponse['addressInfo']) {
      if (item['address'].toString() == value.toString()) {
        this.lineController.text = item['address'].toString();
        this.pincodeController.text =
            item['postal'] != null ? item['postal'].toString() : "";
        notifyListeners();
        if (item['postal'] != null) {
          await fetchPinCodeDetail();
        }
      }
    }
    isEmpty();
    notifyListeners();
  }

  setAddressTypeValue(value) {
    _addressDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  setStateDropdown(value) {
    _stateDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  bool isEmpty() {
    // setState(() {
    if (addressDropdownValue != null &&
        stateDropdownValue != null &&
        stateDropdownValue != "Select state") {
      return true;
      // _isButtonEnabled = true;
    } else {
      return false;
      // _isButtonEnabled = false;
    }
    // notifyListeners();
    // // });
    // return isButtonEnabled;
  }

  fetchPinCodeDetail() async {
    FetchLoader().fetchData(context, "Fetching pincode details");
    print("here");
    try {
      print("going to hit pincode detail API");
      dynamic res =
          await _myRepo.getDetailsByPinCode(pincodeController.text.toString());

      if (res['status'] == "success" && res['status'] != null) {
        print("inside not null");
        print(res);

        _pinCodeErrorCode = false;

        this.cityController.text =
            res['city'] != null ? res['city'].toString() : "";
        if (res['state'] != null) {
          stateDropDown = ["Select state", res['state'].toString()];
          notifyListeners();
          _stateDropdownValue =
              res['state'] != null ? res['state'].toString() : "Select state";
        }
        notifyListeners();
        Loader().loaderClose(context);
      } else {
        this.cityController.text = "";
        _stateDropdownValue = "Select state";

        Loader().loaderClose(context);
        print("inside null");
        Utils.toastMessage('Invalid Pincode');

        _pinCodeErrorCode = true;
        notifyListeners();
      }
      return true;
    } catch (e) {
      this.cityController.text = "";
      _stateDropdownValue = "Select state";
      Loader().loaderClose(context);
      // setState(() {
      _pinCodeErrorCode = true;
      notifyListeners();
      // });
      Utils.toastMessage("Check Internet Connection");
      return true;
    }
  }

  handleSubmition(BuildContext context) async {
    // Loader().fetchData(context);
    FetchLoader().fetchData(context, 'Submitting...');
    try {
      print('hii');
      print(response);
      var payload;
      if (response != "" && response != null) {
        payload = {
          ...response,
          "userId": userId.toString(),
          "addressType": addressDropdownValue.toString(),
          "address": lineController.text.toString(),
          "locality": localityController.text.toString(),
          "landmark": landmarkController.text.toString(),
          "city": cityController.text.toString(),
          "state": stateDropdownValue.toString(),
          "pincode": pincodeController.text.toString(),
          "formStatus": ""
        };
      } else {
        payload = {
          "userId": userId.toString(),
          "addressType": addressDropdownValue.toString(),
          "address": lineController.text.toString(),
          "locality": localityController.text.toString(),
          "landmark": landmarkController.text.toString(),
          "city": cityController.text.toString(),
          "state": stateDropdownValue.toString(),
          "pincode": pincodeController.text.toString(),
          "formStatus": ""
        };
      }
      var res = await _myRepo.handleSubmitionApi(payload);

      print(res);
      // print(res['msg'].toString());
      print(res['status']);
      if (res['status'] == 200) {
        Loader().loaderClose(context);
        // print('hii');

        // Navigator.push(
        //   context,
        //   PageTransition(
        //       type: PageTransitionType.rightToLeftWithFade,
        //       child: EmploymentDetailScreen()),
        // );
      } else {
        Loader().loaderClose(context);
        Utils.toastMessage(res['data'].toString());
      }
    } catch (e) {
      Loader().loaderClose(context);
      Utils.toastMessage("Check Internet Connection");
    }
  }
}
