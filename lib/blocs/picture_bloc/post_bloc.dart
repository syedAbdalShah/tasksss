import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productbox_flutter_exercise/Model/picture_model.dart';
import 'package:productbox_flutter_exercise/Repository/pictures_repository.dart';
import 'package:productbox_flutter_exercise/blocs/picture_bloc/post_event.dart';
import 'package:productbox_flutter_exercise/blocs/picture_bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PictureRepository repository = PictureRepository();

  PostBloc(InitialPictureState initialPictureState)
      : super(initialPictureState) {
    on<GetAllPicturesEvent>((event, emit) async {
      emit(LoadingPictureState());

      try {
        List<PostModel> posts = await repository.getAllPosts();
        emit(FetcedPictureState(allPost: posts));
      } catch (error) {
        emit(FailurPictureState(errorMessage: error.toString()));
      }
      // TODO: implement event handler
    });
  }
}
