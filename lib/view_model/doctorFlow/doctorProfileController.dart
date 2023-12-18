import 'package:CarePay/components/loader.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/respository/doctorResp/addressDetailRepository.dart';
import 'package:CarePay/respository/doctorResp/bankDetailsRepository.dart';
import 'package:CarePay/respository/doctorResp/personalDetailRepository.dart';
import 'package:CarePay/respository/doctorResp/professionalDetailRepository.dart';
import 'package:CarePay/respository/doctorResp/uploadDoctorDetailsRepository.dart';
import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/doctorScreens/bottom_bar.dart';
import '../../screens/doctorScreens/home.dart';

class DoctorProfileController with ChangeNotifier {
  final _myUploadRepo = UploadDetailRepository();
  final _myPersonalRepo = PersonalDetailRepository();
  final _myPracticeRepo = ProfessionalDetailRepository();
  final _myBankRepo = DoctorBankDetailRepository();
  final _myAddressRepo = AddressDetailRepository();

  // controllers =============>

  // < ============== personal controller ===============>
  final editNameController = TextEditingController();
  final editEmailController = TextEditingController();
  final editMobController = TextEditingController();
  final editPanController = TextEditingController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobController = TextEditingController();
  final panController = TextEditingController();

  // < ============== address controller ===============>
  final editBuildingController = TextEditingController();
  final editLocalityController = TextEditingController();
  final editPincodeController = TextEditingController();
  final editCityController = TextEditingController();

  final buildingController = TextEditingController();
  final localityController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();

  // < ============== practice controller ===============>
  final editLicenseController = TextEditingController();
  final editClinicController = TextEditingController();
  final editBuisnessEntityController = TextEditingController();

  final licenseController = TextEditingController();
  final clinicController = TextEditingController();
  final buisnessEntityController = TextEditingController();

  // < ============== bank controller ===============>
  final editAccountController = TextEditingController();
  final editHolderNameController = TextEditingController();
  final editIFSCController = TextEditingController();
  final editBankNameController = TextEditingController();
  final editBranchNameController = TextEditingController();

  final accountController = TextEditingController();
  final holderNameController = TextEditingController();
  final IFSCController = TextEditingController();
  final bankNameController = TextEditingController();
  final branchNameController = TextEditingController();

  // <======================== response state variables ==================>

  var _addressResponse = null;
  get addressResponse => _addressResponse;

  var _personalResponse = null;
  get personalResponse => _personalResponse;

  var _practiceResponse = null;
  get practiceResponse => _practiceResponse;

  var _bankResponse = null;
  get bankResponse => _bankResponse;

  var _documentResponse = null;
  get documentResponse => _documentResponse;

  // <======================== state variables ==================>
  var _doctorId = null;
  get doctorId => _doctorId;

  bool _loading = false;
  bool get loading => _loading;

  late BuildContext _context;
  get context => _context;

  var _editModalHeight = 200;
  get editModalHeight => _editModalHeight;

  var _panCardUploadName = '';
  get panCardUploadName => _panCardUploadName;

  var _chequeUploadName = '';
  get chequeUploadName => _chequeUploadName;

  var _gstindUploadName = '';
  get gstindUploadName => _gstindUploadName;

  var _profileTab = TextConstant.personall;
  get profileTab => _profileTab;

  String? _editStateDropdownValue;
  String? get editStateDropdownValue => _editStateDropdownValue;

  String? _editEntityDropdownValue;
  String? get editEntityDropdownValue => _editEntityDropdownValue;

  String? _editSpecialityDropdownValue;
  String? get editSpecialityDropdownValue => _editSpecialityDropdownValue;

// -------------------------------------------------------------------
  String? _stateDropdownValue;
  String? get stateDropdownValue => _stateDropdownValue;

  String? _entityDropdownValue;
  String? get entityDropdownValue => _entityDropdownValue;

  String? _specialityDropdownValue;
  String? get specialityDropdownValue => _specialityDropdownValue;

  bool _pinCodeErrorCode = false;
  bool get pinCodeErrorCode => _pinCodeErrorCode;

  bool _ifscErrorCode = false;
  bool get ifscErrorCode => _ifscErrorCode;

