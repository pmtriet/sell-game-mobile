abstract class User {
  int get id;
  String get fullname;
  String get email;
  String get phone;
  int get balance;
  int get pendingBalance;
  UserAvatar get avatar;
  UserBackground get background;
  String get accessToken;
  List<int> get follower;
  List<int> get following;
  double get review;
  int get sold;
  int get selling;
  int get participatedDays;
  List<int> get favouriteProducts;
}
abstract class UserAvatar{
    String get filePath;
}

abstract class UserBackground{
    String get filePath;
}
