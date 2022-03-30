import './user.dart';

class Message {
  String messageText;
  User sender;
  User receiver;
  DateTime sendDate;
  Message(this.messageText, this.sender, this.receiver, this.sendDate);
}
