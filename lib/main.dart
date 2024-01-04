import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/bottom_bar.dart';
import 'package:CarePay/screens/doctorScreens/home.dart';
import 'package:CarePay/screens/doctorScreens/instantLoanWelcome.dart';
import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/screens/patientScreens/dashboard.dart';
import 'package:CarePay/screens/patientScreens/mobileVerification.dart';
import 'package:CarePay/screens/patientScreens/patientLandingScreen.dart';
import 'package:CarePay/splashScreen.dart';
import 'package:CarePay/view_model/doctorFlow/addPatientController.dart';
import 'package:CarePay/view_model/doctorFlow/addressDoctorDetailController.dart';
import 'package:CarePay/view_model/doctorFlow/aiAssistantController.dart';
import 'package:CarePay/view_model/doctorFlow/allTransactionController.dart';
import 'package:CarePay/view_model/doctorFlow/chatSupportController.dart';
import 'package:CarePay/view_model/doctorFlow/disputeController.dart';
import 'package:CarePay/view_model/doctorFlow/doctorBankDetailsController.dart';
import 'package:CarePay/view_model/doctorFlow/doctorMobileVerificationController.dart';
import 'package:CarePay/view_model/doctorFlow/doctorProfileController.dart';
import 'package:CarePay/view_model/doctorFlow/faqController.dart';
import 'package:CarePay/view_model/doctorFlow/homeController.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:CarePay/view_model/doctorFlow/instantLoanWelcomeController.dart';
import 'package:CarePay/view_model/doctorFlow/newsController.dart';
import 'package:CarePay/view_model/doctorFlow/personalDetailController.dart';
import 'package:CarePay/view_model/doctorFlow/prebottomController.dart';
import 'package:CarePay/view_model/doctorFlow/professionalDetailController.dart';
import 'package:CarePay/view_model/doctorFlow/uploadDoctorDetailController.dart';
import 'package:CarePay/view_model/patientFlow/addressDetailController.dart';
import 'package:CarePay/view_model/patientFlow/bankDetailController.dart';
import 'package:CarePay/view_model/patientFlow/bankStatementController.dart';
import 'package:CarePay/view_model/patientFlow/barCodeScannerController.dart';
import 'package:CarePay/view_model/patientFlow/confirmationPageController.dart';
import 'package:CarePay/view_model/patientFlow/creditAgreementController.dart';
import 'package:CarePay/view_model/patientFlow/creditDetailController.dart';
import 'package:CarePay/view_model/patientFlow/dashboardController.dart';
import 'package:CarePay/view_model/patientFlow/eMandateController.dart';
import 'package:CarePay/view_model/patientFlow/emiPlansController.dart';
import 'package:CarePay/view_model/patientFlow/employementDetailCotroller.dart';
// import 'package:CarePay/view_model/patientFlow/kycVerificationController.dart';
import 'package:CarePay/view_model/patientFlow/makePaymentController.dart';
import 'package:CarePay/view_model/patientFlow/mobileVerificationController.dart';
import 'package:CarePay/view_model/patientFlow/personalDetailController.dart';
import 'package:CarePay/view_model/patientFlow/shareDoctorDetailsController.dart';
import 'package:CarePay/view_model/patientFlow/underProcessController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        // patient ===========>
        ChangeNotifierProvider(create: (_) => MobileVerificationController()),
        ChangeNotifierProvider(create: (_) => PersonalDetailController()),
        ChangeNotifierProvider(create: (_) => AddressDetailController()),
        ChangeNotifierProvider(create: (_) => EmploymentDetailController()),
        ChangeNotifierProvider(create: (_) => CreditDetailController()),
        ChangeNotifierProvider(create: (_) => BankDetailController()),
        ChangeNotifierProvider(create: (_) => BankStatementController()),
        // ChangeNotifierProvider(create: (_) => KYCVerificationController()),
        ChangeNotifierProvider(create: (_) => UnderProcessController()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => CreditAgreementController()),
        ChangeNotifierProvider(create: (_) => EMandateController()),
        ChangeNotifierProvider(create: (_) => ConfirmationController()),
        ChangeNotifierProvider(create: (_) => BarCodeScannerController()),
        ChangeNotifierProvider(create: (_) => ShareDoctorDetailsController()),
        ChangeNotifierProvider(create: (_) => EmiPlansController()),

        // Doctor ==================>
        ChangeNotifierProvider(
            create: (_) => DoctorMobileVerificationController()),
        ChangeNotifierProvider(create: (_) => InstantLoanWelcomeController()),
        ChangeNotifierProvider(create: (_) => AddPatientController()),
        ChangeNotifierProvider(create: (_) => DoctorProfileController()),
        ChangeNotifierProvider(create: (_) => PersonalDetailsController()),
        ChangeNotifierProvider(create: (_) => ProfessionalDetailController()),
        ChangeNotifierProvider(create: (_) => AddressDoctorDetailsController()),
        ChangeNotifierProvider(create: (_) => DoctorBankDetailsController()),
        ChangeNotifierProvider(create: (_) => UploadDetailController()),
        ChangeNotifierProvider(create: (_) => AllTransactionController()),
        ChangeNotifierProvider(create: (_) => HomeMainController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => FaqController()),
        ChangeNotifierProvider(create: (_) => DisputeController()),
        ChangeNotifierProvider(create: (_) => NewsDetailController()),
        ChangeNotifierProvider(create: (_) => MakePaymentController()),
        ChangeNotifierProvider(create: (_) => ChatSupportController()),
        ChangeNotifierProvider(create: (_) => PreBottomController()),
        ChangeNotifierProvider(create: (_) => AIAssistantController()),
        // ChangeNotifierProvider(create: (_) => UserViewModel())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CarePay',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen()
          // home: DashboardScreen()
          ),
    );
  }
}

