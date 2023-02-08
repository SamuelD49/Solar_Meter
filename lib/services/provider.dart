//@dart=2.9
import 'dart:convert';

import '/model/channal.dart';
import '/services/constants.dart';
import '/services/requests.dart';
import '/services/database.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataProvider extends ChangeNotifier {
  bool userChecked = false;
  Map<String, String> user = {TOKEN_KEY: null, REFRESH_TOKEN_KEY: null};
  final storage = new FlutterSecureStorage();
  final DatabaseHelper db = DatabaseHelper.instance;
  DataProvider() {
    initUser();
  }
  void initUser() async {
    user = {
      TOKEN_KEY: await storage.read(key: TOKEN_KEY),
      REFRESH_TOKEN_KEY: await storage.read(key: REFRESH_TOKEN_KEY)
    };
    userChecked = true;
    notifyListeners();
  }

  Future logout() async {
    await storage.delete(key: TOKEN_KEY);
    await storage.delete(key: REFRESH_TOKEN_KEY);
    initUser();
  }

  Future login({String username = "", String password = ""}) async {
    var res = await API.loginUser(username: username, password: password);
    if (res["success"]) {
      await storage.write(key: TOKEN_KEY, value: res["payload"].data["token"]);
      await storage.write(
          key: REFRESH_TOKEN_KEY, value: res["payload"].data["refreshToken"]);
      await initUser();
      return {"success": true, "payload": ""};
    } else {
      return {"success": false, "payload": res["payload"].data["message"]};
    }
  }

  Future refreshToken() async {
    final token = user[TOKEN_KEY] ?? "";
    final refreshToken = user[REFRESH_TOKEN_KEY] ?? "";
    final res =
        await API.refreshToken(token: token, refreshToken: refreshToken);
    if (res["success"]) {
      await storage.write(key: TOKEN_KEY, value: res["payload"].data["token"]);
      await storage.write(
          key: REFRESH_TOKEN_KEY, value: res["payload"].data["refreshToken"]);
      await initUser();
      return true;
    } else {
      await storage.write(key: TOKEN_KEY, value: null);
      await storage.write(key: REFRESH_TOKEN_KEY, value: null);
      await initUser();
      return false;
    }
  }

  Future getChData24({String ch = "ch1"}) async {
    await syncData(ch: ch);
    int hour24 = (DateTime.now().millisecondsSinceEpoch - 86400000).toInt();
    final res = await db.getData(ch: ch, ts: hour24);
    List<ChannalModel> result = [];
    res.forEach((d) {
      result.add(
          new ChannalModel(time: d["ts"], value: d["value"], name: d["name"]));
    });
    return result;
  }

  Future syncData({String ch = "ch1"}) async {
    int lastTs = await db.getLastTs();
    final res = await API.getChData(
        token: user[TOKEN_KEY],
        keys: ch,
        startTs: lastTs + 1,
        endTs: DateTime.now().microsecondsSinceEpoch.toInt());
    if (res["success"]) {
      if (res["payload"].data[ch] != null) {
        res["payload"].data[ch].forEach((d) async {
          await db.add(name: ch, ts: d["ts"], value: d["value"]);
        });
      }
    } else if (res["payload"].data["message"] == "Token has expired") {
      if (await refreshToken()) {
        final res2 = await API.getChData(
            token: user[TOKEN_KEY],
            keys: ch,
            startTs: lastTs + 1,
            endTs: DateTime.now().microsecondsSinceEpoch.toInt());
        if (res2["success"]) if (res2["payload"].data[ch] != null) {
          res2["payload"].data[ch].forEach((d) async {
            await db.add(name: ch, ts: d["ts"], value: d["value"]);
          });
        }
      }
    } else
      print(res["payload"]);
  }
}
