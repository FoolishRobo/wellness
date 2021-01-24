import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wellness/services/api_wrapper.dart';

class Service {
  Future<dynamic> httpGet(String url, String urlLink, var param, BuildContext context) async {
    var uri = Uri.https(url,urlLink, param);
    http.Response response = await http.get(uri);
    return ApiWrapper().checkError(response, context);
  }
}