// class MyAppAuthenticate extends StatelessWidget {
//   dynamic auth;
//   MyAppAuthenticate({super.key, required this.auth});
// This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
// return MultiProvider(
//       providers: [
//         // patient ===========>
//         ChangeNotifierProvider(create: (_) => MobileVerificationController()),
//         ChangeNotifierProvider(create: (_) => PersonalDetailController()),
//         ChangeNotifierProvider(create: (_) => AddressDetailController()),
//         ChangeNotifierProvider(create: (_) => EmploymentDetailController()),
//         ChangeNotifierProvider(create: (_) => CreditDetailController()),
//         ChangeNotifierProvider(create: (_) => BankDetailController()),
//         ChangeNotifierProvider(create: (_) => BankStatementController()),
//         ChangeNotifierProvider(create: (_) => KYCVerificationController()),
//         ChangeNotifierProvider(create: (_) => UnderProcessController()),
//         ChangeNotifierProvider(create: (_) => DashboardController()),
//         ChangeNotifierProvider(create: (_) => CreditAgreementController()),
//         ChangeNotifierProvider(create: (_) => EMandateController()),
//         ChangeNotifierProvider(create: (_) => ConfirmationController()),
//         ChangeNotifierProvider(create: (_) => BarCodeScannerController()),
//         ChangeNotifierProvider(create: (_) => ShareDoctorDetailController()),
//         // Doctor ==================>
//         ChangeNotifierProvider(
//             create: (_) => DoctorMobileVerificationController()),
//         ChangeNotifierProvider(create: (_) => InstantLoanWelcomeController()),
//         ChangeNotifierProvider(create: (_) => AddPatientController()),
//         ChangeNotifierProvider(create: (_) => DoctorProfileController()),
//         ChangeNotifierProvider(create: (_) => PersonalDetailsController()),
//         ChangeNotifierProvider(create: (_) => ProfessionalDetailController()),
//         ChangeNotifierProvider(create: (_) => AddressDoctorDetailsController()),
//         ChangeNotifierProvider(create: (_) => DoctorBankDetailsController()),
//         ChangeNotifierProvider(create: (_) => UploadDetailController()),
//         ChangeNotifierProvider(create: (_) => AllTransactionController()),
//         ChangeNotifierProvider(create: (_) => HomeMainController()),
//         ChangeNotifierProvider(create: (_) => HomeController()),
//         ChangeNotifierProvider(create: (_) => FaqController()),
//         ChangeNotifierProvider(create: (_) => DisputeController()),
//         ChangeNotifierProvider(create: (_) => NewsDetailController()),
//       ],
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: auth),
//     );
//   }
// }
