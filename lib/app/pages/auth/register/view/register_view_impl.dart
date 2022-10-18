import 'package:flutter/widgets.dart';
import 'package:fwc_album_app/app/core/ui/helpers/loader.dart';
import 'package:fwc_album_app/app/core/ui/helpers/messages.dart';
import 'package:fwc_album_app/app/pages/auth/register/register_page.dart';

import './register_view.dart';

abstract class RegisterViewImpl extends State<RegisterPage> 
  with Messages<RegisterPage>, Loader<RegisterPage>
  implements RegisterView {
    
    @override
  void initState() {
    widget.presenter.view = this; //link entre a presenter e a view
    super.initState();
  }

  @override
  void registerError([String? message]) {
    hideLoader(); //esconder o loader do cadastro
    showError(message ?? 'Erro ao registrar usuario'); //se a presenter enviar a mensagem exibe ela, senão o texto fixo
  }

  @override
  void registerSuccess() {
    hideLoader(); //esconder o loader do cadastro
    showSucess('Usuario cadastrado com sucesso!'); 
    Navigator.of(context).pop();
  }

}