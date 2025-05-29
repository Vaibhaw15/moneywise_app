import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../networking/registerApi.dart';
import '../event/signup_screen_event.dart';
import '../state/register_screen_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    if (event.name.isEmpty || event.email.isEmpty || event.password.isEmpty) {
      emit(RegisterFailure(error: "All fields are required"));
      return;
    }

    emit(RegisterLoading()); // emit loading state

    try {
      final success = await RegisterApi().registerWithEmail(event.email,event.password,event.name );

      if (success.statusCode == 201){
        emit(RegisterSuccess(message:success.data));
      } else if(success.statusCode == 409){
        emit(RegisterFailure(error:success.data));
      }  else {
        emit(RegisterFailure(error: "Invalid username or password"));
      }
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}