import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:dw_barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, errorMessage: final errorMessage?):
          Messages.showError(message: errorMessage, context: context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError(message: 'Erro ao realizar login', context: context);
        case LoginState(status: LoginStateStatus.admLogin):
        //ir pra página do adm
        case LoginState(status: LoginStateStatus.employeeLogin):
        //ir pra outra página do user padrao
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(ImageConstants.backgroundChair), fit: BoxFit.cover, opacity: 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstants.imageLogo),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: emailEC,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ],
                            ),
                            onTapOutside: (_) => unfocus(context),
                            decoration: const InputDecoration(
                              label: Text(
                                'E-mail',
                              ),
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6, 'Senha deve conter pelo menos 6 Caracteres')
                            ]),
                            onTapOutside: (_) => unfocus(context),
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text(
                                'Senha',
                              ),
                              hintText: 'Senha',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(color: ColorsConstants.brow),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                            onPressed: () async {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(message: 'Campos inválidos', context: context);
                                case true:
                                  await login(emailEC.text, passwordEC.text);
                              }
                            },
                            child: const Text('ACESSAR'),
                          )
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar conta',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
