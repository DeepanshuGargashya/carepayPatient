import 'dart:convert';
import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/patientResp/cibilDataDecentro.dart';
import 'package:CarePay/respository/patientResp/creditDetailRepository.dart';
import 'package:CarePay/respository/patientResp/personalDetailRepository.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/addressDetail.dart';
// import 'package:CarePay/screens/patientScreens/addressDetail.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/fetchLoader.dart';
import '../../res/color.dart';

class PersonalDetailController with ChangeNotifier {
  final _myRepo = PersonalDetailRepository();
  final _myCibilRepo = CibilDataDecentro();
  final _myCreditDetailRepo = CreateDetailRepository();

  var _response;
  get response => _response;

// state variables

  var _userId;
  get userId => _userId;

  bool _genderError = false;
  get genderError => _genderError;
  bool _isMarriedError = false;
  get isMarriedError => _isMarriedError;

  var _genderValue = "";
  get genderValue => _genderValue;
  var _isMarriedValue = "";
  get isMarriedValue => _isMarriedValue;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;
  bool _relationError = false;
  bool get relationError => _relationError;
  String? _relationValue;
  String? get relationValue => _relationValue;

  final altMobController = TextEditingController();
  final refMobController = TextEditingController();
  final panController = TextEditingController();
  // final nameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  var genders = ["Male", "Female", "Other"];

  var relations = ["Spouse", "Father", "Mother", "Brother", "Sister"];
  var isMarriedOptions = ["Yes", "No"];

  void initFetchData(context) async {
    FetchLoader().fetchData(context, 'Fetching personal details');

    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId');
    notifyListeners();
    print(userId.toString());
    var res = await _myRepo.getBasicDetails(userId.toString());
    _response = res['data'];
    print(res['data']);

    //   setState(() {
    if (res['status'] == 200) {
      if (response != null && response != "" && response['panNo'] != null) {
        setController(res['data']);
      } else {
        var saveNBFCIdPayload = {
          "userId": userId.toString(),
          "doctorId": pref.getString('doctorId'),
          "nbfcId": "a93yXwa81hdnMHFrUWuYcaEdEijARkmn"
        };
        await _myCreditDetailRepo.handleSubmitionApi(saveNBFCIdPayload);
        var fullName = pref.getString('fullNamePan');
        var decentroResponse = await _myCibilRepo.getCibilDataDecentro(
            fullName.toString(), userId.toString());
        if (decentroResponse['status'] == 200) {
          if (decentroResponse['data']?['data']?['cCRResponse']
                      ?['cirreportDataLst']?[0]?['cirreportData']
                  ?['idandContactInfo'] !=
              null) {
            setControllersForDecentro(decentroResponse['data']?['data']
                    ?['cCRResponse']?['cirreportDataLst']?[0]?['cirreportData']
                ?['idandContactInfo']);
          }
        }
      }
    }
    notifyListeners();
    FetchLoader().loaderClose(context);
  }

