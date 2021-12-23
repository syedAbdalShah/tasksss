import 'package:flutter/cupertino.dart';

abstract class UserEvent {}

class FetchUserEvent extends UserEvent {
  String username;
  String email;
  FetchUserEvent({required this.email, required this.username});
}
