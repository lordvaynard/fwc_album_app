import 'package:flutter/widgets.dart';
import 'package:fwc_album_app/app/pages/splash/splash_page.dart';

import '../../../core/ui/helpers/loader.dart';
import './splash_view.dart';
//interface implementada da splash view via alt enter
abstract class SplashViewImpl extends State<SplashPage> 
  with Loader<SplashPage> //Mixin não precisar implementar o showLoader
  implements SplashView { //abstrata pois alguem vai extender ela

  @override
  void initState() {
    widget.presenter.view = this; //ligação da view com o presenter
    super.initState();
  }

  @override
  void logged(bool isLogged) {
    hideLoader();
    if(isLogged){
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }else{
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/auth/login', (route) => false);
    }
  }


}