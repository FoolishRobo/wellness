import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellness/utils.dart';

class ApiWrapper {
  String checkError(http.Response response, BuildContext context) {
    if (response.statusCode == 200) {
      return response.body;
    } else {
      showToast(context, "Something went wrong! Please try again later");
      return null;
    }
  }
}
