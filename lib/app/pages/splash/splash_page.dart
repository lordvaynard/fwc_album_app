import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/core/ui/widgets/rounded_button.dart';
import 'package:fwc_album_app/app/pages/splash/presenter/splash_presenter.dart';
import 'package:fwc_album_app/app/pages/splash/presenter/splash_presenter_impl.dart';
import 'package:fwc_album_app/app/pages/splash/view/splash_view_impl.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/styles/button_styles.dart';

class SplashPage extends StatefulWidget {

  final SplashPresenter presenter;

  const SplashPage({super.key, required this.presenter});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends SplashViewImpl {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary, //Cor do Back Ground principal
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.png'),
            fit: BoxFit.cover
          ),
        ),
        child: Stack( //precisa ter um child para aparecer o box Decoration
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .08), //Padding para não colar no topo
                child: Image.asset(
                  'assets/images/fifa_logo.png',
                  height: MediaQuery.of(context).size.height * 0.25, //redimensiona o logo de acordo com o tamanho da tela
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.19),
                child: Button(
                  width: MediaQuery.of(context).size.width * 0.9,
                  onPressed: (){
                    widget.presenter.checkLogin();
                  },
                  style: context.buttonStyles.yellowButton,
                  labelStyle: context.textStyles.textSecondaryFontExtraBoldPrimaryColor,
                  label: 'Acessar',
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/images/bandeiras.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
