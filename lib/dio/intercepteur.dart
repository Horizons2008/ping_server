import 'package:check_server/variables.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /* final box = GetStorage();
   String token = box.read('token') ?? "";

    if (token != "") {
      options.headers["Authorization"] = "Bearer $token";
    }*/

    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "application/json";
    options.sendTimeout = timeOut;
    options.receiveTimeout = timeOut;
    print("zz ${timeOut}");

    startTime = DateTime.now();

    return super.onRequest(options, handler);
  }

  /* @override
  Response onResponse(Response response, ResponseInterceptorHandler handler) {
    print("onResponse");
    endTime = DateTime.now();
    Duration delay = endTime.difference(startTime);
    print("Temps de reponse : ${delay.inMilliseconds}");
    return response;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response!.statusCode == 401) {
      CommFunc.closeSession();
      print("xyz xyz: ${err.response!.statusCode}");
    }
    return handler.next(err); // <--- THE TIP IS HERE
  }*/
}
