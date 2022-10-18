import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/my_stickers/presenter/my_stickers_presenter.dart';

class StickerStatusFilter extends StatelessWidget {
  final String filterSelected;

  const StickerStatusFilter({super.key, required this.filterSelected});

  @override
  Widget build(BuildContext context) {
    final presenter = context.get<MyStickersPresenter>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Wrap(spacing: 5, alignment: WrapAlignment.center, children: [
        //quebra automaticamente os objetos na tela
        Button(
          onPressed: () {
            presenter.statusFilter('all');
          },
          width: MediaQuery.of(context).size.width * .3,
          style: filterSelected == 'all'
              ? context.buttonStyles.yellowButton
              : context.buttonStyles.primaryButton,
          labelStyle: 
              filterSelected == 'all'
              ? context.textStyles.textSecondaryFontMedium.copyWith(color: context.colors.primary)
              : context.textStyles.textSecondaryFontMedium,
          label: 'Todas',
        ),
        Button(
          onPressed: () {
            presenter.statusFilter('missing');
          },
          width: MediaQuery.of(context).size.width * .3,
          style: filterSelected == 'missing'
              ? context.buttonStyles.yellowButton
              : context.buttonStyles.primaryButton,
          labelStyle: 
              filterSelected == 'missing'
              ? context.textStyles.textSecondaryFontMedium.copyWith(color: context.colors.primary)
              : context.textStyles.textSecondaryFontMedium,
          label: 'Faltando',
        ),
        Button(
          onPressed: () {
            presenter.statusFilter('repeated');
          },
          width: MediaQuery.of(context).size.width * .3,
          style: filterSelected == 'repeated'
              ? context.buttonStyles.yellowButton
              : context.buttonStyles.primaryButton,
          labelStyle: 
              filterSelected == 'repeated'
              ? context.textStyles.textSecondaryFontMedium.copyWith(color: context.colors.primary)
              : context.textStyles.textSecondaryFontMedium,
          label: 'Repetidas',
        ),
      ]),
    );
  }
}
