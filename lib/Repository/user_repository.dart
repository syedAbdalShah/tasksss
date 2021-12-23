import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:productbox_flutter_exercise/Model/user_model.dart';
import 'package:productbox_flutter_exercise/constants/strings.dart';

class UserRepository {
  String url = '${Strings.baseUrl}users';
  Future getAllUserFromApi() async {
    try {
      final response = await http.get(Uri.parse(url));
      final decodeResponse = json.decode(response.body) as List;

      final users = decodeResponse.map((e) => User.fromJson(e)).toList();
      print('userrrrrrrrrrrrr ${users.length}');

      return users;
    } catch (error) {
      error.toString();
    }
  }
}
