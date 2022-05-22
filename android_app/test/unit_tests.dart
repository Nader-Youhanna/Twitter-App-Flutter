import '../lib/widgets/side_bar.dart';
import '../lib/widgets/Sign Up/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/widgets/Sign Up/choose_password.dart';
import '../lib/widgets//Notifications/notification_item.dart';

void main() {
  group(
    "Unit tests",
    () {
      test(
        "Email test",
        () {
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
        },
      );

      test(
        "Password test",
        () {
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
        },
      );
      test(
        "Sidebar test",
        () {
          final sidebar = SideBar(
            name: 'Nader',
            username: 'nido123',
            token: '',
            isAdmin: false,
            userImage: '',
            email: '',
          );

          var actual = sidebar.name;
          var matcher = 'Nader';
          expect(actual, matcher);

          actual = sidebar.username;
          matcher = 'nido123';
          expect(actual, matcher);
        },
      );
      test(
        "Notification test",
        () {
          final notificationItem = NotificationItem();
          notificationItem.notificationType = 'like';
          String message = notificationItem.getType();
          expect(message, '  liked your tweet');
          notificationItem.notificationType = 'retweet';
          message = notificationItem.getType();
          expect(message, '  retweeted your tweet');
          notificationItem.notificationType = 'block';
          message = notificationItem.getType();
          expect(message, '  blocked you');
        },
      );
    },
  );
}
