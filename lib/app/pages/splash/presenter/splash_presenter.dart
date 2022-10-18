import '../../../core/mvp/fwc_presenter.dart';

abstract class SplashPresenter extends FwcPresenter{ //quando clicar em login chama esse presenter

  Future<void> checkLogin();

}