import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class DashboardRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getUserDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getUserDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getInitiateFlowApi(dynamic userId) async {
    print('hit respo');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var phone = await pref.getString('number');
    print("calling phone to check its test or live");
    print(phone.toString());

    try {
      dynamic response;
      if (phone.toString() == "8810625857") {
        print("calling test");
        // response = await _apiServices.getPostApiResponse(
        //     '${AppUrl.getKYCVerificationStatusTest}Nt23CFZM5nj6E6THJ9slPSG4I44nqJvt&type=loan_details_get',
        //     []);
        response = {
          "status": 200,
          "data": [
            {
              "repayment_screen_show": "repayment_screen",
              "repay_activity": "upi",
              "loan_cancellation": false,
              "loan_id": 1584560,
              "loan_show_id": 1584560,
              "amount": 100.0,
              "collection_amount": 0.0,
              "collection_date": null,
              "disbursal_date": "2023-05-19",
              "repayment_date": "2023-10-19",
              "due_amount": 100.0,
              "repayment_amount": 100.0,
              "loan_status": "DISBURSED",
              "loan_type": "E6",
              "tenure_days": 154,
              "processing_waive_off": 0.0,
              "tenure_date": "2023-05-19T17:47:33.977036",
              "bharti_axa_insurance": [],
              "min_extension_amount": 3.0,
              "medibuddy_history": null,
              "emi_details": [
                {
                  "emi_id": 143834,
                  "repayment_amount": 17.0,
                  "due_amount": 136.0,
                  "repayment_date": "2023-06-19",
                  "collection_date": null,
                  "collection_amount": 0.0,
                  "status": "UNPAID",
                  "created_at": "2023-05-24T11:08:38.559446"
                },
                {
                  "emi_id": 143835,
                  "repayment_amount": 17.0,
                  "due_amount": 17.0,
                  "repayment_date": "2023-07-19",
                  "collection_date": null,
                  "collection_amount": 0.0,
                  "status": "UNPAID",
                  "created_at": "2023-05-24T11:08:38.559499"
                },
                {
                  "emi_id": 143836,
                  "repayment_amount": 17.0,
                  "due_amount": 17.0,
                  "repayment_date": "2023-08-19",
                  "collection_date": null,
                  "collection_amount": 0.0,
                  "status": "UNPAID",
                  "created_at": "2023-05-24T11:08:38.559538"
                },
                {
                  "emi_id": 143837,
                  "repayment_amount": 17.0,
                  "due_amount": 17.0,
                  "repayment_date": "2023-09-19",
                  "collection_date": null,
                  "collection_amount": 0.0,
                  "status": "UNPAID",
                  "created_at": "2023-05-24T11:08:38.559576"
                },
                {
                  "emi_id": 143838,
                  "repayment_amount": 17.0,
                  "due_amount": 17.0,
                  "repayment_date": "2023-10-19",
                  "collection_date": null,
                  "collection_amount": 0.0,
                  "status": "UNPAID",
                  "created_at": "2023-05-24T11:08:38.559613"
                }
              ],
              "fee_at_that_time": {
                "id": 1585438,
                "current_processing_fee": 8.0,
                "current_credit_limit": 100.0,
                "current_roi": "0.00",
                "current_late_fee": 118.0,
                "account_number": "50100453064134",
                "ifsc_code": "HDFC0001734",
                "noc_sent": false,
                "loan": 1584560,
                "current_user_level": 2
              }
            }
          ],
          "message": "success"
        };
      } else {
        print("calling Live");
        response = await _apiServices.getPostApiResponse(
            '${AppUrl.getKYCVerificationStatus}${userId.toString()}&type=loan_details_get',
            []);
      }

      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
