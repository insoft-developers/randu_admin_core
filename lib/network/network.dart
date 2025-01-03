import 'dart:convert';

import 'package:buzz/utils/contstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Network {
  // final String _url = Constant.BASE_URL + 'public/api';
  final String _url = Constant.BASE_URL + 'api/v2';

  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!);
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  post(data, apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
