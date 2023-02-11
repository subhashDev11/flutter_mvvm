import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/routes/route_names.dart';
import 'package:flutter_mvvm/utils/utilis.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool _signUpLoading = false;

  bool get loading => _loading;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setsignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then(
      (value) {
        setLoading(false);
        Utlis.flushBarShowMessage('Login Success', context);
        Navigator.pushNamed(context, RoutesName.home);
        if (kDebugMode) {
          print(value.toString());
        }
      },
    ).onError(
      (error, stackTrace) {
        setLoading(false);
        Utlis.flushBarShowMessage(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      },
    );
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setsignUpLoading(true);
    _myRepo.signUpApi(data).then((value) {
      setsignUpLoading(false);
      Utlis.flushBarShowMessage('Sign Up Success', context);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setsignUpLoading(false);
      Utlis.flushBarShowMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
