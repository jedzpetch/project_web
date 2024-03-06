class UserModel {
  final String? userID;
  final String? userEmail;
  final String? userName;
  final String? userBirthDay;
  final String? userGender;
  final String? userImageURL;
  final String? userType;
  final String? userHigh;
  final String? userWeight;

  UserModel(
      {required this.userID,
      required this.userEmail,
      required this.userName,
      this.userBirthDay,
      this.userGender,
      this.userImageURL,
      required this.userType,
      this.userHigh,
      this.userWeight});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userID: json["userID"] ?? "",
        userEmail: json["userEmail"] ?? "",
        userName: json["userName"] ?? "",
        userType: json["userType"] ?? "");
  }
  Map<String, dynamic> toJson() => {
        "userID": userID,
        "userEmail": userEmail,
        "userName": userName,
        "userType": userType
      };
}
