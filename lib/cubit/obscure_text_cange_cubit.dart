import 'package:auth3/cubit/obscure_text_cange_state.dart';
import 'package:bloc/bloc.dart';

class ObscureTextCangeCubit extends Cubit<ObscureTextCangeState> {
  ObscureTextCangeCubit() : super(ObscureTextChangePassword());

  void toggleObscureText() {
    emit(ObscureTextChangePassword());
  }

  void toggleObscureText2() {
    emit(ObscureTextChangeConfirmPassword());
  }
}
