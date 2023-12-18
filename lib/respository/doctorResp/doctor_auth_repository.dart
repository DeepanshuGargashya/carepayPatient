import 'dart:convert';

import 'package:http/http.dart';
import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class DoctorAuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> generateOtpApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.doctorGenerateAuthOtp.toString()}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> resendOtpApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.doctorResendOtp.toString()}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> verifyOtpApi(dynamic phone, dynamic otp) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.doctorVerifyOtp}?phoneNumber=${phone.toString()}&otp=${otp.toString()}');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPersonalDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDoctorDetailsByPhoneNumber}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getFormStatusApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getDoctorFormStatus}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
