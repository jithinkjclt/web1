import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'authpage_state.dart';

class AuthpageCubit extends Cubit<AuthpageState> {
  AuthpageCubit(this.context) : super(AuthpageInitial());

  BuildContext context;
  final Color primaryColor = const Color(0xFFF9A825);
  final Color secondaryColor = const Color(0xFFFF6F00);

  bool isLogin = true;
  bool obscurePassword = true;

  void toggleAuthMode() {
    isLogin = !isLogin;
    emit(AuthpageUpdated());
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(AuthpageUpdated());
  }
}
