import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/models/groups_stickers.dart';
import 'package:fwc_album_app/app/models/user_sticker_model.dart';
import 'package:fwc_album_app/app/pages/my_stickers/presenter/my_stickers_presenter.dart';

class StickerGroup extends StatelessWidget {
  final GroupsStickers group;
  final String statusFilter;
  const StickerGroup(
      {super.key, required this.group, required this.statusFilter});

  @override
  Widget build(BuildContext context) {
    //print('build $hashCode'); //teste de hash da build
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //inicar centralizado
        children: [
          SizedBox(
            height: 64,
            child: OverflowBox(
              //ignora o overflow e as constraints de tela
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: ClipRect(
                //permite desenhar na tela
                child: Align(
                  //realiza o fator de altura e largura

                  alignment: const Alignment(0, -0.1),
                  widthFactor: 1,
                  heightFactor: 0.1,
                  child: Image.network(
                    group.flag,
                    cacheWidth: (MediaQuery.of(context).size.width * 3).toInt(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              group.countryName,
              style: context.textStyles.titleBlack.copyWith(fontSize: 26),
            ),
          ),
          GridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), //remover scroll do grid e mantem do sliver list
            shrinkWrap: true,
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //quantidade de colunas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final stickerNumber = '${group.stickersStart + index}';
              final stickerList = group.stickers
                  .where((sticker) => sticker.stickerNumber == stickerNumber);
              final sticker = stickerList.isNotEmpty ? stickerList.first : null;
              final countryName = group.countryName;
              final countryCode = group.countryCode;

              final stickerWidget = Sticker(
                stickerNumber: stickerNumber,
                sticker: sticker,
                countryName: group.countryName,
                countryCode: group.countryCode,
              );

              if (statusFilter == 'all') {
                return stickerWidget;
              } else if (statusFilter == 'missing') {
                if (sticker == null) {
                  return stickerWidget;
                }
              } else if (statusFilter == 'repeatef') {
                if (sticker != null && sticker.duplicate > 0) {
                  return stickerWidget;
                }
              }

              return SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}

class Sticker extends StatelessWidget {
  final String stickerNumber;
  final UserStickerModel? sticker;
  final String countryName;
  final String countryCode;
  const Sticker({
    super.key,
    required this.stickerNumber,
    required this.sticker,
    required this.countryName,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final presenter = context.get<MyStickersPresenter>();
        await Navigator.of(context).pushNamed('/sticker_detail', arguments: {
          'countryCode': countryCode,
          'countryName': countryName,
          'stickerNumber': stickerNumber,
          'stickerUser': sticker,
        });
        presenter.refresh();
      },
      child: Container(
        color: sticker != null ? context.colors.primary : context.colors.grey,
        child: Column(
          children: [
            //Text('${sticker?.duplicate}'), debug da quantidade de duplicadas
            Visibility(
              visible: (sticker?.duplicate ?? 0) >
                  0, //se maior que zero true, senão false (numero da quantidade de figurinhas)
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(2),
                child: Text(
                  sticker?.duplicate.toString() ?? '',
                  style: context.textStyles.textSecondaryFontMedium.copyWith(
                    color: context.colors.yellow,
                  ),
                ),
              ),
            ),
            Text(
              countryCode,
              style: context.textStyles.textPrimaryFontExtraBold.copyWith(
                  color: sticker != null ? Colors.white : Colors.black),
            ),
            Text(
              stickerNumber,
              style: context.textStyles.textPrimaryFontExtraBold.copyWith(
                  color: sticker != null ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
