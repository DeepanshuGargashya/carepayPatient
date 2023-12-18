import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import '../../components/loader.dart';
import '../../res/textConstant.dart';
import '../../respository/patientResp/shareDoctorDetailsRepository.dart';
import '../../utils/utils.dart';

class ShareDoctorDetailsController with ChangeNotifier {
  final _myRepo = ShareDoctorDetailsRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController doctorContactController = TextEditingController();
  TextEditingController purposeOfLoanController = TextEditingController();
  TextEditingController loanRequestAmountController = TextEditingController();
  TextEditingController mobController = TextEditingController();

  handleClear() {
    nameController.clear();
    doctorContactController.clear();
    doctorNameController.clear();
    purposeOfLoanController.clear();
    loanRequestAmountController.clear();
    mobController.clear();
  }

  handleSubmition(context) async {
    Loader().fetchData(context);
    try {
      var payload = {
        "name": nameController.text.toString(),
        "mobile": mobController.text.toString(),
        "doctorName": doctorNameController.text.toString(),
        "doctorContact": doctorContactController.text.toString(),
        "purpose": purposeOfLoanController.text.toString(),
        "amount": loanRequestAmountController.text.toString()
      };

      var res = await _myRepo.handleSubmitionApi(payload);
      print(res);
      if (res['status'] == 200) {
        handleClear();
        Loader().loaderClose(context);
        Utils.updateSucessfully(
            context, '${TextConstant.sharedUp}', '${TextConstant.okayy}');
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
