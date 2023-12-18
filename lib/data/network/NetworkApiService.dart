import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:CarePay/data/app_excaptions.dart';
import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiServices {
  static var client = http.Client();

  setHeaders(token) => {
        "Content-Type": "application/json",
        // "Authorization": 'Bearer ${token.toString()}',
        "Accept": "application/json"
      };
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      print("hit Get network tab ========>");
      print("goint to hit network tab with data ========>");
      print(url.toString());
      // print(data);
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      print("exception");
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    dynamic token = prefs.getString('token');
    print("hit network tab ========>");
    print("goint to hit network tab with data ========>");
    print(url.toString());
    print(data);
    // print(data);
    dynamic responseJson;
    Response response;
    try {
      if (data != null) {
        response = await client
            .post(
              Uri.parse(url),
              headers:
                  token != null ? setHeaders(token.toString()) : setHeaders(""),
              body: jsonEncode(data),
            )
            .timeout(Duration(seconds: 30));
      } else {
        response = await client
            .post(
              Uri.parse(url),
              headers:
                  token != null ? setHeaders(token.toString()) : setHeaders(""),
            )
            .timeout(Duration(seconds: 30));
      }
      print('got response');
      responseJson = returnResponse(response);
    } catch (e) {
      print(e);
      throw FetchDataException('No Internet Connection');
    }
    // on SocketException {

    //   throw FetchDataException('No Internet Connection');
    // }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
