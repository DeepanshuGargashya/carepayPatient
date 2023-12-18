import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/doctorResp/addPateintRepository.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPatientController with ChangeNotifier {
  final _myRepo = AddPatientRepository();

  final patientNameController = TextEditingController();
  final patientNumberController = TextEditingController();
  final loanPurposeController = TextEditingController();
  final loanRequestAmountController = TextEditingController();
  final emailIdController = TextEditingController();
  final clinicNameController = TextEditingController();

  // dropdown

  String? _loanEmiDropdownValue = "Select Emi";
  String? get loanEmiDropdownValue => _loanEmiDropdownValue;
  bool _loanEmiDropdownError = false;
  bool get loanEmiDropdownError => _loanEmiDropdownError;

  var loanEmiDropdown = ["Select Emi", "3", "6"];

  var _doctorId = null;
  get doctorId => _doctorId;
  var _doctorCode = null;
  get doctorCode => _doctorCode;

  handleClear() {
    patientNameController.clear();
    patientNumberController.clear();
    emailIdController.clear();
    loanPurposeController.clear();
    loanRequestAmountController.clear();
    _loanEmiDropdownValue = "Select Emi";
    notifyListeners();
  }

  setLoanEmi(value) {
    if (value.toString() != "Select Emi") {
      _loanEmiDropdownValue = value.toString();
      _loanEmiDropdownError = false;
      notifyListeners();
    }
  }

  void initFetchData(context) async {
    Loader().fetchData(context);
    print('initS');
    handleClear();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    var clinicName = pref.getString('clinicName');
    if (clinicName != null) {
      this.clinicNameController.text = clinicName.toString();
    }
    _doctorId = getDoctorId;
    // print(number.toString());
    var res = await _myRepo.getDoctorDetailApi(getDoctorId.toString());
    if (res['status'] == 200) {
      _doctorCode = res['data']['doctor_code'];
      notifyListeners();
    }
    Loader().loaderClose(context);
  }

  setLoanEmiError(value) {
    _loanEmiDropdownError = value;
    notifyListeners();
  }

  handleSubmition(BuildContext context) async {
    if (loanEmiDropdownValue.toString() != loanEmiDropdown[0].toString()) {
      Loader().fetchData(context);
      try {
        var payload = {
          "loanEmi": loanEmiDropdownValue.toString(),
          "firstName": patientNameController.text.toString(),
          "phoneNumber": patientNumberController.text.toString(),
          "emailId": emailIdController.text.toString(),
          "loanAmount": loanRequestAmountController.text.toString(),
          "purposeOfLoan": loanPurposeController.text.toString(),
          "doctorId": doctorId.toString(),
        };

        var res = await _myRepo.addPatientApi(payload);
        print(res);
        if (res['status'] == 200) {
          var emailPayload = {
            "emailId": emailIdController.text.toString(),
            "patientName": patientNameController.text.toString(),
            "doctorId": _doctorId.toString()
          };
          var emailResponse = await _myRepo.sendEmail(emailPayload);
          if (emailResponse['status'] == 200) {
            Utils.successToastMessage("patient Added SuccessFully");
            handleClear();
          } else {
            Utils.toastMessage(emailResponse['data'].toString());
          }
        } else {
          Utils.toastMessage(res['data'].toString());
        }
      } catch (e) {
        Utils.toastMessage("Check Internet Connection");
      }
      Loader().loaderClose(context);
    } else {
      _loanEmiDropdownError = true;
      notifyListeners();
    }
  }
}
