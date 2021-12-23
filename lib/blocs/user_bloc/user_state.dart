import 'package:productbox_flutter_exercise/constants/strings.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  String message;
  UserSuccessState({required this.message});
}

class UserFailureState extends UserState {
  String message;
  UserFailureState({required this.message});
}
