import 'dart:convert';

import 'package:productbox_flutter_exercise/Model/picture_model.dart';
import 'package:productbox_flutter_exercise/constants/strings.dart';
import 'package:http/http.dart' as http;

class PictureRepository {
  String url = '${Strings.postbaseUrl}list';

  Future<List<PostModel>> getAllPosts() async {
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body) as List;

    final allPosts = body.map((e) => PostModel.fromJson(e)).toList();

    print(allPosts);

    return allPosts;
  }
}
