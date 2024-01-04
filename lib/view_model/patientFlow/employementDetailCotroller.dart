import 'package:CarePay/components/loader.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/respository/patientResp/employementDetailrepository.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/bankDetail.dart';
// import 'package:CarePay/screens/patientScreens/bankDetail.dart';
// import 'package:CarePay/screens/patientScreens/newBankDetails.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/fetchLoader.dart';

class EmploymentDetailController with ChangeNotifier {
  final _myRepo = EmployementDetailRepository();

  final formKeyMonthlyIncome = GlobalKey<FormState>();
  final formKeyMonthlyFamilyIncome = GlobalKey<FormState>();
  final formKeyBuisnessName = GlobalKey<FormState>();
  final formKeyCurrentCompanyName = GlobalKey<FormState>();
  // final fieldTJYears = TextEditingController();
  // final fieldTJMonths = TextEditingController();
  // final fieldWEYears = TextEditingController();
  // final fieldWEMonths = TextEditingController();
  final scrollController = ScrollController();
  final monthlyIncomeController = TextEditingController();
  final monthlyFamilyIncomeController = TextEditingController();
  final buisnessNameController = TextEditingController();
  final currentCompanyNameController = TextEditingController();
  // final currentCompanyAdd1Controller = TextEditingController();
  // final currentCompanyAdd2Controller = TextEditingController();
  // final currentCompanyPincodeController = TextEditingController();
  // final salaryDateController = TextEditingController();
  // final industryOther = TextEditingController();

  var _response;
  get response => _response;

// state variables

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _cibilVisibility = false;
  bool get cibilVisibility => _cibilVisibility;

  bool _isCheckedError = false;
  bool get isCheckedError => _isCheckedError;

  bool _experienceError = false;
  bool get experienceError => _experienceError;

  var _userId;
  get userId => _userId;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  bool _decleration = false;
  bool get decleration => _decleration;

  // dropdown variables
  String? _employmentTypeDropdownValue = "Salaried";
  String? get employmentTypeDropdownValue => _employmentTypeDropdownValue;
  String? _currentEmployerDropdownValue;
  String? get currentEmployerDropdownValue => _currentEmployerDropdownValue;
  String? _buisnessTypeDropdownValue;
  String? get buisnessTypeDropdownValue => _buisnessTypeDropdownValue;

  String? _industryDropdownValue;
  String? get industryDropdownValue => _industryDropdownValue;
  bool _buisnessTypeDropdownError = false;
  bool get buisnessTypeDropdownError => _buisnessTypeDropdownError;

  var industryDropDown = [
    "Ecommerce",
    "FMCG",
    "Healthcare & Diagnostics",
    "IT & ITeS",
    "Oil and Gas",
    "Railways",
    "Telecommunications",
    "Cement",
    "Consumer Durables",
    "Education and Training",
    "Engineering & Infrastructure",
    "Capital Goods",
    "Auto Components",
    "Automobiles",
    "Gems and Jewellery",
    "Aviation",
    "Manufacturing",
    "Media and Entertainment",
    "Metals And Mining",
    "Power",
    "Real Estate",
    "Retail",
    "Textiles",
    "Insurance (Life and health)",
    "Pharmaceuticals",
    "Dairy Products",
    "Fertilisers & Seeds",
    "Food & Food Products",
    "Sugar, Tea, Coffee",
    "Hotel, Restaurants & Tourism",
    "Microfinance Institutions",
    "Shipping",
    "Ports & Port Services",
    "Banking and Finance",
    "Agriculture and Allied",
    "Other"
  ];
  var employmentTypeDropDown = ["Salaried", "Self-employed"];
  var currentEmployerDropDown = [];
  var buisnessTypeDropDown = [
    "Public Limited Company",
    "Private Limited Company",
    "Limited Liability Partners",
    "Limited Liability Company",
    "Partnership Firm",
    "Sole Proprietorship",
    "One-person company"
  ];

  bool checkValid() {
    if (employmentTypeDropdownValue.toString() == "Salaried") {
      if (formKeyCurrentCompanyName.currentState!.validate()) {
        return true;
      }
      return false;
    } else {
      if (formKeyBuisnessName.currentState!.validate() &&
          _buisnessTypeDropdownValue != null &&
          _buisnessTypeDropdownValue!.isNotEmpty) {
        return true;
      } else {
        formKeyBuisnessName.currentState!.validate();
        if (_buisnessTypeDropdownValue != null &&
            _buisnessTypeDropdownValue!.isNotEmpty) {
          _buisnessTypeDropdownError = true;
          notifyListeners();
        }
        return false;
      }
    }
  }

  bool isEmpty() {
    // setState(() {
    if ((employmentTypeDropdownValue != null)) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
    notifyListeners();
    // });
    return _isButtonEnabled;
  }