  final ImagePicker _picker = ImagePicker();

// < ======================== ending of state variables =====================>

  var stateTypeDropDown = ["A", "g", "C", "D"];
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

// < ========================== set state variable value ==========================>

  setpreviousToEdit(value) {
    if (value == "pincode") {
      this.editPincodeController.text = pincodeController.text.toString();
      _editStateDropdownValue = stateDropdownValue.toString();
      this.editCityController.text = cityController.text.toString();
    }
    if (value == "ifsc") {
      this.editIFSCController.text = IFSCController.text.toString();
      this.editBankNameController.text = bankNameController.text.toString();
      this.editBranchNameController.text = branchNameController.text.toString();
    }
    notifyListeners();
  }

  setProfileTab(value) {
    print("setting profile tab");
    _profileTab = value.toString();
    notifyListeners();
  }

  setstateTypeValue(value) {
    _editStateDropdownValue = value.toString();
    // isEmpty();
    notifyListeners();
  }

  setentityTypeValue(value) {
    _editEntityDropdownValue = value.toString();
    // isEmpty();
    notifyListeners();
  }

  setspecialityTypeValue(value) {
    _editSpecialityDropdownValue = value.toString();
    // isEmpty();
    notifyListeners();
  }

  setEditModalHeight(value) {
    _editModalHeight = value;
    notifyListeners();
  }

// < ================================== end of setting dropdown value ====================>

  void openModal(context, type) {
    showModalBottomSheet(
      context: context,
      // barrierColor: none,
      // backgroundColor: Colors.green[200],
      backgroundColor: Colors.white,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Container(
              // padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            openFiles('gallery', type.toString());
                          },
                          style: ButtonStyle(
                              // shape: MaterialStateProperty.all<
                              //         RoundedRectangleBorder>(
                              //     const RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.only(
                              //       topLeft: Radius.circular(55),
                              //       topRight: Radius.circular(55)),
                              // )),
                              backgroundColor:
                                  MaterialStatePropertyAll(AppColors.white),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.only(top: 20, bottom: 20))),
                          child: const Text(
                            'Upload from gallery',
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: Color.fromARGB(255, 78, 129, 80),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ]),
                  Row(children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              // if (permissionGranted) {
                              openFiles('camera', type.toString());
                              // } else {
                              // _pickeImageBase64(
                              // 'camera');
                              // }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(AppColors.white),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.only(top: 20, bottom: 20))),
                            child: const Text(
                              'Take picture',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Color.fromARGB(255, 78, 129, 80),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )))
                  ]),
                  // Row(children: [
                  //   Expanded(
                  //     child: ElevatedButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         style: ButtonStyle(
                  //             backgroundColor: MaterialStatePropertyAll(
                  //                 Colors.grey.shade200),
                  //             padding: const MaterialStatePropertyAll(
                  //                 EdgeInsets.only(top: 20, bottom: 20))),
                  //         child: const Text(
                  //           'Cancel',
                  //           style: TextStyle(
                  //               color: Color.fromARGB(255, 78, 129, 80),
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold),
                  //         )),
                  //   )
                  // ])
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void openFiles(action, type) async {
    var response;
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // dynamic doctorId = pref.getString('doctorId');
    if (action == 'gallery') {
      FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      );
      if (resultFile != null) {
        Loader().fetchData(context);
        PlatformFile file = resultFile.files.first;
        print("extension");
        print(file.extension);
        print(file.extension.toString());
        response = await _myUploadRepo.handleUploading(file.path,
            doctorId.toString(), type.toString(), file.extension.toString());
      }
    } else {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      print("image:");
      print(image);
      if (image == null) return;
      Loader().fetchData(context);
      // setState(() {
      //   aadharUploadingStatus = "inProcess";
      // });
      response = await _myUploadRepo.handleUploading(
          image.path, doctorId.toString(), type.toString(), "img");
      // handleUploa/ding(image.path, "aadhar", 'camera.jpg');
    }

    print("controller rsponse");
    print(response);
    try {
      http.Response.fromStream(response).then((onValue) {
        print(onValue);
        // print(onValue.body);

        var str = onValue.body;

        if (response.statusCode == 200) {
          print(str);
          if (str.contains("downloadpdf?downloadfile=")) {
            if (type == "panCard") {
              _panCardUploadName = str;
            } else if (type == "other") {
              // _chequeError = false;
              _chequeUploadName = str;
            } else {
              _gstindUploadName = str;
            }
            notifyListeners();
            Utils.successToastMessage('successfully uploaded');
            Loader().loaderClose(context);
          } else {
            Utils.toastMessage('unable To upload pic');
            Loader().loaderClose(context);
          }
        } else {
          Utils.toastMessage('unable To upload pic');
          Loader().loaderClose(context);
        }
      });
    } catch (e) {
      Utils.toastMessage('Please try again later');
      Loader().loaderClose(context);
    }
    Navigator.pop(context);
    // Loader().loaderClose(context);

    //   print(file.path);
    // print(file.name);
    // print(file.bytes);
    // print(file.extension);
    // print(file.path);
  }

  // void openFiles(type) async {
  //   Loader().fetchData(context);
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   dynamic doctorId = pref.getString('doctorId');
  //
  //   FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
  //   if (resultFile != null) {
  //     PlatformFile file = resultFile.files.first;
  //
  //     var response = await _myUploadRepo.handleUploading(
  //         file.path, doctorId.toString(), type.toString());
  //     print("controller rsponse");
  //     print(response);
  //     try {
  //       http.Response.fromStream(response).then((onValue) {
  //         print(onValue);
  //         // print(onValue.body);
  //
  //         var str = onValue.body;
  //
  //         if (response.statusCode == 200) {
  //           Loader().loaderClose(context);
  //           print(str);
  //           if (str.contains("downloadpdf?downloadfile=")) {
  //             if (type == "panCard") {
  //               _panCardUploadName = str;
  //             } else if (type == "other") {
  //               _chequeUploadName = str;
  //             } else {
  //               _gstindUploadName = str;
  //             }
  //             notifyListeners();
  //             Utils.successToastMessage('successfully uploaded');
  //           } else {
  //             Loader().loaderClose(context);
  //             Utils.toastMessage('unable To upload pic');
  //           }
  //         } else {
  //           Loader().loaderClose(context);
  //           Utils.toastMessage('unable To upload pic');
  //         }
  //       });
  //     } catch (e) {
  //       Loader().loaderClose(context);
  //       Utils.toastMessage('Please try again later');
  //     }
  //
  //     //   print(file.path);
  //     // print(file.name);
  //     // print(file.bytes);
  //     // print(file.extension);
  //     // print(file.path);
  //   } else {
  //     Loader().loaderClose(context);
  //   }
  // }

