import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/obscure_text_cange_cubit.dart';
import '../../cubit/obscure_text_cange_state.dart'; // Import the Cubit

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    bool obscureTextPassword = true;
    bool obscureTextConfirmPassword = true;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SuccessSignup) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.successSignup),
              duration: const Duration(seconds: 3),
            ),
          );
          isLoading = false;
          Navigator.of(context)
              .pushNamedAndRemoveUntil("Homepage", (route) => false);
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
                      color: Colors.white,
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
                        BlocConsumer<ObscureTextCangeCubit,
                            ObscureTextCangeState>(
                          listener: (context, state) {
                            if (state is ObscureTextChangePassword) {
                              obscureTextPassword = !obscureTextPassword;
                            }
                          },
                          builder: (context, state) {
                            return TextField(
                              controller: password,
                              keyboardType: TextInputType.text,
                              obscureText: obscureTextPassword,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon:
                                    const Icon(Icons.lock_outline_sharp),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ObscureTextCangeCubit>(
                                            context)
                                        .toggleObscureText();
                                  },
                                  icon: Icon(
                                    obscureTextPassword
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye_fill,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.050,
                        ),
                        BlocConsumer<ObscureTextCangeCubit,
                            ObscureTextCangeState>(
                          listener: (context, state) {
                            if (state is ObscureTextChangeConfirmPassword) {
                              obscureTextConfirmPassword =
                                  !obscureTextConfirmPassword;
                            }
                          },
                          builder: (context, state) {
                            return TextField(
                              controller: confirmPassword,
                              keyboardType: TextInputType.text,
                              obscureText: obscureTextConfirmPassword,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon:
                                    const Icon(Icons.lock_outline_sharp),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ObscureTextCangeCubit>(
                                            context)
                                        .toggleObscureText2();
                                  },
                                  icon: Icon(
                                    obscureTextConfirmPassword
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye_fill,
                                  ),
                                ),
                              ),
                            );
                          },
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
                            Navigator.pop(context);
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
