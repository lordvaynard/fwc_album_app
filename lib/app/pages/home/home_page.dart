import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/home/presenter/home_presenter.dart';
import 'package:fwc_album_app/app/pages/home/view/home_view_impl.dart';
import 'package:fwc_album_app/app/pages/home/widgets/status_tile.dart';
import 'package:fwc_album_app/app/pages/home/widgets/sticker_percent_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({super.key, required this.presenter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeViewImpl {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.colors.primary,
        //title: const Text('Home Page'),
        actions: [
          IconButton(
              //Botão logout
              onPressed: () => widget.presenter.Logout(),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: LayoutBuilder(
          //da extensão flutter layout utilities
          builder: (_, constrains) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constrains
                      .maxHeight), //tamanho da constraint é o tamanho maximo do layout builder (altura)
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 35),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/images/bola.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      StickerPercentWidget(
                        percent: user?.totalCompletePercent ?? 0, //Se não é nulo passa o percentual se nulo passa 0
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${user?.totalStickers ?? 0} figurinhas',//Se não é nulo passa o total se nulo passa 0
                        style: context.textStyles.titleWhite,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StatusTile(
                        icon: Image.asset('assets/images/all_icon.png'),
                        label: 'Todas',
                        value: user?.totalAlbum ?? 0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StatusTile(
                        icon: Image.asset('assets/images/missing_icon.png'),
                        label: 'Faltando',
                        value: user?.totalComplete ?? 0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StatusTile(
                        icon: Image.asset('assets/images/repeated_icon.png'),
                        label: 'Repetidas',
                        value: user?.totalDuplicates ?? 0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/my_stickers');
                        },
                        width: MediaQuery.of(context).size.width * 0.9,
                        outline: true,
                        style: context.buttonStyles.yellowOutlineButton,
                        labelStyle: context
                            .textStyles.textSecondaryFontExtraBold
                            .copyWith(color: context.colors.yellow),
                        label: 'Minhas Figurinhas',
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
