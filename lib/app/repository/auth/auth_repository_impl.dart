import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fwc_album_app/app/core/exceptions/repository_exception.dart';
import 'package:fwc_album_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/models/register_user_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio}); //recebe e ja envia para o atributo

  @override
  Future<String> login(
      {required String email, required String password}) async {
    try {
      //sempre colocar try catch em chamadas de serviço
      final result = await dio.post('/api/auth', data: {
        'email': email,
        'password': password,
      });

      final accessToken = result.data['access_token'];

      if (accessToken == null) {
        throw UnauthorizedException();
      }

      return accessToken;
    } on DioError catch (e, s) {
      log('Erro ao relalizar login', error: e, stackTrace: s);

      if (e.response?.statusCode == 4001) {
        throw UnauthorizedException();
      }

      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(RegisterUserModel registerModel) async {
    try {
      await dio.unAuth().post(
            '/api/register',
            data: registerModel.toMap(),
          );
    } on DioError catch (e, s) {
      log('Erro ao registrar usuario',
          error: e, stackTrace: s); //log do dart develop
      throw RepositoryException(message: 'Erro ao registrar usuario');
    }
  }
}
