import 'package:CarePay/components/loader.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/respository/patientResp/employementDetailrepository.dart';
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

  final fieldTJYears = TextEditingController();
  final fieldTJMonths = TextEditingController();
  final fieldWEYears = TextEditingController();
  final fieldWEMonths = TextEditingController();
  final scrollController = ScrollController();
  final monthlyIncomeController = TextEditingController();
  final monthlyFamilyIncomeController = TextEditingController();
  final currentCompanyNameController = TextEditingController();
  final currentCompanyAdd1Controller = TextEditingController();
  final currentCompanyAdd2Controller = TextEditingController();
  final currentCompanyPincodeController = TextEditingController();
  final salaryDateController = TextEditingController();
  final industryOther = TextEditingController();

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

  String? _industryDropdownValue;
  String? get industryDropdownValue => _industryDropdownValue;

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
  var employmentTypeDropDown = [
    "Salaried",
  ];

  bool checkValidExp() {
    var jobExp = (fieldTJMonths.text.toString() != '' &&
                fieldTJMonths.text.toString() != null
            ? int.parse(fieldTJMonths.text.toString())
            : 0) +
        12 *
            (fieldTJYears.text.toString() != '' &&
                    fieldTJYears.text.toString() != null
                ? int.parse(fieldTJYears.text.toString())
                : 0);
    var workExp = (fieldWEMonths.text.toString() != '' &&
                fieldWEMonths.text.toString() != null
            ? int.parse(fieldWEMonths.text.toString())
            : 0) +
        12 *
            (fieldWEYears.text.toString() != '' &&
                    fieldWEYears.text.toString() != null
                ? int.parse(fieldWEYears.text.toString())
                : 0);
    print("months exper");
    print(jobExp);
    print(workExp);
    print(fieldWEMonths);
    print(fieldWEMonths.text);
    print(fieldWEMonths.text.toString());
    print(fieldTJMonths.text.toString());

    if (jobExp == 0 && workExp == 0) {
      return true;
    } else if (jobExp > workExp
        //  ||
        // fieldWEMonths.text.toString() == "" ||
        // fieldTJMonths.text.toString() == ""
        ) {
      return true;
    } else {
      if ((fieldWEMonths.text.toString() != ''
              ? int.parse(fieldWEMonths.text.toString()) > 12
              : 0 > 12) ||
          (fieldTJMonths.text.toString() != ''
              ? int.parse(fieldTJMonths.text.toString()) > 12
              : 0 > 12)) {
        return true;
      }
      _experienceError = false;
      notifyListeners();
      return false;
    }
  }

  bool isEmpty() {
    // setState(() {
    if ((industryDropdownValue != null) && (employmentTypeDropDown != null)) {
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

      this.salaryDateController.text = result[2].toString();

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
      if (response['employerType'] != null) {
        _employmentTypeDropdownValue = response['employerType'] != null
            ? response['employerType'].toString()
            : "";
      }
      this.monthlyIncomeController.text = response['nettakehomesalary'] != null
          ? response['nettakehomesalary'].toString()
          : "";

      this.salaryDateController.text =
          response['salaryDay'] != null ? response['salaryDay'].toString() : "";
      this.monthlyFamilyIncomeController.text =
          response['monthlyFamilyIncome'] != null
              ? response['monthlyFamilyIncome'].toString()
              : "";
      this.currentCompanyNameController.text =
          response['organizationName'] != null
              ? response['organizationName'].toString()
              : "";
      this.currentCompanyAdd1Controller.text =
          response['workplaceAddress1'] != null
              ? response['workplaceAddress1'].toString()
              : "";
      this.currentCompanyAdd2Controller.text =
          response['workplaceAddress2'] != null
              ? response['workplaceAddress2'].toString()
              : "";
      this.currentCompanyPincodeController.text =
          response['workplacePincode'] != null
              ? response['workplacePincode'].toString()
              : "";

      if (response['industry'] != null) {
        if (!industryDropDown.contains(response['industry'].toString())) {
          industryDropDown = [
            ...industryDropDown,
            response['industry'].toString()
          ];
          _industryDropdownValue = response['industry'] != null
              ? response['industry'].toString()
              : "";
          notifyListeners();
        } else {
          _industryDropdownValue = response['industry'] != null
              ? response['industry'].toString()
              : "";
          notifyListeners();
        }
        _industryDropdownValue =
            response['industry'] != null ? response['industry'].toString() : "";
      }
      this.fieldWEMonths.text = response['totalJobExpInMonth'] != null
          ? response['totalJobExpInMonth'].toString()
          : "";
      this.fieldWEYears.text = response['totalJobExpInYears'] != null
          ? response['totalJobExpInYears'].toString()
          : "";
      this.fieldTJMonths.text = response['currentJobExpInMonth'] != null
          ? response['currentJobExpInMonth'].toString()
          : "";
      this.fieldTJYears.text = response['currentJobExpInYears'] != null
          ? response['currentJobExpInYears'].toString()
          : "";
    }
  }

  // set dropdown values

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
      if (isChecked) {
        var check = await checkValidExp();

        if (check) {
          _experienceError = true;

          notifyListeners();
          // Loader().loaderClose(context);
          return;
        }
        try {
          // Loader().fetchData(context);
          FetchLoader().fetchData(context, 'Submitting...');
          print('going to create payload');
          var payload;
          if (response != "" && response != null) {
            print('response not null');
            payload = {
              ...response,
              "userId": userId.toString(),
              "netTakeHomeSalary":
                  int.parse(monthlyIncomeController.text.toString()),
              "monthlyFamilyIncome":
                  monthlyFamilyIncomeController.text.toString().length > 2
                      ? int.parse(monthlyFamilyIncomeController.text.toString())
                      : "",
              "employmentType": employmentTypeDropdownValue.toString(),
              "organizationName": currentCompanyNameController.text.toString(),
              "workplaceAddress1": currentCompanyAdd1Controller.text.toString(),
              "workplaceAddress2": currentCompanyAdd2Controller.text.toString(),
              "workplacePincode":
                  int.parse(currentCompanyPincodeController.text.toString()),
              "industry": industryDropdownValue.toString() == "Other"
                  ? industryOther.text.toString()
                  : industryDropdownValue.toString(),
              "currentJobExpInMonth": fieldTJMonths.text.toString() != ''
                  ? int.parse(fieldTJMonths.text.toString())
                  : 0,
              "currentJobExpInYears": fieldTJYears.text.toString() != ''
                  ? int.parse(fieldTJYears.text.toString())
                  : 0,
              "totalJobExpInMonth": fieldWEMonths.text.toString() != ''
                  ? int.parse(fieldWEMonths.text.toString())
                  : 0,
              "totalJobExpInYears": fieldWEYears.text.toString() != ''
                  ? int.parse(fieldWEYears.text.toString())
                  : 0,
              "salaryDay": salaryDateController.text.toString(),
              "formStatus": ""
            };
          } else {
            print('response  null');
            print('response  null');
            payload = {
              "userId": userId.toString(),
              "netTakeHomeSalary":
                  int.parse(monthlyIncomeController.text.toString()),
              "monthlyFamilyIncome":
                  monthlyFamilyIncomeController.text.toString().length > 2
                      ? int.parse(monthlyFamilyIncomeController.text.toString())
                      : "",
              "employmentType": employmentTypeDropdownValue.toString(),
              "organizationName": currentCompanyNameController.text.toString(),
              "workplaceAddress1": currentCompanyAdd1Controller.text.toString(),
              "workplaceAddress2": currentCompanyAdd2Controller.text.toString(),
              "workplacePincode":
                  int.parse(currentCompanyPincodeController.text.toString()),
              "industry": industryDropdownValue.toString() == "Other"
                  ? industryOther.text.toString()
                  : industryDropdownValue.toString(),
              "currentJobExpInMonth": fieldTJMonths.text.toString() != ''
                  ? int.parse(fieldTJMonths.text.toString())
                  : 0,
              "currentJobExpInYears": fieldTJYears.text.toString() != ''
                  ? int.parse(fieldTJYears.text.toString())
                  : 0,
              "totalJobExpInMonth": fieldWEMonths.text.toString() != ''
                  ? int.parse(fieldWEMonths.text.toString())
                  : 0,
              "totalJobExpInYears": fieldWEYears.text.toString() != ''
                  ? int.parse(fieldWEYears.text.toString())
                  : 0,
              "salaryDay": salaryDateController.text.toString(),
              "formStatus": ""
            };
          }

          print(payload);
          var res = await _myRepo.handleSubmitionApi(payload);

          print(res);
          // print(res['msg'].toString());
          print(res['status']);
          if (res['status'] == 200) {
            Loader().loaderClose(context);

            // Navigator.push(
            //   context,
            //   PageTransition(
            //       type: PageTransitionType.rightToLeftWithFade,
            //       child: NewBankDetails()),
            //   // BankDetailScreen()),
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
      } else {
        _isCheckedError = true;

        Utils.toastMessage("Accept the declaration message");
        notifyListeners();
      }
    } catch (e) {
      print("e");
      print(e);
    }
  }
}
