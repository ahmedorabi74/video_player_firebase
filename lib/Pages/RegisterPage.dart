import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/auth_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {


    bool isLoading = false;

    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SuccessSignup) {
          BlocProvider.of<AuthCubit>(context).signUpMethod(email, password);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.successSignup),
              duration: const Duration(seconds: 3),
            ),
          );
          isLoading = false;
          Navigator.pushReplacementNamed(context, 'LoginPage');
        } else if (state is FailureSignup) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 3),
            ),
          );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          // color: const Color(0xffD9A9A9),
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: const Color(0xffD9A9A9),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.92,
                      color:
                          Colors.white, // Background color of the clipped area
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        const Center(
                          child: Text(
                            'REGISTER',
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "EMAIL",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.050,
                        ),
                        TextField(
                          controller: password,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_outline_sharp),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.050,
                        ),
                        TextField(
                          controller: confirmPassword,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "CONFIRM PASSWORD",
                            prefixIcon: Icon(Icons.lock_outline_sharp),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.040,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffD9A9A9),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 105, vertical: 15),
                          ),
                          onPressed: () {
                            if (password.text == confirmPassword.text) {
                              BlocProvider.of<AuthCubit>(context)
                                  .signUpMethod(email, password);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Passwords do not match'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0350,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                color: Color(0xff595959), fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void handleError(BuildContext context, dynamic e) {
  String message;

  switch (e.code) {
    case 'weak-password':
      message = 'Weak Password';
      break;
    case 'email-already-in-use':
      message = "This account already exists";
      break;
    case 'invalid-email':
      message = 'Invalid Email';
      break;
    case 'channel-error':
      message = "Please Enter an Email and Password";
      break;
    case 'too-many-requests':
      message = 'Too Many Requests';
      break;
    default:
      message = 'An unexpected error occurred';
  }

  // Display the Snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
