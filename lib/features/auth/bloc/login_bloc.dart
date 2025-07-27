import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
  
    on<LoginButttonPressedEvent>(_onLogin);

    on<LogoutButttonPressedEvent>(_onLogout);
  }

  Future<void> _onLogin(
    LoginButttonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginFaildState('not baild email or password '));
    } else if (!event.email.contains('@')) {
      emit(LoginFaildState('not baild email or password '));
    } else if (event.email == 'email@gamil.com' && event.password == '1234') {
      emit(LoginSuccessState());
    }
  }

  void _onLogout(LogoutButttonPressedEvent event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}
