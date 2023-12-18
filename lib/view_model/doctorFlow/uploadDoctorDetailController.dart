import 'package:CarePay/components/loader.dart';
import 'package:CarePay/res/color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CarePay/respository/doctorResp/uploadDoctorDetailsRepository.dart';
import 'package:CarePay/screens/doctorScreens/thank_you.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:http/http.dart' as http;

class UploadDetailController with ChangeNotifier {
  final _myRepo = UploadDetailRepository();

  var _panCardUploadName = '';
  get panCardUploadName => _panCardUploadName;

  var _chequeUploadName = '';
  get chequeUploadName => _chequeUploadName;

  var _gstindUploadName = '';
  get gstindUploadName => _gstindUploadName;

  var _medicalLicense = '';
  get medicalLicense => _medicalLicense;

  bool _chequeError = false;
  bool get chequeError => _chequeError;

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _isCheckedError = false;
  bool get isCheckedError => _isCheckedError;

  var _response = null;
  get response => _response;

  var _doctorId = null;
  get doctorId => _doctorId;

  final ImagePicker _picker = ImagePicker();

  late BuildContext _context;
  get context => _context;

  void initFetchData(context) async {
    Loader().fetchData(context);
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    _doctorId = getDoctorId;
    // print(number.toString());
    var res = await _myRepo.getAddressDetailApi(getDoctorId.toString());
    _response = res['data'];
    print(res['data']);

    //   setState(() {
    print(res['data']);

    if (res['data'] != null) {
      setController(res['data']);
    }

    notifyListeners();
    Loader().loaderClose(context);
  }

  setController(response) {
    if (response['panCardUrl'] != null && response['panCardUrl'] != "null") {
      _panCardUploadName = response['panCardUrl'].toString();
    }
    if (response['gstUrl'] != null && response['gstUrl'] != "null") {
      _gstindUploadName = response['gstUrl'].toString();
    }
    if (response['otherDocUrl'] != null && response['otherDocUrl'] != "null") {
      _chequeUploadName = response['otherDocUrl'].toString();
    }
  }

  setIsChecked(value) {
    _isChecked = value;
    _isCheckedError = false;
    notifyListeners();
  }

  void openModal(context, type) {
    showModalBottomSheet(
      // backgroundColor : AppColors.white,
      context: context,
      isDismissible: true,
      // barrierColor: none,
      // backgroundColor: Colors.green[200],
      backgroundColor: AppColors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Container(
              color: AppColors.white,
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
                                color: AppColors.primaryPurple,
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
                                  color: AppColors.primaryPurple,
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
                  //               color: AppColors.primaryPurple,
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
      // print(resultFile?.files.first.extension);
      if (resultFile != null) {
        Loader().fetchData(context);
        PlatformFile file = resultFile.files.first;
        print("extension");
        print(file.extension);
        print(file.extension.toString());
        response = await _myRepo.handleUploading(file.path, doctorId.toString(),
            type.toString(), file.extension.toString());
      }
    } else {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      print("image:");
      print(image);
      if (image == null) return;
      // setState(() {
      //   aadharUploadingStatus = "inProcess";
      // });
      Loader().fetchData(context);

      response = await _myRepo.handleUploading(
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
              _chequeError = false;
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
      // Loader().loaderClose(context);
    }
    // Loader().loaderClose(context);
    Navigator.pop(context);
    //   print(file.path);
    // print(file.name);
    // print(file.bytes);
    // print(file.extension);
    // print(file.path);
  }

  handleSubmition(BuildContext context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // print(panCardUploadName.toString().length);
    // print(panCardUploadName);
    if (isChecked) {
      // if (chequeUploadName.length > 0) {
      try {
        var res = await _myRepo.sendEmail(doctorId.toString());
        if (res['status'] == 200) {
          await pref.setBool('authenticated', true);
          await pref.setString('role', "doctor");
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: thank_you()),
          );
        }
      } catch (e) {
        Utils.toastMessage("Something went wrong to send mail");
      }
      // } else {
      //   _chequeError = true;
      //   notifyListeners();
      //   Utils.toastMessage("Please Upload All Documents");
      // }
    } else {
      _isCheckedError = true;
      Utils.toastMessage("Accept the Terms & conditions");
      notifyListeners();
    }
  }
}
