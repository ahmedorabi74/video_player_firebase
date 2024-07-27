import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginMethod(
      TextEditingController email, TextEditingController password) async {
    try {
      emit(LoginLoading());

      UserCredential userLogin = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      emit(SuccessLogin(successMessage: "Success Login✅✅"));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(FailureLogin(errorMessage: 'User Not Found'));
          break;
        case 'wrong-password':
          emit(FailureLogin(errorMessage: 'Wrong Password'));
          break;
        case 'invalid-email':
          emit(FailureLogin(errorMessage: 'Invalid Email'));
          break;
        case 'channel-error':
          emit(
              FailureLogin(errorMessage: 'Please Enter an Email and Password'));
          break;
        case 'too-many-requests':
          emit(FailureLogin(
              errorMessage: 'There is an error please try again later'));
          break;
        default:
          print(e.code);
          emit(FailureLogin(errorMessage: 'An unexpected error occurred'));
      }
    }
  }
  //////// end of login method

  Future signInWithGoogle() async {
    try {
      emit(LoginLoading());
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(StopLoading());
        return; // stop google sign in
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(SuccessLoginWithGoogle(successLoginWithGoogle: "Success Login with google✅✅"));
    } on Exception catch (e) {
      emit(FailureLogin(
          errorMessage: "There is an error please try again later"));
    }
  }

  Future<void> signUpMethod(
      TextEditingController email, TextEditingController password) async {
    try {
      emit(SignupLoading());
      UserCredential userData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      emit(SuccessSignup(successSignup: "Success SignUp✅✅"));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(FailureSignup(errorMessage: 'User Not Found'));
          break;
        case 'wrong-password':
          emit(FailureSignup(errorMessage: 'Wrong Password'));
          break;
        case 'invalid-email':
          emit(FailureSignup(errorMessage: 'Invalid Email'));
          break;
        case 'channel-error':
          emit(FailureSignup(
              errorMessage: 'Please Enter an Email and Password'));
          break;
        case 'too-many-requests':
          emit(FailureSignup(
              errorMessage: 'There is an error please try again later'));
          break;
        default:
          print(e.code);
          emit(FailureSignup(errorMessage: 'An unexpected error occurred'));
      }
    }
  }
}
