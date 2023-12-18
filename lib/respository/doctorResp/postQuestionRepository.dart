import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class PostQuestionRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> postQustionApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.postQuestion}', data);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