//  <=========================  Getting all details ==================================>
//   dynamic verifyAuthentication = true;

  goBackController() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var verifyAuth = await pref.getBool('verifyAuthentication');
    if (verifyAuth != null && verifyAuth) {
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: bottomBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: home()),
      );
    }
  }

  getAddressDetail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');

    // print(number.toString());
    var res = await _myAddressRepo.getAddressDetailApi(getDoctorId.toString());
    _addressResponse = res['data'];
    print(res['data']);

    //   setState(() {
    if (addressResponse != null) {
      this.editBuildingController.text = addressResponse['building'] != null
          ? addressResponse['building'].toString()
          : "";
      this.buildingController.text = addressResponse['building'] != null
          ? addressResponse['building'].toString()
          : "";
      this.editLocalityController.text = addressResponse['locality'] != null
          ? addressResponse['locality'].toString()
          : "";
      this.localityController.text = addressResponse['locality'] != null
          ? addressResponse['locality'].toString()
          : "";
      this.editPincodeController.text = addressResponse['pinCode'] != null
          ? addressResponse['pinCode'].toString()
          : "";
      this.pincodeController.text = addressResponse['pinCode'] != null
          ? addressResponse['pinCode'].toString()
          : "";
      this.editCityController.text = addressResponse['city'] != null
          ? addressResponse['city'].toString()
          : "";
      this.cityController.text = addressResponse['city'] != null
          ? addressResponse['city'].toString()
          : "";
      if (addressResponse['state'] != null &&
          addressResponse['state'].toString() != "null") {
        this._stateDropdownValue = addressResponse['state'] != null &&
                addressResponse['state'].toString() != "null"
            ? addressResponse['state'].toString()
            : "";
        this._editStateDropdownValue = addressResponse['state'] != null &&
                addressResponse['state'].toString() != "null"
            ? addressResponse['state'].toString()
            : "";
      }
    }
    notifyListeners();
  }

  getPersonalDetail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic number = pref.getString('number');
    print(number.toString());
    var res = await _myPersonalRepo.getPersonalDetailApi(number.toString());
    _personalResponse = res['data'];
    print(res['data']);

    //   setState(() {
    if (personalResponse != null) {
      print(personalResponse['phoneNumber']);

      this.editMobController.text = personalResponse['phoneNumber'] != null
          ? personalResponse['phoneNumber'].toString()
          : "";
      this.editNameController.text = personalResponse['name'] != null
          ? personalResponse['name'].toString()
          : "";
      this.editEmailController.text = personalResponse['emailId'] != null
          ? personalResponse['emailId'].toString()
          : "";
      this.editPanController.text = personalResponse['pan'] != null
          ? personalResponse['pan'].toString()
          : "";

      this.mobController.text = personalResponse['phoneNumber'] != null
          ? personalResponse['phoneNumber'].toString()
          : "";
      this.nameController.text = personalResponse['name'] != null
          ? personalResponse['name'].toString()
          : "";
      this.emailController.text = personalResponse['emailId'] != null
          ? personalResponse['emailId'].toString()
          : "";
      this.panController.text = personalResponse['pan'] != null
          ? personalResponse['pan'].toString()
          : "";
    } else {
      this.editMobController.text = number.toString();
    }
    notifyListeners();
  }

  getPracticeDetail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic doctorId = pref.getString('doctorId');
    print(doctorId.toString());
    var res =
        await _myPracticeRepo.getProfessionalDetailApi(doctorId.toString());
    _practiceResponse = res['data'];
    print(res['data']);
    notifyListeners();

    //   setState(() {
    if (practiceResponse != null) {
      print(practiceResponse['phoneNumber']);

      this.editLicenseController.text =
          practiceResponse['licenceNumber'] != null
              ? practiceResponse['licenceNumber']
              : "";
      if (practiceResponse['speciality'] != null &&
          practiceResponse['speciality'].toString() != "null") {
        this._specialityDropdownValue = practiceResponse['speciality'] != null
            ? practiceResponse['speciality']
            : "";
      }
      this.editClinicController.text = practiceResponse['clinicName'] != null
          ? practiceResponse['clinicName']
          : "";
      this.editBuisnessEntityController.text =
          practiceResponse['businessEntityName'] != null
              ? practiceResponse['businessEntityName']
              : "";
      if (practiceResponse['businessEntityType'] != null &&
          practiceResponse['businessEntityType'].toString() != "null") {
        this._editEntityDropdownValue =
            practiceResponse['businessEntityType'] != null
                ? practiceResponse['businessEntityType']
                : "";
      }

      this.licenseController.text = practiceResponse['licenceNumber'] != null
          ? practiceResponse['licenceNumber']
          : "";
      if (practiceResponse['speciality'] != null &&
          practiceResponse['speciality'].toString() != "null") {
        this._editSpecialityDropdownValue =
            practiceResponse['speciality'] != null
                ? practiceResponse['speciality']
                : "";
      }
      this.clinicController.text = practiceResponse['clinicName'] != null
          ? practiceResponse['clinicName']
          : "";
      this.buisnessEntityController.text =
          practiceResponse['businessEntityName'] != null
              ? practiceResponse['businessEntityName']
              : "";
      if (practiceResponse['businessEntityType'] != null &&
          practiceResponse['businessEntityType'].toString() != "null") {
        this._entityDropdownValue =
            practiceResponse['businessEntityType'] != null
                ? practiceResponse['businessEntityType']
                : "";
      }
    }
    notifyListeners();
  }

  getUploadDetails() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');

    // print(number.toString());
    var res = await _myUploadRepo.getAddressDetailApi(getDoctorId.toString());
    _documentResponse = res['data'];
    notifyListeners();

    if (res['data'] != null) {
      if (documentResponse['panCardUrl'] != null &&
          documentResponse['panCardUrl'] != "null") {
        _panCardUploadName = documentResponse['panCardUrl'].toString();
      }
      if (documentResponse['gstUrl'] != null &&
          documentResponse['gstUrl'] != "null") {
        _gstindUploadName = documentResponse['gstUrl'].toString();
      }
      if (documentResponse['otherDocUrl'] != null &&
          documentResponse['otherDocUrl'] != "null") {
        _chequeUploadName = documentResponse['otherDocUrl'].toString();
      }
    }
    notifyListeners();
  }

  getBankDetails() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');

    var res = await _myBankRepo.getBankDetailApi(getDoctorId.toString());
    _bankResponse = res['data'];
    print("bank printing");
    print(res['data']);
    print(res);

    //   setState(() {
    if (bankResponse != null) {
      // print(bankResponse['phoneNumber']);

      this.editAccountController.text = bankResponse['accountNumber'] != null
          ? bankResponse['accountNumber'].toString()
          : "";

      this.editHolderNameController.text =
          bankResponse['accountHolderName'] != null
              ? bankResponse['accountHolderName'].toString()
              : "";
      this.editIFSCController.text = bankResponse['ifscCode'] != null
          ? bankResponse['ifscCode'].toString()
          : "";
      this.editBankNameController.text = bankResponse['bankName'] != null
          ? bankResponse['bankName'].toString()
          : "";
      this.editBranchNameController.text = bankResponse['branchName'] != null
          ? bankResponse['branchName'].toString()
          : "";

      this.accountController.text = bankResponse['accountNumber'] != null
          ? bankResponse['accountNumber'].toString()
          : "";

      this.holderNameController.text = bankResponse['accountHolderName'] != null
          ? bankResponse['accountHolderName'].toString()
          : "";
      this.IFSCController.text = bankResponse['ifscCode'] != null
          ? bankResponse['ifscCode'].toString()
          : "";
      this.bankNameController.text = bankResponse['bankName'] != null
          ? bankResponse['bankName'].toString()
          : "";
      this.branchNameController.text = bankResponse['branchName'] != null
          ? bankResponse['branchName'].toString()
          : "";
    }

    notifyListeners();
  }

