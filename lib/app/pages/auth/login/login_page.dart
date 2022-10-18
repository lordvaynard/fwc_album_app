import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/auth/login/presenter/login_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view_impl.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({super.key, required this.presenter});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginViewImpl {
  final formKey = GlobalKey<FormState>(); //fu-form-key
  final emailEC = TextEditingController(); //fu-text-editiong-controller
  final passwordEC = TextEditingController(); //Cria os recursos

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose(); //Libera os recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: const Text('Login'),), //não tem appBar
      backgroundColor: context.colors.primary,
      body: Form(
          key: formKey, //chave para fazer a validação do formulario
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_login.png'),
                  fit: BoxFit.cover),
            ),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          (MediaQuery.of(context).size.width > 350
                              ? .30
                              : .25 //se a largura maior que 350 fica em 30% da tela, se não 25%
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Center(
                        child: Text(
                          'Login',
                          style: context.textStyles.titleWhite,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: emailEC,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text('E-mail'),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordEC,
                      obscureText: true,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text('Senha'),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.min(
                            6, 'Senha deve ter pelo menos 6 caracteres'),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        'Esqueceu a senha?',
                        style: context.textStyles.textSecondaryFontMedium
                            .copyWith(
                                color: context.colors.yellow, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Button(
                      width: MediaQuery.of(context).size.width *
                          0.9, //força o botão entrar a ter 90% da tela fu-sw
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          showLoader();
                          widget.presenter.login(
                            emailEC.text,
                            passwordEC.text,
                          ); //chama o presenter e passa os campos do Form
                        }
                      },
                      style: context.buttonStyles.yellowButton,
                      labelStyle: context
                          .textStyles.textSecondaryFontExtraBoldPrimaryColor,
                      label: 'Entrar',
                    ),
                  ]),
                ),
                SliverFillRemaining(
                    //Completa a tela
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const Spacer(), //cria um espaço e joga o texto para baixo
                        Text.rich(
                          style: context.textStyles.textSecondaryFontMedium
                              .copyWith(color: Colors.white),
                          TextSpan(text: 'Não possui uma conta? ', children: [
                            TextSpan(
                              text: 'Cadastre-se',
                              style: context.textStyles.textSecondaryFontMedium
                                  .copyWith(color: context.colors.yellow),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context)
                                    .pushNamed('/auth/register'),
                            )
                          ]),
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
