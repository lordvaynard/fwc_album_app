import 'package:fwc_album_app/app/models/user_sticker_model.dart';
import 'package:fwc_album_app/app/pages/sticker_detail/view/sticker_detail_view.dart';
import 'package:fwc_album_app/app/repository/stickers/stickers_repository.dart';
import 'package:fwc_album_app/app/services/sticker/find_sticker_service.dart';

import '../../../models/sticker_model.dart';
import './sticker_detail_presenter.dart';

class StickerDetailPresenterImpl implements StickerDetailPresenter {
  late final StickerDetailView _view;
  final FindStickerService findStickerService;
  final StickersRepository stickersRepository;
  UserStickerModel?
      stickerUser; //figurinha que o usuario possui, com os dados dele
  StickerModel? sticker; //figurinha generica, caso o usuario não possua
  int amount = 0;

  StickerDetailPresenterImpl(
      {required this.findStickerService, required this.stickersRepository});

  @override
  set view(StickerDetailView view) => _view = view;

  @override
  Future<void> load({
    required String countryCode,
    required String stickerNumber,
    required String countryName,
    UserStickerModel? stickerUser,
  }) async {
    this.stickerUser = stickerUser;
    if (stickerUser == null) {
      //usuario não possui a figurinha
      sticker = await findStickerService.execute(countryCode, stickerNumber);
    }

    bool hasSticker = stickerUser != null;

    if (hasSticker) {
      amount = stickerUser.duplicate + 1;
    }

    _view.screenLoaded(
        hasSticker, countryCode, stickerNumber, countryName, amount);
  }

  @override
  void decrementAmout() {
    if (amount > 1) {
      _view.updateAmount(--amount);
    }
  }

  @override
  void incrementAmount() {
    _view.updateAmount(++amount);
  }

  @override
  Future<void> saveSticker() async {
    try {
      _view.showLoader();
      if (stickerUser == null) {
        //registrar
        await stickersRepository.registerUserSticker(
            sticker!.id, amount); //com o ! se não existe vai dar erro
      } else {
        //atualizar
        await stickersRepository.updateUserSticker(stickerUser!.idSticker,
            amount); //com o ! se não existe vai dar erro
      }
      _view.saveSuccess();
    } catch (e) {
      _view.error('Erro ao cadastrar ou atualizar figurinha');
    }
  }

  @override
  Future<void> deleteSticker() async {
    _view.showLoader();
    if (stickerUser != null) {
      await stickersRepository.updateUserSticker(stickerUser!.idSticker, 0);
    }
    _view.saveSuccess();
  }
}
