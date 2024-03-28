import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
import 'package:barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(
      loginVmProvider,
      (_, state) {
        switch (state) {
          case LoginState(status: LoginStateStatus.inital):
            break;
          case LoginState(status: LoginStateStatus.error, :final errorMessage?):
            Messages.showError(errorMessage, context);
          case LoginState(
              status: LoginStateStatus.error,
            ):
            Messages.showError('Erro ao realizar login', context);
          case LoginState(status: LoginStateStatus.admLogin):
            break;
          case LoginState(status: LoginStateStatus.employeeLogin):
            break;
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstants.backgroundChair,
              ),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
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
                          Image.asset(
                            ImageConstants.imgLogo,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _emailEC,
                            onTapOutside: (_) => unfocus(context),
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            decoration: const InputDecoration(
                              label: Text(
                                'E-mail',
                              ),
                              hintText: 'E-mail',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _passwordEC,
                            onTapOutside: (_) => unfocus(context),
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                            decoration: const InputDecoration(
                              label: Text(
                                'Senha',
                              ),
                              hintText: 'Senha',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorsConstants.brow,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              switch (_formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                      'Campos inválidos', context);
                                case true:
                                  login(_emailEC.text, _passwordEC.text);
                              }
                            },
                            child: const Text(
                              'ACESSAR',
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
