part of 'authpage_cubit.dart';

@immutable
sealed class AuthpageState {}

final class AuthpageInitial extends AuthpageState {}
final class AuthpageUpdated extends AuthpageState {}

