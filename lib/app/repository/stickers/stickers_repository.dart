import 'package:fwc_album_app/app/models/groups_stickers.dart';

import '../../models/register_sticker_model.dart';
import '../../models/sticker_model.dart';

abstract class StickersRepository {
  Future<List<GroupsStickers>> getMyAlbum();
  Future<StickerModel?> FindStickerByCode(
      String strickerCode, String strickerNumber);
  Future<StickerModel> create(RegisterStickerModel registerStickerModel);

  Future<void> registerUserSticker(int stickerId, int amount);
  Future<void> updateUserSticker(int stickerId, int amount);
}