  setIsChecked(value) {
    _isChecked = value;
    _isCheckedError = false;
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

      // this.salaryDateController.text = result[2].toString();

      notifyListeners();
    }
    return true;
  }

  // init fetch

  void initFetchData(context) async {
    FetchLoader().fetchData(context, 'Fetching employement details');
    // Loader().fetchData(context);
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId');
    print(userId.toString());
    var res = await _myRepo.getEmploymentDetail(userId.toString());
    _response = res['data'];
    print(res['data']);

    //   setState(() {
    if (res['status'] == 200) {
      setController(res['data']);
    }
    notifyListeners();
    FetchLoader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != null) {
      if (response['employmentType'] != null) {
        _employmentTypeDropdownValue =
            response['employmentType'] == "SELF_EMPLOYED"
                ? "Self-employed"
                : "Salaried";
      }
      monthlyIncomeController.text = response['monthlyInHandSalary'] != null
          ? response['monthlyInHandSalary'].toString()
          : "";

      // this.salaryDateController.text =
      //     response['salaryDay'] != null ? response['salaryDay'].toString() : "";
      monthlyFamilyIncomeController.text =
          response['monthlyFamilyIncome'] != null
              ? response['monthlyFamilyIncome'].toString()
              : "";
      currentCompanyNameController.text = response['currentCompanyName'] != null
          ? response['currentCompanyName'].toString()
          : "";
      if (response['typeOfBusiness'] != null) {
        _buisnessTypeDropdownValue = response['typeOfBusiness'].toString();
      }
      buisnessNameController.text = response['nameOfBusiness'] != null
          ? response['nameOfBusiness'].toString()
          : "";
      notifyListeners();
    }
  }

  // set dropdown values

  setBuisnessTypeDropdown(value) {
    _buisnessTypeDropdownValue = value.toString();
    _buisnessTypeDropdownError = false;
    notifyListeners();
  }

  setEmployementTypeDropdownValue(value) {
    _employmentTypeDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  setIndustryDropdownValue(value) {
    _industryDropdownValue = value.toString();
    isEmpty();
    notifyListeners();
  }

  setDeclerationValue(value) {
    _decleration = value!;
    notifyListeners();
  }

//  handle submition

  handleSubmition(BuildContext context) async {
    print("inside handle submition");
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString('userId');
      // Loader().fetchData(context);

      try {
        // Loader().fetchData(context);
        FetchLoader().fetchData(context, 'Submitting...');
        print('going to create payload');
        var payload = {
          "userId": userId.toString(),
          // "employmentType": "SALARIED" || "SELF_EMPLOYED",
          "employmentType": employmentTypeDropdownValue.toString() == "Salaried"
              ? "SALARIED"
              : "SELF_EMPLOYED",
          "netTakeHomeSalary": monthlyIncomeController.text.toString(),
          "organizationName":
              employmentTypeDropdownValue.toString() == "Salaried"
                  ? currentCompanyNameController.text.toString()
                  : "",
          "nameOfBusiness": employmentTypeDropdownValue.toString() != "Salaried"
              ? buisnessNameController.text.toString()
              : "",
          "typeOfBusiness": employmentTypeDropdownValue.toString() != "Salaried"
              ? buisnessTypeDropdownValue.toString()
              : "",
          "monthlyFamilyIncome": monthlyFamilyIncomeController.text.toString(),
          "formStatus": ""
        };

        if (response != "" && response != null) {
          print('response not null');
          payload = {...response, ...payload};
        }

        print(payload);
        var res = await _myRepo.handleSubmitionApi(payload);

        print(res);
        // print(res['msg'].toString());
        print(res['status']);
        if (res['status'] == 200) {
          Loader().loaderClose(context);

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: BankDetailScreen()));
          // BankDetailScreen()),
          // );
        } else {
          Loader().loaderClose(context);
          Utils.toastMessage("Try Again");
        }
      } catch (e) {
        print(e);
        Loader().loaderClose(context);
        Utils.toastMessage("Check Internet Connection");
      }
    } catch (e) {
      print("e");
      print(e);
    }
  }

  handleTemp(context) {
    var payload = {
      "userId": userId.toString(),
      // "employmentType": "SALARIED" || "SELF_EMPLOYED",
      "employmentType": employmentTypeDropdownValue.toString() == "Salaried"
          ? "SALARIED"
          : "SELF_EMPLOYED",
      "netTakeHomeSalary": monthlyIncomeController.text.toString(),
      "organizationName": employmentTypeDropdownValue.toString() == "Salaried"
          ? currentCompanyNameController.text.toString()
          : "",
      "nameOfBusiness": employmentTypeDropdownValue.toString() != "Salaried"
          ? buisnessNameController.text.toString()
          : "",
      "typeOfBusiness": employmentTypeDropdownValue.toString() != "Salaried"
          ? buisnessTypeDropdownValue.toString()
          : "",
      "monthlyFamilyIncome": monthlyFamilyIncomeController.text.toString(),
      "formStatus": ""
    };
    print(payload);
    // Navigator.push(
    //   context,
    //   PageTransition(
    //       type: PageTransitionType.rightToLeftWithFade,
    //       child: BankDetailScreen()),
    //   // BankDetailScreen()),
    // );
  }
}
