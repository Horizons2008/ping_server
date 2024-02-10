import 'package:check_server/code/services/local_notification.dart';
import 'package:check_server/controller/model/result.dart';
import 'package:check_server/dio/dioException.dart';
import 'package:check_server/dio/intercepteur.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CtrlHome extends GetxController {
  String url = "https:\\www.google.fr";
  late Dio dio;
  int delai = 10;
  int timeOut = 5000;
  List<Resultat> list = [];

  int counter = 0;
  final startTime = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dio = Dio();
    dio.interceptors.add(CustomInterceptor());
  }

  Future fetchData() async {
    Resultat item = Resultat(id: -1, status: "", date: "", delai: 0, url: '');
    try {
      counter++;
      item.id = counter;
      item.url = url;
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:SS');
      item.date = formatter.format(DateTime.now());

      // Replace the URL with your API endpoint
      final response = await dio.get(url);

      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      print('API call duration: ${duration.inMilliseconds} milliseconds');
      item.delai = endTime.difference(startTime).inMilliseconds;
      item.status = "1";
      list.add(item);
      update();

      return response.data;
    } on DioError catch (e) {
      debugPrint("erreur diooo  ${DioExceptions.fromDioError(e).message}");
      final endTime = DateTime.now();

      item.delai = endTime.difference(startTime).inMilliseconds;
      item.status = "0";
      list.add(item);
      update();

      NotificationServices()
          .showNotification(title: "Alert", body: "Server broken", payload: "");

      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
}
