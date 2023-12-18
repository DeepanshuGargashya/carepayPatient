import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class ShareDoctorDetailsRepository{
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> handleSubmitionApi(dynamic payload) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.shareDoctorDetails}', payload);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}