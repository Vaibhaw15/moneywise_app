


import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{}

class LoginFailure extends LoginState{
  final String errorMessage;

  LoginFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}