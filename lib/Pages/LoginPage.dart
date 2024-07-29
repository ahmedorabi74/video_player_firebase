import 'package:auth3/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/obscure_text_cange_cubit.dart';
import '../cubit/obscure_text_cange_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    bool obscureTextPassword = true;

    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is SuccessLogin) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.successMessage),
              duration: const Duration(seconds: 3),
            ),
          );
          isLoading = false;
          Navigator.pushReplacementNamed(context, 'Homepage');
        } else if (state is FailureLogin) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 3),
            ),
          );
          isLoading = false;
        } else if (state is StopLoading) {
          isLoading = false;
        } else if (state is SuccessLoginWithGoogle) {
          isLoading = false;
          Navigator.pushReplacementNamed(context, 'Homepage');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          color: Colors.white,
          progressIndicator: const CircularProgressIndicator(
            color: Color(0xffD9A9A9),
          ),
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
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.92,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                              ),
                              const Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 28),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.050,
                              ),
                              BlocConsumer<ObscureTextCangeCubit,
                                  ObscureTextCangeState>(
                                listener: (context, state) {
                                  if (state is ObscureTextChangePassword) {
                                    obscureTextPassword = !obscureTextPassword;
                                  }
                                },
                                builder: (context, state) {
                                  return TextField(
                                    obscureText: obscureTextPassword,
                                    controller: password,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        prefixIcon:
                                            Icon(Icons.lock_outline_sharp),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            BlocProvider.of<
                                                        ObscureTextCangeCubit>(
                                                    context)
                                                .toggleObscureText();
                                          },
                                          icon: Icon(
                                            obscureTextPassword
                                                ? CupertinoIcons.eye_slash_fill
                                                : CupertinoIcons.eye_fill,
                                          ),
                                        )),
                                  );
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'ForgetPasswordPage');
                                },
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffD9A9A9),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 105, vertical: 15),
                                ),
                                onPressed: () async {
                                  BlocProvider.of<AuthCubit>(context)
                                      .loginMethod(email!, password!);
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0350,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'RegisterPage');
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Color(0xff595959), fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.010,
                              ),
                              const Text(
                                'OR',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sign in with',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthCubit>(context)
                                          .signInWithGoogle();
                                    },
                                    icon: Image.asset(
                                      "assets/7123025_logo_google_g_icon.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: const Color(0xffD9A9A9),
                                height: 1,
                                thickness: 2,
                                indent:
                                    MediaQuery.of(context).size.width * 0.19,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.23,
                              )
                            ],
                          ),
                        ), // Background color of the clipped area
                      ),
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
