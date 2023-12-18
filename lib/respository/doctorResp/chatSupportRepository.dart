import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class ChatSupportRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> chatSupportApi(dynamic data) async {
    print('hit respo');

    try {
      dynamic response =
          await _apiServices.getPostApiResponse('${AppUrl.chatSupport}', data);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getChatSupportApi(data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getChatSupport}?identifierType=${data["identifierType"].toString()}&identifier=${data['identifier'].toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
