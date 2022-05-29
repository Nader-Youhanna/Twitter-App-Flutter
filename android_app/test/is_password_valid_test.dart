import '../lib/widgets/Sign Up/choose_password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Password test", () {
    String password1 = "123456789";
    String password2 = "abcdefgh";
    String password3 = "1234";
    String password4 = "abcd";
    ChoosePassword choosePassword =
        ChoosePassword(username: "", email: "", dob: "");

    bool isValid1 = choosePassword.isPasswordValid(password1);
    bool isValid2 = choosePassword.isPasswordValid(password2);
    bool isValid3 = choosePassword.isPasswordValid(password3);
    bool isValid4 = choosePassword.isPasswordValid(password4);

    expect(isValid1, true);
    expect(isValid2, true);
    expect(isValid3, false);
    expect(isValid4, false);
  });
}
