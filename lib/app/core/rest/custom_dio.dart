import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:fwc_album_app/app/core/rest/interceptors/auth_interceptor.dart';

import '../config/env/env.dart';

class CustomDio extends DioForNative {
  //native por ser mobile browser se fosse web

  final _authInterceptor = AuthInterceptor();

  CustomDio() //singleton unica instancia
      : super(BaseOptions(
          baseUrl: Env.i['backend_base_url'] ??
              '', //deve aceitar null caso não encontre a chave
          connectTimeout: 5000, //5 segundos de espera pro back end
          receiveTimeout: 60000, //60 segundos espera da resposta do back end
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    )); //construtor interceptor de log do Dio
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    // interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   requestHeader: true,
    // ));     
    return this;
  }

  CustomDio unAuth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
