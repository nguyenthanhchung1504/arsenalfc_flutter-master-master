


class UserData {
  UserData({
      this.fullName, 
      this.email, 
      this.phoneNumber, 
      this.avatarLink,});

  UserData.fromJson(dynamic json) {
    fullName = json['FullName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    avatarLink = json['AvatarLink'];
  }
  String? fullName;
  String? email;
  String? phoneNumber;
  String? avatarLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FullName'] = fullName;
    map['Email'] = email;
    map['PhoneNumber'] = phoneNumber;
    map['AvatarLink'] = avatarLink;
    return map;
  }

}