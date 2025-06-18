import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_boilerplate/application/constant/color_palette.dart';
import 'package:mobile_boilerplate/application/constant/iconstant.dart';
import 'package:mobile_boilerplate/application/helper/shared_pref.dart';
import 'package:mobile_boilerplate/application/helper/size_config.dart';
import 'package:mobile_boilerplate/features/auth/login/views/login_view.dart';

class BaseApi {
  final String _schema = "https";
  final String _host = "dummyjson.com";
  final String _post = "post";
  final String _get = "get";
  final String _put = "put";
  final String _delete = "delete";
  static const int _timeout = 60;

  Future post(
    BuildContext context,
    String path,
    Map<String, dynamic> payload, {
    int timeout = _timeout,
    bool loading = true,
    bool token = true,
    Map<String, dynamic>? query,
    int retryConnectNum = 1,
  }) async {
    return await _fetch(
      context,
      method: _post,
      path: path,
      loading: loading,
      token: token,
      timeOut: timeout,
      reqBody: payload,
      queryParam: query,
    );
  }

  Future get(
    BuildContext context,
    String path,
    Map<String, dynamic> payload, {
    int timeout = _timeout,
    bool loading = true,
    bool token = true,
    Map<String, dynamic>? query,
    int retryConnectNum = 1,
  }) async {
    return await _fetch(
      context,
      method: _get,
      path: path,
      loading: loading,
      token: token,
      timeOut: timeout,
      reqBody: payload,
      queryParam: query,
    );
  }

  Future put(
    BuildContext context,
    String path,
    Map<String, dynamic> payload, {
    int timeout = _timeout,
    bool loading = true,
    bool token = true,
    Map<String, dynamic>? query,
    int retryConnectNum = 1,
  }) async {
    return await _fetch(
      context,
      method: _put,
      path: path,
      loading: loading,
      token: token,
      timeOut: timeout,
      reqBody: payload,
      queryParam: query,
    );
  }

  Future delete(
    BuildContext context,
    String path,
    Map<String, dynamic> payload, {
    int timeout = _timeout,
    bool loading = true,
    bool token = true,
    Map<String, dynamic>? query,
    int retryConnectNum = 1,
  }) async {
    return await _fetch(
      context,
      method: _delete,
      path: path,
      loading: loading,
      token: token,
      timeOut: timeout,
      reqBody: payload,
      queryParam: query,
    );
  }

  Future _fetch(
    BuildContext context, {
    required String path,
    required String method,
    Map<String, dynamic>? reqBody,
    Map<String, dynamic>? queryParam,
    required bool loading,
    required bool token,
    required int timeOut,
  }) async {
    bool isLoading = loading;
    bool error_ = false;

    Map<String, String> headers = {};
    headers['content-type'] = 'application/json';
    headers['accept'] = 'application/json';

    void checkLoading() {
      if (isLoading) {
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
          isLoading = false;
        }
      }
    }

    if (loading) {
      showLoading(context);
    }

    if (token) {
      String token_ = await getToken();
      if (token_.isNotEmpty) {
        String bearerToken = 'Bearer $token_';
        headers['Authorization'] = bearerToken;
      }
    }

    http.Response response;

    var url = Uri(
      scheme: _schema,
      host: _host,
      path: path,
      queryParameters: queryParam,
    );
    var start = DateTime.now().millisecondsSinceEpoch;
    var stringLog = "";
    stringLog += "[${method.toUpperCase()}] : $url";
    stringLog += "\n[Request Headers] : \n\t$headers";
    stringLog += "\n[Request Body] : \n\t$reqBody";
    if (kDebugMode) {
      log("\n:: PROCESSING :: \n$stringLog");
    }

    try {
      if (method == _post) {
        response = await http.post(url, headers: headers, body: json.encode(reqBody)).timeout(Duration(seconds: timeOut));
      } else if (method == _get) {
        response = await http.get(url, headers: headers).timeout(const Duration(seconds: _timeout));
      } else if (method == _put) {
        response = await http.put(url, headers: headers, body: json.encode(reqBody)).timeout(const Duration(seconds: _timeout));
      } else {
        response = await http.delete(url, headers: headers, body: json.encode(reqBody)).timeout(Duration(seconds: timeOut));
      }
      stringLog += "\n[Response Code] : \n\t${response.statusCode}";
      stringLog += "\n[Response Headers] : \n\t${response.headers.toString()}";
      stringLog += "\n[Response Body Raw] : \n\t${response.body.toString()}";

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final respBody = response.body;
          final respBodyDecode = json.decode(respBody);
          stringLog += "\n[Response Body Clear] : \n\t$respBodyDecode";
          return respBodyDecode;
        } else {
          error_ = true;
          checkLoading();
          final respBody = response.body;
          final respBodyDecode = json.decode(respBody)['message'];
          if (context.mounted) {
            _showShackBarError(context, respBodyDecode);
          }
        }
      } else if (response.statusCode == 400) {
        error_ = true;
        checkLoading();
        final respBody = response.body;
        final respBodyDecode = json.decode(respBody)['message'];
        if (context.mounted) {
          _showShackBarError(context, respBodyDecode);
        }
      } else if (response.statusCode == 401) {
        error_ = true;
        checkLoading();
        final respBody = response.body;
        final respBodyDecode = json.decode(respBody)['message'];
        if (context.mounted) {
          _showShackBarError(context, respBodyDecode.toString());
        }
        await SharedPref.removeCache(IConstant.localStorageToken);
        if (context.mounted) {
          context.go(LoginView.routeName);
        }
      } else if (response.statusCode == 500) {
        error_ = true;
        checkLoading();
        final respBody = response.body;
        final respBodyDecode = json.decode(respBody)['message'];
        if (context.mounted) {
          _showShackBarError(context, respBodyDecode);
        }
      } else {
        error_ = true;
        checkLoading();
        final respBody = response.body;
        final respBodyDecode = json.decode(respBody)['message'];
        if (context.mounted) {
          _showShackBarError(context, respBodyDecode);
        }
      }
    } on TimeoutException catch (e) {
      error_ = true;
      checkLoading();
      stringLog += "\n:: [PROCESS TIME OUT] ::";
      if (context.mounted) {
        _showShackBarError(context, e.toString());
      }
    } on SocketException catch (e) {
      error_ = true;
      stringLog += "\n:: [SOCKET EXCEPTION] ::\n\t$e";
      if (context.mounted) {
        _showShackBarError(context, e.toString());
      }
    } on Exception catch (e) {
      error_ = true;
      checkLoading();
      stringLog += "\n:: [EXCEPTION] ::\n\t$e";
      if (context.mounted) {
        _showShackBarError(context, e.toString());
      }
    } finally {
      if (!error_ && loading) {
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
      var end = DateTime.now().millisecondsSinceEpoch;
      stringLog += "\n[TIME CALL]--> ${end - start}ms";
      if (kDebugMode) {
        log("\n:: FINALLY ::\n$stringLog");
      }
    }
  }

  Future<String> getToken() async {
    String? token = await SharedPref.getValue(IConstant.localStorageToken);
    return token ?? "";
  }

  Future showLoading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              color: ColorPalette.primary,
            ),
          ),
        );
      },
    );
  }

  void _showShackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(
          child: Material(
            color: Colors.transparent,
            elevation: 8,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.kDefaultPadding * 2,
                vertical: SizeConfig.kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFfce6ed),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ColorPalette.primary,
                      ),
                    ),
                  ),
                  const Icon(Icons.close, size: 12, color: ColorPalette.primary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
