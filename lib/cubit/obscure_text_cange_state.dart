import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ObscureTextCangeState {}

class ObscureTextCangeInitial extends ObscureTextCangeState {
  final bool obscureText;

  ObscureTextCangeInitial({required this.obscureText});
}

class ObscureTextStatus extends ObscureTextCangeState {
  final bool obscureText;

  ObscureTextStatus({required this.obscureText});
}
