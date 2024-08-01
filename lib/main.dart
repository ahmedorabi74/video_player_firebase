import 'package:auth3/Pages/HomePage.dart';
import 'package:auth3/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/ForgetPasswordPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/RegisterPage.dart';
import 'Pages/TimeLinePage.dart';
import 'Pages/VideoUpload.dart';
import 'cubit/obscure_text_cange_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ObscureTextCangeCubit())
      ],
      child: MaterialApp(
        routes: {
          'LoginPage': (context) => LoginPage(),
          'RegisterPage': (context) => RegisterPage(),
          'ForgetPasswordPage': (context) => ForgetPasswordPage(),
          'TimeLine': (context) => TimeLinePage(),
          'Homepage': (context) => HomePage(),
          'UploadVideo': (context) => UploadVideo(),
        },
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? 'LoginPage'
            : 'Homepage',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
