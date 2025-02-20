import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'authpage_state.dart';

class AuthpageCubit extends Cubit<AuthpageState> {
  AuthpageCubit(this.context) : super(AuthpageInitial());

  BuildContext context;
  final Color primaryColor = const Color(0xFFF9A825);
  final Color secondaryColor = const Color(0xFFFF6F00);

  bool isLogin = true;
  bool obscurePassword = true;

  // TextEditingControllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  void toggleAuthMode() {
    isLogin = !isLogin;
    emit(AuthpageUpdated());
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(AuthpageUpdated());
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    groupNameController.clear();
    usernameController.clear();
    mobileController.clear();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    groupNameController.dispose();
    usernameController.dispose();
    mobileController.dispose();
    return super.close();
  }
}
