import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productbox_flutter_exercise/Model/user_model.dart';
import 'package:productbox_flutter_exercise/Repository/user_repository.dart';
import 'package:productbox_flutter_exercise/blocs/user_bloc/user_event.dart';
import 'package:productbox_flutter_exercise/blocs/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository repository = UserRepository();

  UserBloc(UserState initialState) : super(initialState) {
    on<FetchUserEvent>((event, emit) async {
      emit(UserLoadingState());

      List<User> users = await repository.getAllUserFromApi();

      print('blocc userrrs ${users.length}');

      final filterUser = users.where((element) =>
          element.username!.toLowerCase() == event.username &&
          element.email!.toLowerCase() == event.email.toLowerCase());

      if (filterUser.length > 0)
        emit(UserSuccessState(
            message: '${filterUser.length} User Successfully Fetched'));
      else
        emit(UserFailureState(message: 'No User Found'));
      // TODO: implement event handler
    });
  }
}
