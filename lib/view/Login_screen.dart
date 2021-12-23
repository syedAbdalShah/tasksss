import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productbox_flutter_exercise/Repository/user_repository.dart';
import 'package:productbox_flutter_exercise/blocs/user_bloc/user_bloc.dart';
import 'package:productbox_flutter_exercise/blocs/user_bloc/user_event.dart';
import 'package:productbox_flutter_exercise/blocs/user_bloc/user_state.dart';
import 'package:productbox_flutter_exercise/constants/custom_textfield.dart';
import 'package:productbox_flutter_exercise/constants/myButton.dart';
import 'package:productbox_flutter_exercise/constants/strings.dart';
import 'package:productbox_flutter_exercise/constants/theme_data.dart';
import 'package:productbox_flutter_exercise/ui_componenet/Alerts.dart';
import 'package:productbox_flutter_exercise/view/document_upload_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  late UserBloc _bloc;

  @override
  void initState() {
    _bloc = UserBloc(UserInitialState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        backgroundColor: MyThemeData.themeData.backgroundColor,
        body: BlocConsumer(
          bloc: _bloc,
          builder: (context, state) {
            return buildBody(size);
          },
          listener: (context, state) {
            print(state);
            if (state is UserFailureState) {
              Alerts.showMessage(
                context,
                state.message,
                () {
                  Navigator.of(context).pop();
                },
              );
            }
            if (state is UserSuccessState) {
              Alerts.showMessage(
                context,
                state.message,
                () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DocumentUploadedScreen()));
                },
              );
            }
          },
        ),
      ),
    );
  }

  Column buildBody(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildText(
          text: 'Log In',
        ),
        verticalGap(size, 0.04),
        CustomTextField(
          hint: Strings.userName,
          controller: usernameController,
        ),
        verticalGap(size, 0.02),
        CustomTextField(
          hint: Strings.emailAddress,
          controller: emailController,
        ),
        verticalGap(size, 0.04),
        MyButton(
          widget: _bloc.state is UserLoadingState
              ? CupertinoActivityIndicator()
              : buildText(text: 'Login', fontSize: 18.sp),
          onTap: () {
            _bloc.add(FetchUserEvent(
                email: emailController.text,
                username: usernameController.text));
          },
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            Strings.forgetPassword,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        verticalGap(size, 0.02),
        buildText(text: Strings.registerHere, fontSize: 22.sp)
      ],
    );
  }

  Text buildText({required String text, double? fontSize}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize == null ? 32.sp : fontSize),
    );
  }

  SizedBox verticalGap(Size size, double customSize) {
    return SizedBox(height: size.height * customSize);
  }
}
