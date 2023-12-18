import 'package:CarePay/respository/doctorResp/newsDetailRepository.dart';
import 'package:flutter/cupertino.dart';
import '../../components/loader.dart';

class NewsDetailController with ChangeNotifier {
  final _myRepo = NewsDetailRepository();

  var _context;
  get context => _context;

  var _response = null;
  get response => _response;

  var _name = "";
  get name => _name;

  var _eachNews;
  get eachNews => _eachNews;

  getSplitTitle(title) {
    var newTitle = "";

    var tempName = title.toString().split(" ");
    for (int i = 0; i < tempName.length; i++) {
      if (i == 2) {
        break;
      }
      newTitle = newTitle.toString() + tempName[i][0].toString();
    }
    return newTitle;
  }

  getTitle() async {
    _name = "";
    notifyListeners();
    var res = await _myRepo.getNewsDetailApi();
    print(res);
    var tempName = res['data']['title'].toString().split(" ");
    print(tempName);
    print(tempName.length);
    print(tempName[0][0]);
    for (int i = 0; i < tempName.length; i++) {
      _name = name + tempName[i][0];
      notifyListeners();
    }
  }

  void initFetchData(context) async {
    Loader().fetchData(context);
    _context = context;
    print('initS');
    var res = await _myRepo.getNewsDetailApi();
    print(res);
    _response = res['data'];
    notifyListeners();
    Loader().loaderClose(context);
    // await getSplitTitle();
    // await getTitle();
  }
}
