
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneywise/networking/loginApi.dart';
import 'package:moneywise/screens/logIn/event/lognInEvent.dart';
import 'package:moneywise/screens/logIn/state/LogInState.dart';

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
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errorMessage: "Invalid username or password"));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}