import 'package:CarePay/components/loader.dart';
import 'package:CarePay/screens/doctorScreens/professional.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CarePay/respository/doctorResp/personalDetailRepository.dart';
import 'package:CarePay/respository/doctorResp/professionalDetailRepository.dart';
import 'package:CarePay/screens/doctorScreens/address.dart';
import 'package:CarePay/utils/utils.dart';

class ProfessionalDetailController with ChangeNotifier {
  final _myRepo = ProfessionalDetailRepository();

  TextEditingController licenceNumber = TextEditingController();
  // TextEditingController speciality = TextEditingController();
  TextEditingController clinicName = TextEditingController();
  TextEditingController businessEntityName = TextEditingController();
  // TextEditingController businessEntityType = TextEditingController();
  TextEditingController cinLlpin = TextEditingController();
  TextEditingController gstIn = TextEditingController();

  String? _entityDropdownValue;
  String? get entityDropdownValue => _entityDropdownValue;

  String? _specialityDropdownValue;
  String? get specialityDropdownValue => _specialityDropdownValue;

  //  bool? _isButtonEnabled;
  // get isButtonEnabled => _isButtonEnabled;

  var _response = null;
  get response => _response;

  bool isEmpty() {
    // setState(() {
    if ((entityDropdownValue != null) && (specialityDropdownValue != null)) {
      return true;
    } else {
      return false;
    }
  }

  setentityTypeValue(value) {
    _entityDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  setspecialityTypeValue(value) {
    _specialityDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  var entityTypeDropDown = [
    "Private Limited Company",
    "Limited Liability Company (LLP)",
    "Partnership Firm",
    "Sole Proprietorship"
  ];

  var specialityTypeDropDown = [
    "Dentistry",
    "Dental Surgery",
    "Radiology",
    "Immunology",
    "Neurology",
    "Gynecology and obstetrics",
    "Pediatrics",
    "Psychiatry",
    "Internal medicine",
    "General",
    "Cardiology",
    "Orthopedics",
    "Emergency medicine",
    "Endocrinology",
    "Gastroenterology",
    "Nephrology",
    "Pulmonology",
    "Dietetics",
    "Urology",
    "Cosmetology",
    "Vascular Surgery",
    "Anesthesiology",
    "Genetics",
    "Nuclear medicine",
    "Forensic medicine",
    "Dermatology",
    "Oncology",
    "Pathology",
    "Physiotherapy",
    "ENT",
    "Plastic surgery",
    "Rheumatology",
    "Bariatric Surgery",
    "Psychology",
    "Diabetology",
    "Neurosurgery",
    "Other"
  ];

  void initFetchData(context) async {
    Loader().fetchData(context);
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic doctorId = pref.getString('doctorId');
    print(doctorId.toString());
    var res = await _myRepo.getProfessionalDetailApi(doctorId.toString());
    _response = res['data'];
    print(res['data']);
    notifyListeners();

    //   setState(() {
    setController(res['data']);
    notifyListeners();
    Loader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != null) {
      print(response['phoneNumber']);
      this.licenceNumber.text =
          response['licenceNumber'] != null ? response['licenceNumber'] : "";
      if (response['speciality'] != null &&
          response['speciality'].toString() != "null") {
        this._specialityDropdownValue =
            response['speciality'] != null ? response['speciality'] : "";
      }
      this.clinicName.text =
          response['clinicName'] != null ? response['clinicName'] : "";
      this.businessEntityName.text = response['businessEntityName'] != null
          ? response['businessEntityName']
          : "";
      if (response['businessEntityType'] != null &&
          response['businessEntityType'].toString() != "null") {
        this._entityDropdownValue = response['businessEntityType'] != null
            ? response['businessEntityType']
            : "";
      }
      this.cinLlpin.text =
          response['cinLlpin'] != null ? response['cinLlpin'] : "";
      this.gstIn.text = response['gstIn'] != null ? response['gstIn'] : "";
    }
    notifyListeners();
  }

  handleSubmition(BuildContext context) async {
    Loader().fetchData(context);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic doctorId = pref.getString('doctorId');
    try {
      var payload;
      if (response != null) {
        payload = {
          ...response,
          "licenceNumber": licenceNumber.text.toString(),
          "speciality": specialityDropdownValue.toString(),
          "clinicName": clinicName.text.toString(),
          "businessEntityName": businessEntityName.text.toString(),
          "businessEntityType": entityDropdownValue.toString(),
          "cinLlpin": cinLlpin.text.toString(),
          "gstIn": gstIn.text.toString(),
        };
      } else {
        payload = {
          "doctorId": doctorId.toString(),
          "licenceNumber": licenceNumber.text.toString(),
          "speciality": specialityDropdownValue.toString(),
          "clinicName": clinicName.text.toString(),
          "businessEntityName": businessEntityName.text.toString(),
          "businessEntityType": entityDropdownValue.toString(),
          "cinLlpin": cinLlpin.text.toString(),
          "gstIn": gstIn.text.toString(),
        };
      }
      // //
      var res = await _myRepo.professionalDetailApi(payload);
      print(payload);
      print(res);
      if (res['status'] == 200) {
        // print(payload);
        // var res = await ApiServices()
        //     .apicall("/sendOtp?phoneNumber=${nameController.text.toString()}");
        // var response = jsonDecode(res.body);
        // if (res.body.toString() == "success") {
        Loader().loaderClose(context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: address()),
        );
      } else {
        Utils.toastMessage(res['data'].toString());
        Loader().loaderClose(context);
      }
    } catch (e) {
      Utils.toastMessage("Check Internet Connection");
      Loader().loaderClose(context);
    }
    // Loader().loaderClose(context);
  }
}
