import 'dart:async';

import 'package:check_server/code/commun_widgets/custom_edit.dart';
import 'package:check_server/code/services/local_notification.dart';
import 'package:check_server/controller/controller_home.dart';
import 'package:check_server/dio/dioException.dart';
import 'package:check_server/dio/intercepteur.dart';
import 'package:check_server/variables.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().initService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Dio dio;
  String url = 'https://jsonplaceholder558.typicode.com/todos/1';
  TextEditingController contUrl = TextEditingController();
  TextEditingController contTimeOut = TextEditingController();
  String newUrl = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CtrlHome ctrlHome = Get.put(CtrlHome());
    Timer.periodic(Duration(seconds: ctrlHome.delai), (timer) {
      ctrlHome.fetchData();
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: Text(
          'check Server Status',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (BuildContext context) {
                      return GetBuilder<CtrlHome>(builder: (vall) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(15),
                          height: 600,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Url"),
                              CustomEdit(
                                hint: "Your url",
                                tEC: contUrl,
                                onchange: (vv) {
                                  newUrl = vv;
                                },
                              ),
                              const Text("Delai "),
                              CustomEdit(
                                hint: "Delai ",
                                tEC: contUrl,
                                keyboard: TextInputType.number,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                 
                                    //   timeOut = int.parse(contTimeOut.text);
                                    newUrl = "https:\\${newUrl}";
                                    newUrl = newUrl.replaceAll(r"\", r"\\");

                                    url = newUrl;
                                    vall.url = newUrl;
                                    vall.update();
                                  },
                                  child: const Text("Appliquer",
                                      style: TextStyle()))
                            ],
                          ),
                        );
                      });
                    });
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: GetBuilder<CtrlHome>(builder: (val1) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(ctrlHome.url),
              Expanded(
                  child: ListView.builder(
                itemCount: val1.list2.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("# ${val1.list2[index].id}"),
                        Text("url: ${val1.list2[index].url}"),
                        Text("date:  ${val1.list2[index].date}"),
                        Text(
                          "status ${val1.list2[index].status}",
                          style: TextStyle(
                              color: val1.list2[index].status == "1"
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ))
            ],
          ),
        );
      }),
    );
  }
}
