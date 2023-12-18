import 'package:CarePay/components/loader.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/professional.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CarePay/respository/doctorResp/personalDetailRepository.dart';
import 'package:CarePay/utils/utils.dart';

class PersonalDetailsController with ChangeNotifier {
  final _myRepo = PersonalDetailRepository();

  TextEditingController mob = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pan = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dob = TextEditingController();

  DateTime _dateTime = DateTime.now();
  DateTime get dateTime => _dateTime;
  var _response = null;
  get response => _response;

  bool _dobError = false;
  bool get dobError => _dobError;

  setDobError(value) {
    _dobError = value;
    notifyListeners();
  }

  void initFetchData(context) async {
    Loader().fetchData(context);
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic number = pref.getString('number');
    print(number.toString());
    var res = await _myRepo.getPersonalDetailApi(number.toString());
    _response = res['data'];
    print(res['data']);

    //   setState(() {
    setController(res['data'], number);
    notifyListeners();
    Loader().loaderClose(context);
  }

  setController(response, number) {
    print("setting controller");
    // print(number.toString());
    if (response != null) {
      print(response['phoneNumber']);
      this.mob.text = response['phoneNumber'] != null
          ? response['phoneNumber'].toString()
          : "";
      this.name.text =
          response['name'] != null ? response['name'].toString() : "";
      this.pan.text = response['pan'] != null ? response['pan'].toString() : "";
      this.emailId.text =
          response['emailId'] != null ? response['emailId'].toString() : "";
      this.dob.text = response['dob'] != null
          ? response['dob'].toString().substring(0, 10)
          : "";
    } else {
      this.mob.text = number.toString();
    }
    print(mob.text.toString());
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

      this.dob.text =
          '${result[2].toString()}-${result[1].toString()}-${result[0].toString()}';

      notifyListeners();
    }
    return true;
  }

  handleSubmition(BuildContext context) async {
    Loader().fetchData(context);
    try {
      var payload;
      if (response != null) {
        payload = {
          ...response,
          "phoneNumber": mob.text.toString(),
          "name": name.text.toString(),
          "pan": pan.text.toString(),
          "emailId": emailId.text.toString(),
          "dob": dob.text.toString()
        };
      } else {
        payload = {
          "phoneNumber": mob.text.toString(),
          "name": name.text.toString(),
          "pan": pan.text.toString(),
          "emailId": emailId.text.toString(),
          "dob": dob.text.toString()
        };
      }
      print(payload);
      var res = await _myRepo.personalDetailApi(payload);
      print(res);
      if (res['status'] == 200) {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('doctorId', res['data']['doctorId']);
        Loader().loaderClose(context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: practice()),
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
