import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService{
  final String _url = 'http://192.168.43.12:8000/api';

  var token;

  _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    token = jsonDecode(prefs.getString('token') ?? '');
  }

  auth(data, apiURL) async{
    var fullUrl = Uri.parse(_url + apiURL);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  getData(apiURL) async{
    var fullUrl = Uri.parse(_url + apiURL);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  postData(data, apiURL) async{
    var fullUrl = Uri.parse(_url + apiURL);
    await _getToken();
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}