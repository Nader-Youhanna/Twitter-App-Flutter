import '../lib/widgets/Sign Up/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Email test", () {
    String email1 = "naderyouhanna@gmail.com";
    String email2 = "ahmedmoh123@hotmail.com";
    String email3 = "habiba@gmail";
    String email4 = "nada.com";

    SignUp signUp = SignUp();

    bool isValid1 = signUp.isEmailValid(email1);
    bool isValid2 = signUp.isEmailValid(email2);
    bool isValid3 = signUp.isEmailValid(email3);
    bool isValid4 = signUp.isEmailValid(email4);

    expect(isValid1, true);
    expect(isValid2, true);
    expect(isValid3, false);
    expect(isValid4, false);
  });
}
