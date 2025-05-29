
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moneywise/networking/loginApi.dart';
import 'package:moneywise/screens/logIn/event/lognInEvent.dart';
import 'package:moneywise/screens/logIn/state/LogInState.dart';

import '../../../packages/SharedPreferenceService.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {


  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading()); // emit loading state

    try {
      final success = await LogInApi().login(event.userName, event.password);

      if (success.statusCode == 200){
        SharedPreferenceService.setString("token", success.data['token']);
        SharedPreferenceService.setString("userId", success.data['userId']);
        SharedPreferenceService.setString("userName", success.data['userName']);
        SharedPreferenceService.setString("userEmail", success.data['token']);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errorMessage: "Invalid username or password"));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}