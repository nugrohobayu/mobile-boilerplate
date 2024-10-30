import 'package:flutter/material.dart';
import 'package:mobile_boilerplate/data/base_api/base_api.dart';
import 'package:mobile_boilerplate/features/auth/login/models/request_login.dart';
import 'package:mobile_boilerplate/features/auth/login/models/response_login.dart';

class AuthServices extends BaseApi {
  Future<ResponseLogin?> login(
    BuildContext context, {
    String path = '/auth/login',
    required RequestLogin payload,
  }) async {
    final res = await post(
      context,
      path,
      payload.toJson(),
      token: false,
    );
    if (res != null) {
      ResponseLogin result = ResponseLogin.fromJson(res);
      return result;
    }
    return null;
  }
}
