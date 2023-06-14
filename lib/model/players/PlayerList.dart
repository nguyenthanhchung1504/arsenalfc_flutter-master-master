class PlayerList {
  PlayerList({
      this.birthday, 
      this.born, 
      this.debut, 
      this.facebook, 
      this.height, 
      this.image, 
      this.imageContact, 
      this.instagram, 
      this.name, 
      this.nation, 
      this.number, 
      this.pos, 
      this.story, 
      this.twitter, 
      this.weight,
      this.imageContactNew,
      this.imageNew,
      this.youtube,});

  PlayerList.fromJson(dynamic json) {
    birthday = json['Birthday'];
    born = json['Born'];
    debut = json['Debut'];
    facebook = json['Facebook'];
    height = json['Height'];
    image = json['Image'];
    imageContact = json['ImageContact'];
    instagram = json['Instagram'];
    name = json['Name'];
    nation = json['Nation'];
    number = json['Number'];
    pos = json['Pos'];
    story = json['Story'];
    twitter = json['Twitter'];
    weight = json['Weight'];
    youtube = json['Youtube'];
    imageNew = json['ImageNew'];
    imageContactNew = json['ImageContactNew'];
  }
  String? birthday;
  String? born;
  String? debut;
  String? facebook;
  String? height;
  String? image;
  String? imageNew;
  String? imageContact;
  String? instagram;
  String? name;
  String? nation;
  String? number;
  String? pos;
  String? story;
  String? twitter;
  String? weight;
  String? imageContactNew;
  String? youtube;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Birthday'] = birthday;
    map['Born'] = born;
    map['Debut'] = debut;
    map['Facebook'] = facebook;
    map['Height'] = height;
    map['Image'] = image;
    map['ImageContact'] = imageContact;
    map['Instagram'] = instagram;
    map['Name'] = name;
    map['Nation'] = nation;
    map['Number'] = number;
    map['Pos'] = pos;
    map['Story'] = story;
    map['Twitter'] = twitter;
    map['Weight'] = weight;
    map['Youtube'] = youtube;
    map['ImageNew'] = imageNew;
    map['ImageContactNew'] = imageContactNew;
    return map;
  }

}