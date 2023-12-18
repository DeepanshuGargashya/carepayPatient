import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class NewsDetailRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getNewsDetailApi() async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getNews}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}