import 'package:auth3/cubit/obscure_text_cange_state.dart';
import 'package:bloc/bloc.dart';

class ObscureTextCangeCubit extends Cubit<ObscureTextCangeState> {
  ObscureTextCangeCubit() : super(ObscureTextCangeInitial(obscureText: true));

  void toggleObscureText() {
    if (state is ObscureTextCangeInitial) {
      final currentState = state as ObscureTextCangeInitial;
      emit(ObscureTextStatus(obscureText: !currentState.obscureText));

      print("${!currentState.obscureText} ✅✅✅✅✅✅✅");
    }
    ///////////////////
    else if (state is ObscureTextStatus) {
      final currentState = state as ObscureTextStatus;
      emit(ObscureTextStatus(obscureText: !currentState.obscureText));
      print("${!currentState.obscureText} ✅✅✅✅✅✅✅");
    }
  }
}
