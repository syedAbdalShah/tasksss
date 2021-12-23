import 'package:productbox_flutter_exercise/Model/picture_model.dart';

abstract class PostState {}

class InitialPictureState extends PostState {}

class LoadingPictureState extends PostState {}

class FetcedPictureState extends PostState {
  List<PostModel> allPost = [];
  FetcedPictureState({required this.allPost});
}

class FailurPictureState extends PostState {
  String? errorMessage;
  FailurPictureState({this.errorMessage});
}
