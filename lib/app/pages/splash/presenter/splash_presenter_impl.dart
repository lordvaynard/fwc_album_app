import 'package:fwc_album_app/app/pages/splash/view/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './splash_presenter.dart';

class SplashPresenterImpl implements SplashPresenter {
  late final SplashView _view; //Guardando a view

  @override
  Future<void> checkLogin() async {
    _view.showLoader();

    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');

    _view.logged(accessToken != null); //condicional, se diferente de null é true, se é igual a null é false
  }

  @override
  set view(view) =>
      _view = view; //recebe o seter e é associado a tela e o presenter

}