// < ===================================  init function ==============================>

  void initFetchData(context) async {
    Loader().fetchData(context);
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    _doctorId = getDoctorId;
    _context = context;

    await getPersonalDetail();
    await getAddressDetail();
    await getPracticeDetail();
    await getBankDetails();
    await getUploadDetails();

    notifyListeners();
    Loader().loaderClose(context);
  }

  // < =============================== handle logout =============================>
  handleLogout() async {
    Loader().fetchData(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('splashComplete', true);
    Loader().loaderClose(context);
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: HomeScreen()),
        (Route<dynamic> route) => false);
  }

  // <============================== handle updating for all tabs ===============================>

  handleSubmition(BuildContext context, type) async {
    _loading = true;
    notifyListeners();
    print("inside handle submition");
    print(bankResponse);
    Loader().fetchData(context);
    try {
      var res;
      if (profileTab == TextConstant.personall) {
        var payload = {
          ...personalResponse,
          "phoneNumber": editMobController.text.toString(),
          "name": editNameController.text.toString(),
          "pan": editPanController.text.toString(),
          "emailId": editEmailController.text.toString(),
        };

        print(payload);
        res = await _myPersonalRepo.personalDetailApi(payload);
        print(res);
        await getPersonalDetail();
      } else if (profileTab == TextConstant.practiceTab) {
        var payload = {
          ...practiceResponse,
          "licenceNumber": editLicenseController.text.toString(),
          "speciality": editSpecialityDropdownValue.toString(),
          "clinicName": editClinicController.text.toString(),
          "businessEntityName": editBuisnessEntityController.text.toString(),
          "businessEntityType": editEntityDropdownValue.toString(),
        };
        res = await _myPracticeRepo.professionalDetailApi(payload);
        print(payload);
        await getPracticeDetail();
      } else if (profileTab == TextConstant.address) {
        var payload = {
          ...addressResponse,
          "building": editBuildingController.text.toString(),
          "locality": editLocalityController.text.toString(),
          "pinCode": editPincodeController.text.toString(),
          "city": editCityController.text.toString(),
          "state": editStateDropdownValue.toString()
        };
        res = await _myAddressRepo.addressDetailApi(payload);
        print(payload);
        await getAddressDetail();
      } else if (profileTab == TextConstant.bank) {
        print(bankResponse);
        var payload = {
          ...bankResponse,
          "accountNumber": editAccountController.text.toString(),
          "accountHolderName": editHolderNameController.text.toString(),
          "ifscCode": editIFSCController.text.toString(),
          "bankName": editBankNameController.text.toString(),
          "branchName": editBranchNameController.text.toString()
        };
        print(payload);
        res = await _myBankRepo.bankDetailApi(payload);
        print(payload);
        print(res);

        await getBankDetails();
      }

      if (res['status'] == 200) {
        Loader().loaderClose(context);
        _loading = false;
        notifyListeners();
        Navigator.pop(context);
        Utils.updateSucessfully(
            context, "${type.toString()} change request submitted!", 'Okay');
      } else {
        Loader().loaderClose(context);
        _loading = false;

        notifyListeners();
        Navigator.pop(context);
        Utils.toastMessage(res['data'].toString());
      }
    } catch (e) {
      Loader().loaderClose(context);
      _loading = false;
      notifyListeners();
      print(e);
      Utils.toastMessage("Check Internet Connection");
    }
  }

  // fetch dteails by pincode
  fetchPinCodeDetail() async {
    _loading = true;
    notifyListeners();
    Loader().fetchData(context);
    print("here");
    try {
      print("going to hit pincode detail API");
      dynamic res = await _myAddressRepo
          .getDetailsByPinCode(editPincodeController.text.toString());

      if (res['status'] == "success" && res['status'] != null) {
        print("inside not null");
        print(res);

        _pinCodeErrorCode = false;

        if (res['city'] != null) {
          this.editCityController.text =
              res['city'] != null ? res['city'].toString() : "";
        }
        if (res['state'] != null) {
          _editStateDropdownValue =
              res['state'] != null ? res['state'].toString() : "";
        }
        notifyListeners();
        Loader().loaderClose(context);
        _loading = false;
        notifyListeners();
      } else {
        // this.city.text = "";
        // this.stateController.text = "";

        Loader().loaderClose(context);
        print("inside null");
        Utils.toastMessage('Invalid IFSC Code');
        _loading = false;
        _pinCodeErrorCode = true;
        notifyListeners();
      }
      return true;
    } catch (e) {
      // this.city.text = "";
      // this.stateController.text = "";
      Loader().loaderClose(context);
      _loading = false;

      // setState(() {
      _pinCodeErrorCode = true;
      notifyListeners();
      // });
      Utils.toastMessage("Check Internet Connection");
      return true;
    }
  }

  fetchIFSCCodeDetail() async {
    _loading = true;
    notifyListeners();
    Loader().fetchData(context);
    print("here");
    try {
      print("going to hit gardentions API");
      dynamic res = await _myBankRepo
          .getBankDetailsByIFSC(editIFSCController.text.toString());

      if (res['branchName'] != null) {
        print("inside not null");
        print(res);

        _ifscErrorCode = false;
        if (res['branchName'] != null) {
          this.editBankNameController.text =
              res['branchName'] != null ? res['branchName'].toString() : "";
        }
        if (res['city'] != null) {
          this.editBranchNameController.text =
              res['city'] != null ? res['city'].toString() : "";
        }
        notifyListeners();

        Loader().loaderClose(context);
        _loading = false;
        notifyListeners();
      } else {
        // this.bankName.text = "";
        // this.city.text = "";

        Loader().loaderClose(context);
        _loading = false;
        notifyListeners();
        print("inside null");
        Utils.toastMessage('Invalid IFSC Code');

        _ifscErrorCode = true;
        notifyListeners();
      }
      return true;
    } catch (e) {
      // this.bankName.text = "";
      // this.city.text = "";
      Loader().loaderClose(context);
      _loading = false;
      notifyListeners();
      // setState(() {
      _ifscErrorCode = true;
      notifyListeners();
      // });
      Utils.toastMessage("Check Internet Connection");
      return true;
    }
  }
}
