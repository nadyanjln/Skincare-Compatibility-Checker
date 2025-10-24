import 'package:capstone/data/model/user_response.dart';

sealed class LoginResultState {}

class LoginNoneState extends LoginResultState {}

class LoginLoadingState extends LoginResultState {}

class LoginErrorState extends LoginResultState {
  final String error;

  LoginErrorState(this.error);
}

class LoginLoadedState extends LoginResultState {
  final UserResponse data;

  LoginLoadedState(this.data);
}