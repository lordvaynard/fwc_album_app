import 'package:fwc_album_app/app/core/mvp/fwc_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/register/view/register_view.dart';

abstract class RegisterPresenter extends FwcPresenter<RegisterView> {
  Future<void> register({
    //Future por ser assincrono com back end
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
