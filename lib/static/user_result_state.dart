import 'package:capstone/data/model/user_response.dart';

sealed class UserResultState {}

class UserNoneState extends UserResultState {}

class UserLoadingState extends UserResultState {}

class UserErrorState extends UserResultState {
  final String error;

  UserErrorState(this.error);
}

class UserLoadedState extends UserResultState {
  final User data;

  UserLoadedState(this.data);
}