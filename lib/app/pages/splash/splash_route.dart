import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:fwc_album_app/app/pages/splash/presenter/splash_presenter.dart';
import 'package:fwc_album_app/app/pages/splash/presenter/splash_presenter_impl.dart';
import 'package:fwc_album_app/app/pages/splash/splash_page.dart';

class SplashRoute extends FlutterGetItPageRoute {
  const SplashRoute({super.key});

  @override //sobrescreve o bind
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<SplashPresenter>((i) => SplashPresenterImpl()),
      ]; //adiciona no getit a dependencia

  @override
  WidgetBuilder get page =>
      (context) => SplashPage(presenter: context.get()); // => Build Context

}
