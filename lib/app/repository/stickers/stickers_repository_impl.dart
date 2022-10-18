// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fwc_album_app/app/core/exceptions/repository_exception.dart';
import 'package:fwc_album_app/app/models/groups_stickers.dart';
import 'package:fwc_album_app/app/models/register_sticker_model.dart';
import 'package:fwc_album_app/app/models/sticker_model.dart';

import '../../core/rest/custom_dio.dart';
import './stickers_repository.dart';

class StickersRepositoryImpl implements StickersRepository {
  final CustomDio dio;
  StickersRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<GroupsStickers>> getMyAlbum() async {
    try {
      final result = await dio.auth().get('/api/countries');
      return result.data
          .map<GroupsStickers>((g) => GroupsStickers.fromMap(g))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar algum do usuario', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar album do usuario');
    }
  }

  @override
  Future<StickerModel?> FindStickerByCode(
      String strickerCode, String strickerNumber) async {
    try {
      final result =
          await dio.auth().get('/api/sticker-search', queryParameters: {
        'sticker_code': strickerCode,
        'sticker_number': strickerNumber,
      });

      return StickerModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 404) {
        return null; //Caso a figurinha não foi encontrada, erro 404.
      }

      log('Erro ao buscar figurinha', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar figurinha');
    }
  }

  @override
  Future<StickerModel> create(RegisterStickerModel registerStickerModel) async {
    try {
      final body = FormData.fromMap({
        ...registerStickerModel.toMap(),
        'sticker_image_upload': '',
      });
      final result = await dio.auth().post('/api/sticker', data: body);
      return StickerModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao registrar figurinha no album', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao registrar figurinha no album');
    }
  }

  @override
  Future<void> registerUserSticker(int stickerId, int amount) async {
    try {
      await dio.auth().post('/api/user/sticker', //post insere
          data: {'id_sticker': stickerId, 'amount': amount});
    } on DioError catch (e, s) {
      log('Erro ao inserir figurinha do usuario', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao inserir figurinha do usuario');
    }
  }

  @override
  Future<void> updateUserSticker(int stickerId, int amount) async { 
    try {
      await dio.auth().put('/api/user/sticker', //put atualiza
          data: {'id_sticker': stickerId, 'amount': amount});
    } on DioError catch (e, s) {
      log('Erro ao inserir figurinha do usuario', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao inserir figurinha do usuario');
    }
  }
}
