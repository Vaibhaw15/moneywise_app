


import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent{
  final String userName;
  final String password;

  LoginButtonPressed({required this.userName,required this.password});

  @override
  List<Object?> get props => [userName,password];
}