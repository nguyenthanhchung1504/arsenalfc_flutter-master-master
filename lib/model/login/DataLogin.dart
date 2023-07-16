class DataLogin {
  DataLogin({
      this.token, 
      this.userName, 
      this.fullName, 
      this.email, 
      this.isAdmin,});

  DataLogin.fromJson(dynamic json) {
    token = json['Token'];
    userName = json['UserName'];
    fullName = json['FullName'];
    email = json['Email'];
    isAdmin = json['IsAdmin'];
  }
  String? token;
  String? userName;
  String? fullName;
  String? email;
  bool? isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Token'] = token;
    map['UserName'] = userName;
    map['FullName'] = fullName;
    map['Email'] = email;
    map['IsAdmin'] = isAdmin;
    return map;
  }

}