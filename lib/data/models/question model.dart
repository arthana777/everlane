class Questionmodel {
  int? id;
  String? gender;
  String? skinColor;
  String? height;
  String? preferredSeason;
  String? usageOfDress;

  Questionmodel({
    this.id,
    this.gender,
    this.skinColor,
    this.height,
    this.preferredSeason,
    this.usageOfDress,
  });

  Questionmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    skinColor = json['skin_color'];
    height = json['height'];
    preferredSeason = json['preferred_season'];
    usageOfDress = json['usage_of_dress'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender,
      'skin_color': skinColor,
      'height': height,
      'preferred_season': preferredSeason,
      'usage_of_dress': usageOfDress,
    };
  }
}
