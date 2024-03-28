import 'package:flutter/widgets.dart';

enum LoginStateStatus { inital, error, admLogin, employeeLogin }

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.inital() : this(status: LoginStateStatus.inital);

  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
