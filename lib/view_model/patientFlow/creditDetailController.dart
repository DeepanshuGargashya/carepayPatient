import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/patientResp/creditDetailRepository.dart';
import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/personalDetail.dart';

// import 'package:CarePay/screens/patientScreens/kycVerification.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditDetailController with ChangeNotifier {
  final _myRepo = CreateDetailRepository();

  String? _purposeOfCreditDropdownValue;
  String? get purposeOfCreditDropdownValue => _purposeOfCreditDropdownValue;
  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  // var purposeOfCreditDropDown = [
  //   "Owned by self",
  //   "Owned by Parents",
  //   "Rented by self",
  //   "Rented by parents",
  //   "Rented with friends"
  // ];

  final doctorNameController = TextEditingController();
  final clinicNameController = TextEditingController();
  final purposeOfCreditController = TextEditingController();

  //
  // bool isEmpty() {
  //   if ((purposeOfCreditDropdownValue != null)) {
  //     _isButtonEnabled = true;
  //   } else {
  //     _isButtonEnabled = false;
  //   }
  //   notifyListeners();
  //   return _isButtonEnabled;
  // }

  // setPurposeOfCreditValue(value) {
  //   _purposeOfCreditDropdownValue = value.toString();
  //   isEmpty();
  //   notifyListeners();
  // }

  var _response = null;
  get response => _response;

  var _userId;
  get userId => _userId;
  var _doctorName;
  get doctorName => _doctorName;
  var _doctorClinicName;
  get doctorClinicName => _doctorClinicName;

  var _totalEmi = "";
  get totalEmi => _totalEmi;

  bool _totalEmiError = false;
  bool get totalEmiError => _totalEmiError;

  var _creditAmountValue = 0;
  get creditAmountValue => _creditAmountValue;

  setCreditAmountValue(value) {
    print(value.toString());
    if (value == "" || value == null) {
      value = 0;
    }
    _creditAmountValue = int.parse(value.toString());
    notifyListeners();
  }

  setTotalEmi(value) {
    _totalEmi = value.toString();
    _totalEmiError = false;
    notifyListeners();
  }

  setController(response) {
    print("setting controller");
    print(response);
    if (response != "") {
      this.purposeOfCreditController.text = response['loanReason'] != null
          ? response['loanReason'].toString()
          : "";
      this.creditAmountController.text = response['loanAmount'] != null
          ? response['loanAmount'].toString()
          : "";
      _creditAmountValue = response['loanAmount'] != null
          ? int.parse(response['loanAmount'].toString())
          : 0;
      if (response['loanEmi'] != null &&
          (int.parse(response['loanEmi'].toString()) == 3 ||
              int.parse(response['loanEmi'].toString()) == 6)) {
        _totalEmi = response['loanEmi'].toString();
      }
      notifyListeners();
    } else {}
  }

  void initFetchData(context) async {
    Loader().fetchData(context);
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId').toString();
    if (_userId == null || userId == '') {
      Loader().fetchData(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      Loader().loaderClose(context);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: HomeScreen()),
          (Route<dynamic> route) => false);
    }
    this.doctorNameController.text =
        'Dr. ${pref.getString('doctorName').toString()}';
    this.clinicNameController.text =
        pref.getString('doctorClinicName').toString();
    notifyListeners();
    print(userId.toString());

    var res = await _myRepo.getCreditDetails(userId.toString());
    _response = res['data'];
    print(res['data']);
    if (res['status'] == 200) {
      Loader().loaderClose(context);
      setController(res['data']);
      notifyListeners();
    } else {
      notifyListeners();
      Loader().loaderClose(context);
    }
  }

  handleSubmition(BuildContext context) async {
    if (totalEmi == "3" || totalEmi == "6") {
      Loader().fetchData(context);
      try {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        var doctorId = pref.getString('doctorId').toString();
        print('going to craete payload');
        var payload;

        if (response != "") {
          payload = {
            ...response,
            "userId": userId.toString(),
            "doctorId": doctorId.toString(),
            "loanAmount": creditAmountController.text.toString(),
            "loanReason": purposeOfCreditController.text.toString(),
            "loanEMI": totalEmi.toString(),
            "doctorName": doctorNameController.text.toString(),
            "formStatus": ""
          };
        } else {
          payload = {
            "userId": userId.toString(),
            "doctorId": doctorId.toString(),
            "loanAmount": creditAmountController.text.toString(),
            "loanReason": purposeOfCreditController.text.toString(),
            "loanEMI": totalEmi.toString(),
            "doctorName": doctorNameController.text.toString(),
            "formStatus": ""
          };
        }

        var res = await _myRepo.handleSubmitionApi(payload);
        print(res);
        if (res['status'] == 200) {
          print('response status is 200');
          Loader().loaderClose(context);
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeftWithFade,
          //         child: KYCVerificationScreen()));
        } else {
          print('response status is ${res['status'].toString()}');
          Utils.toastMessage(res['data'].toString());
          Loader().loaderClose(context);
        }
      } catch (e) {
        print('response is break due to ');
        print(e);
        Utils.toastMessage("Check Internet Connection");
        Loader().loaderClose(context);
      }
    } else {
      _totalEmiError = true;
      notifyListeners();
    }
  }

  //  new flow
  var borrowFor = ["Myself", "Someone else"];
  var relations = ["Spouse", "Father", "Mother", "Brother", "Sister"];

  String? _relationValue;
  String? get relationValue => _relationValue;
  bool _relationError = false;
  bool get relationError => _relationError;

  var _borrowForValue = "";
  get borrowForValue => _borrowForValue;

  final creditAmountController = TextEditingController();
  final treatmentNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final patientNameController = TextEditingController();

  setBorrowFor(value) {
    _borrowForValue = value;
    notifyListeners();
  }

  setRelationError(value) {
    _relationError = value;
    notifyListeners();
  }

  setRelations(value) {
    if (value.toString() != "Select Relation") {
      _relationValue = value.toString();
      _relationError = false;
      notifyListeners();
    }
  }

  handleSubmitCreditDetails(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userId').toString();

    var doctorId = pref.getString('doctorId');
    var doctorName = pref.getString('doctorName');

    var payload = {
      "userId": userId.toString(),
      "doctorName": doctorName.toString(),
      "doctorId": doctorId.toString(),
      "loanReason": treatmentNameController.text.toString(),
      "loanAmount": creditAmountController.text.toString(),
      "formStatus": ""
    };
    if (borrowForValue.toString() == "Someone else") {
      print("inside if cond");
      payload = {
        ...payload,
        "patientName": patientNameController.text.toString(),
        "relationshipWithPatient": relationValue.toString()
      };
      notifyListeners();
    }
    print(payload);
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: PersonalDetailScreen()),
    );
  }
}
