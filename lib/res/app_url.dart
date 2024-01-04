class AppUrl {
  // static var baseUrl = 'https://backend.carepay.money';
  static var baseUrl = 'http://52.66.174.28:8075';
  // static var testBaseUrl = 'http://52.66.174.28:8075';

  // patient urls

  static var generateAuthOtp = "${baseUrl}/userDetails/sendOtpToMobile?mobile=";
  static var verifyOtp = "${baseUrl}/userDetails/verifyOtp";
  static var updatePersonalDetails = "${baseUrl}/userDetails/basicDetail";
  static var updateAddressDetails = "${baseUrl}/userDetails/addressDetail";
  static var updateEmploymentDetails =
      "${baseUrl}/userDetails/employmentDetail";
  static var updateBankDetails = "${baseUrl}/userDetails/addAccountDetails";
  static var uploadBankStatement = "${baseUrl}/uploadMultipleBankStatements";
  static var updateCreditDetails = "${baseUrl}/userDetails/saveLoanDetails";

  static var getBasicDetails =
      "${baseUrl}/userDetails/getUserDetailsByUserId?userId=";
  static var getAddressDetail =
      "${baseUrl}/userDetails/getUserAddressByUserId?userId=";
  static var getEmployementDetails =
      "${baseUrl}/userDetails/getUserEmploymentByUserId?userId=";
  static var getBankDetails =
      "${baseUrl}/userDetails/getAccountInfoByUserId?userId=";
  static var getBankStatement = "${baseUrl}/getDocumentsByUserId?userId=";
  static var getCreditDetails =
      "${baseUrl}/userDetails/getLoanDetailsByUserId?userId=";
  static var getKYCVerificationStatus = "${baseUrl}/initiateFlow?userId=";
  static var getKYCVerificationStatusTest = "${baseUrl}/initiateFlow?userId=";

  static var getUserDetails =
      "${baseUrl}/userDetails/getUserDetailsByUserId?userId=";

  static var getFormStatus =
      "${baseUrl}/userDetails/getFormStatusByUserId?userId=";
  static var shareDoctorDetails = "${baseUrl}/saveOrUpdateDoctorOpportunities";

  // doctor urls
  static var doctorGenerateAuthOtp = "${baseUrl}/sendOtp?phoneNumber=";
  static var getDoctorFormStatus = "${baseUrl}/getDoctorFormStatus?doctorId=";
  static var doctorResendOtp = "${baseUrl}/reSendOtp?phoneNumber=";
  static var doctorVerifyOtp = "${baseUrl}/getOtp";

  static var getDoctorDetailsByPhoneNumber =
      "${baseUrl}/getDoctorDetailsByPhoneNumber?mobileNo=";
  static var getDoctorDetailsByDoctorId =
      "${baseUrl}/getDoctorDetailByDoctorId?doctorId=";
  static var updateDoctorPersonalDetails =
      "${baseUrl}/saveOrUpdateDoctorDetails";

  static var updateDoctorProfessionalDetails =
      "${baseUrl}/saveOrUpdateDoctorProfessionalDetails";
  static var getDoctorProfessionalDetailsByDoctorId =
      "${baseUrl}/getDoctorProfDetailsByDoctorId?doctorId=";

  static var updateDoctorAddressDetails =
      "${baseUrl}/saveOrUpdateAddressDetails";
  static var getDoctorAddressDetailsByDoctorId =
      "${baseUrl}/getAddressDetails?doctorId=";

  static var updateDoctorBankDetails = "${baseUrl}/saveOrUpdateBankDetails";
  static var getBankDetailsByIFSC = "${baseUrl}/userDetails/codeDetail?code=";
  static var getDetailsByPincode = "${baseUrl}/userDetails/codeDetail?code=";
  static var getDoctorBankDetails =
      "${baseUrl}/getBankDetailsByDoctorId?doctorId=";

  static var uploadDoctorDetails = "${baseUrl}/uploadpdf";
  static var getDoctorDetails = "${baseUrl}/getDocumentsByDoctorId?doctorId=";

  static var getAllTransactions = "${baseUrl}/getAllLoansByDoctorId?doctorId=";
  static var getAllTransactionsCount =
      "${baseUrl}/getAllLoansByDoctorIdCount?doctorId=";
  static var getLoanSummary = "${baseUrl}/loanSummary?doctorId=";
  static var addPatient = "${baseUrl}/addLead";
  static var addPatientSendMail = "${baseUrl}/sendProfileCompletion?";
  static var addDoctorSendMail = "${baseUrl}/sendUnderReviewMail?doctorId=";
  static var getGraph = "${baseUrl}/loanCountTrend?doctorId=";

  static var getDoctorVerificationStatus =
      "${baseUrl}/getDoctorVerificationStatus?doctorId=";
  static var getNews = "${baseUrl}/getNewsData";
  static var postQuestion = "${baseUrl}/saveOrUpdateQuery";
  static var chatSupport = "${baseUrl}/saveComments";
  static var getChatSupport = "${baseUrl}/getComments";
  static var getCibilDataDecentro =
      "${baseUrl}/getCibilDataDecentro?consent=true&userId=";
  static var createRpd = "${baseUrl}/createRPD";
  static var getRpdDetails = "${baseUrl}/getDetails?requestId=";
  static var raiseDispute = "${baseUrl}/saveOrUpdateDoctorDispute";
}
