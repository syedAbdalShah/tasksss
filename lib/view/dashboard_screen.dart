import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productbox_flutter_exercise/Model/picture_model.dart';
import 'package:productbox_flutter_exercise/Repository/pictures_repository.dart';
import 'package:productbox_flutter_exercise/blocs/picture_bloc/post_bloc.dart';
import 'package:productbox_flutter_exercise/blocs/picture_bloc/post_event.dart';
import 'package:productbox_flutter_exercise/blocs/picture_bloc/post_state.dart';
import 'package:productbox_flutter_exercise/constants/theme_data.dart';
import 'package:productbox_flutter_exercise/ui_componenet/Alerts.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PostBloc bloc = PostBloc(InitialPictureState());

  @override
  void initState() {
    bloc.add(GetAllPicturesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer(
            bloc: bloc,
            builder: (contex, state) {
              if (state is LoadingPictureState) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is FailurPictureState) {
                Alerts.showMessage(context, state.errorMessage!, () {
                  Navigator.of(context).pop();
                });
              }
              if (state is FetcedPictureState) {
                return buildBody(size, state.allPost);
              }
              return CupertinoActivityIndicator();
            },
            listener: (context, state) {
              print(state);
            }),
      ),
    );
  }

  Column buildBody(Size size, List<PostModel> posts) {
    return Column(
      children: [
        Container(
          height: size.height * 0.15,
          child: ListView.builder(
              itemCount: posts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                PostModel post = posts[index];
                return storyWidget(size, post);
              }),
        ),
        Expanded(
          child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              primary: true,
              itemCount: posts.length,
              itemBuilder: (_, index) {
                PostModel post = posts[index];

                return Container(
                  child: Column(
                    children: [
                      profilePicAndName(size, post),
                      feeds(size, post)
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Container feeds(Size size, PostModel post) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(post.downloadUrl!), fit: BoxFit.cover),
        color: Colors.grey,
      ),
    );
  }

  Row profilePicAndName(Size size, PostModel post) {
    return Row(
      children: [
        Container(
          width: size.width * 0.13,
          height: size.height * 0.1,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(post.downloadUrl!), fit: BoxFit.cover),
              color: Colors.grey,
              shape: BoxShape.circle),
        ),
        Text(
          'john doe',
          style: TextStyle(fontWeight: FontWeight.w900),
        )
      ],
    );
  }

  Row storyWidget(Size size, PostModel post) {
    return Row(
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.1,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(post.downloadUrl!)),
              border: Border.all(
                  color: MyThemeData.themeData.primaryColorDark, width: 3),
              color: Colors.grey,
              shape: BoxShape.circle),
        ),
      ],
    );
  }
}
