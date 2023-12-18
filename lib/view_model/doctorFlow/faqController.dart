import 'package:flutter/cupertino.dart';
import 'package:CarePay/respository/doctorResp/postQuestionRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/loader.dart';
import '../../res/textConstant.dart';
import '../../utils/utils.dart';

class FaqController with ChangeNotifier {
  final _myRepo = PostQuestionRepository();

  TextEditingController query = TextEditingController();
  ScrollController scrollController = ScrollController();

  var _response = null;
  get response => _response;
  var _authenticate = false;
  get authenticate => _authenticate;

  var _doctorId = null;
  get doctorId => _doctorId;

  var _mobileNumber = null;
  get mobileNumber => _mobileNumber;

  late BuildContext _context;
  get context => _context;

  var _index = 0;
  get index => _index;

  setvalue(value) {
    _index = value;

    notifyListeners();
  }

  handleDispose() {
    _response = null;

    _authenticate = false;
    _doctorId = null;
    _mobileNumber = null;
    _index = 0;
    notifyListeners();
  }

  void initFetchData(context, index) async {
    handleDispose();
    // Loader().fetchData(context);
    // if (index !="") {
    setvalue(index);
    scrollController.animateTo(index * MediaQuery.of(context).size.width / 1.4,
        duration: Duration(seconds: 1), curve: Curves.linear);
    notifyListeners();
    // }
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    var auth = await pref.getBool('authenticated');
    var verifyAuth = await pref.getBool('verifyAuthentication');
    if ((auth != null && auth) || (verifyAuth != null && verifyAuth)) {
      _authenticate = true;
      notifyListeners();
    }
    dynamic number = pref.getString('number');
    _doctorId = getDoctorId;
    _mobileNumber = number;
    notifyListeners();
    // Loader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    if (response != null) {
      this.query.text =
          response['query'] != null ? response['query'].toString() : "";
    }
  }

  handleSubmition(context) async {
    Loader().fetchData(context);
    try {
      var payload = {
        "doctorId": doctorId.toString(),
        "query": query.text.toString(),
        "mobileNumber": mobileNumber.toString()
      };

      var res = await _myRepo.postQustionApi(payload);
      print(res);
      if (res['status'] == 200) {
        query.clear();
        Loader().loaderClose(context);
        Navigator.pop(context);
        Utils.postSuccessfully(context, '${TextConstant.questionPosted}');
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
