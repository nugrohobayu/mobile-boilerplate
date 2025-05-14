import 'package:flutter/material.dart';
import 'package:mobile_boilerplate/application/constant/iconstant.dart';
import 'package:mobile_boilerplate/application/helper/shared_pref.dart';
import 'package:mobile_boilerplate/data/repositories/auth_service.dart';
import 'package:mobile_boilerplate/features/auth/login/models/request_login.dart';
import 'package:mobile_boilerplate/features/auth/login/models/response_login.dart';

class LoginViewModel extends ChangeNotifier {
  final service = AuthServices();

  Future<ResponseLogin?> login(BuildContext context, RequestLogin payload) async {
    final result = await service.login(context, payload: payload);
    if (result != null) {
      await SharedPref.setValue(IConstant.localStorageToken, result.accessToken);
      return result;
    }
    return null;
  }
}
