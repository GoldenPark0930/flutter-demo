import 'dart:async';
import 'package:flutter_demo/utils/network_util.dart';
import 'package:flutter_demo/model/users.dart';

class RestDatasource {
    static final BASE_URL = "http://alphareferral.technostacks.com/api/";
    NetworkUtil _netUtil = new NetworkUtil();

    Future<dynamic> login(String username, String password) {
        final loginUrl = BASE_URL + "Users/login.json";
        return _netUtil.post(loginUrl,body: {
          "username":username,
          "password":password,
          "app_version":"1.0",
          "device_token":"43e342342342k3j423u48y23842394",
          "device_type":"iOS",
          "model_name":"iphoneX",
        }).then((dynamic res) {
            print(res.toString());
            if (res["code"] == 200) {
              return new User.map(res["Users"]);
            }
            else {
              return res["message"];
            }
        });
    }
}