  setControllersForDecentro(response) {
    print(response);
    if (response != null && response != "") {
      this.panController.text =
          response['identityInfo']?['panid']?[0]?['idNumber'] != null
              ? response['identityInfo']['panid'][0]['idNumber'].toString()
              : "";
      // this.nameController.text =
      //     response['personalInfo']?['name']?['fullName'] != null
      //         ? response['personalInfo']['name']['fullName'].toString()
      //         : "";
      _genderValue = response['personalInfo']?['gender'] != null
          ? response['personalInfo']['gender'].toString()
          : "";
      this.emailController.text =
          response['emailAddressInfo']?[0]?['emailAddress'] != null
              ? response['emailAddressInfo'][0]['emailAddress'].toString()
              : "";
      if (response['personalInfo']?['dateOfBirth'] != null) {
        var result =
            response['personalInfo']['dateOfBirth'].toString().split("-");
        this.dobController.text =
            '${result[2].toString()}-${result[1].toString()}-${result[0].toString()}';
      }
      // this.dobController.text = response['personalInfo']['dateOfBirth'] != null
      //     ? DateFormat('dd/MM/yyyy').format(
      //         DateTime(response['personalInfo']['dateOfBirth'].toString()))
      //     : "";
    } else {
      // this.mob.text = number.toString();
    }
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != null && response != "") {
      print(response['mobileNumber']);
      this.panController.text =
          response['panNo'] != null ? response['panNo'].toString() : "";
      // this.nameController.text =
      //     response['firstName'] != null ? response['firstName'].toString() : "";
      _genderValue =
          response['gender'] != null ? response['gender'].toString() : "";
      emailController.text =
          response['emailId'] != null ? response['emailId'].toString() : "";
      refMobController.text = response['referenceNumber'] != null
          ? response['referenceNumber'].toString()
          : "";
      ownerNameController.text = response['referenceName'] != null
          ? response['referenceName'].toString()
          : "";
      _relationValue = response['referenceRelation'] != null
          ? response['referenceRelation'].toString()
          : "";
      _isMarriedValue = response['maritalStatus'] != null
          ? response['maritalStatus'].toString()
          : "";

      notifyListeners();
      dobController.text = response['dateOfBirth'] != null
          ? response['dateOfBirth'].toString()
          : "";
    } else {
      // this.mob.text = number.toString();
    }
    // print(mob.text.toString());
  }

  setIsMarriedValue(value) {
    _isMarriedValue = value.toString();
    _isMarriedError = false;
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

  setGenderValue(value) {
    _genderValue = value.toString();
    _genderError = false;
    notifyListeners();
  }

  showDatePickerr(BuildContext context) async {
    var picked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryPurple, // <-- SEE HERE
                onPrimary: AppColors.white, // <-- SEE HERE
                onSurface: AppColors.black, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: AppColors.primaryPurple
                      .withOpacity(0.7), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null) {
      print(picked.toString());
      var result = picked.toString().substring(0, 10).split("-");

      this.dobController.text =
          '${result[2].toString()}-${result[1].toString()}-${result[0].toString()}';

      notifyListeners();
    }
    return true;
  }
  // showDatePickerr(BuildContext context) async {
  //   var picked = await showDatePicker(
  //       initialEntryMode: DatePickerEntryMode.calendarOnly,
  //       context: context,
  //       initialDate: new DateTime.now(),
  //       firstDate: new DateTime(1900),
  //       lastDate: new DateTime.now());
  //   if (picked != null) {
  //     print(picked.toString());
  //     var result = picked.toString().substring(0, 10).split("-");
  //
  //     this.dobController.text =
  //     '${result[2].toString()}-${result[1].toString()}-${result[0].toString()}';
  //
  //     notifyListeners();
  //   }
  //   return true;
  // }

  // Future selectDate(BuildContext context, String dateOf) async {
  //   var picked = await showDatePicker(
  //       initialEntryMode: DatePickerEntryMode.calendarOnly,
  //       context: context,
  //       initialDate: new DateTime.now(),
  //       firstDate: new DateTime(1900),
  //       lastDate: new DateTime.now());
  //   if (picked != null) {
  //     print(picked.toString());
  //     var result = picked.toString().substring(0, 10).split("-");
  //
  //     dobController.text =
  //         '${result[2].toString()}-${result[1].toString()}-${result[0].toString()}';
  //
  //     notifyListeners();
  //   }
  // }
  setGenderError(value) {
    _genderError = value;
    notifyListeners();
  }

  setIsMarriedError(value) {
    _isMarriedError = value;
    notifyListeners();
  }

  Future<void> handleSubmition(BuildContext context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var widgetMobile = pref.getString('number');

    if (genderValue.toString().length < 2) {
      _genderError = true;
      notifyListeners();
      if (isMarriedValue.toString().length < 2) {
        _isMarriedError = true;
        notifyListeners();
      }
      if (relationValue == null || relationValue.toString().isEmpty) {
        _relationError = true;
        notifyListeners();
      }
      return;
    } else if (isMarriedValue.toString().length < 2) {
      _isMarriedError = true;
      notifyListeners();
      if (relationValue == null || relationValue.toString().isEmpty) {
        _relationError = true;
        notifyListeners();
      }
      return;
    } else if (relationValue == null || relationValue.toString().isEmpty) {
      _relationError = true;
      notifyListeners();
      return;
    }
    FetchLoader().fetchData(context, 'Submitting...');
    try {
      var payload = {
        "userId": userId.toString(),
        "panCard": panController.text.toString(),
        "firstName": "",
        "gender": genderValue.toString(),
        "emailId": emailController.text.toString(),
        "dateOfBirth": dobController.text.toString(),
        "mobileNumber": widgetMobile.toString(),
        "panCardName": null,
        "maritalStatus": isMarriedValue ?? "",
        "alternateNumber": altMobController.text.toString(),
        "referenceName": ownerNameController.text.toString(),
        "referenceNumber": refMobController.text.toString(),
        "referenceRelation": relationValue.toString(),
        "formStatus": ""
      };
      if (response != null) {
        payload = {...response, ...payload};
      }
      var res = await _myRepo.handleSubmitionApi(payload);
      print(res);

      if (res['status'] == 200) {
        Loader().loaderClose(context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: AddressDetailScreen()),
        );
      } else {
        Loader().loaderClose(context);
        Utils.toastMessage("Try Again");
      }
    } catch (e) {
      Loader().loaderClose(context);
      Utils.toastMessage("Check Internet Connection");
    }
  }

  handleTemp(context) {
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: AddressDetailScreen()),
    );
  }
}
