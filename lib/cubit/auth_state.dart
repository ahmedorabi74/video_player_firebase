part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class SuccessLogin extends AuthState {
  final String successMessage;

  SuccessLogin({required this.successMessage});
}

class FailureLogin extends AuthState {
  final String errorMessage;

  FailureLogin({required this.errorMessage});
}
////////////// end of login state !

class SignupLoading extends AuthState {}

class SuccessSignup extends AuthState {
  final String successSignup;

  SuccessSignup({required this.successSignup});
}

class FailureSignup extends AuthState {
  final String errorMessage;

  FailureSignup({required this.errorMessage});
}
////////////// end of sign up state !

class SuccessLoginWithGoogle extends AuthState {
  final String successLoginWithGoogle;

  SuccessLoginWithGoogle({required this.successLoginWithGoogle});
}

class StopLoading extends AuthState {}
////////////// end of sign up with google state !
