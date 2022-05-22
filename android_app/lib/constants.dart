const MY_IP_ADDRESS = '34.236.108.123';
// const MY_IP_ADDRESS = '192.168.1.14';
const String constToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyODZjOTUxOGI5ZDY2ODU5MzE0M2E1YiIsImlhdCI6MTY1MzE3NTMyOCwiZXhwIjoxNjYxODE1MzI4fQ.uTYQ9umCNOjoU4fLYV8FMl6vwzQUEGfGkqcBPR99JQY';

class URL {
  static String serverIP = "34.236.108.123";
  static String serverPort = "3000";
  static String serverPort2 = "4000";
  static String getTweets = 'http://$serverIP:$serverPort/home/';
  static String likeTweet =
      'http://$serverIP:$serverPort/home/:tweetId/likeTweet';
  static String retweet = 'http://$serverIP:$serverPort/home/:tweetId/retweet';
  static String postTweet = 'http://$serverIP:$serverPort/home/compose-tweet/';
  static String getReplies =
      'http://$serverIP:$serverPort/home/:tweetId/getReplies/';
  static String postReply = 'http://$serverIP:$serverPort/home/:tweetId/reply/';
  static String getSearchElements =
      'http://$serverIP:$serverPort/search?q=f&f=user';
  static String getNotifications =
      'http://$serverIP:$serverPort/home/getNotifications';
}
