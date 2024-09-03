class Qstresult {
  int? id;
  String? name;
  String? description;
  String? price;
  String? brand;
  int? subcategory;
  String? image;
  bool? isActive;
  String? createdOn;
  bool? isDeleted;
  bool? isTrending;
  bool? winter;
  bool? summer;
  bool? rainy;
  bool? autumn;
  SkinColors? skinColors;
  Heights? heights;
  String? genders;
  Usages? usages;

  Qstresult(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.brand,
      this.subcategory,
      this.image,
      this.isActive,
      this.createdOn,
      this.isDeleted,
      this.isTrending,
      this.winter,
      this.summer,
      this.rainy,
      this.autumn,
      this.skinColors,
      this.heights,
      this.genders,
      this.usages});

  Qstresult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    brand = json['brand'];
    subcategory = json['subcategory'];
    image = json['image'];
    isActive = json['is_active'];
    createdOn = json['created_on'];
    isDeleted = json['is_deleted'];
    isTrending = json['is_trending'];
    winter = json['winter'];
    summer = json['summer'];
    rainy = json['rainy'];
    autumn = json['autumn'];
    skinColors = json['skin_colors'] == null
        ? SkinColors.fromJson(json['skin_colors'])
        : null;
    heights =
        json['heights'] == null ? Heights.fromJson(json['heights']) : null;
    genders = json['genders'];
    usages =
        json['usages'] == null ? Usages.fromJson(json['usages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic> ();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['brand'] = brand;
    data['subcategory'] = subcategory;
    data['image'] = image;
    data['is_active'] = isActive;
    data['created_on'] = createdOn;
    data['is_deleted'] = isDeleted;
    data['is_trending'] = isTrending;
    data['winter'] = winter;
    data['summer'] = summer;
    data['rainy'] = rainy;
    data['autumn'] = autumn;
    if (skinColors == null) {
      data['skin_colors'] = skinColors!.toJson();
    }
    if (heights == null) {
      data['heights'] = heights!.toJson();
    }
    data['genders'] = genders;
    if (usages == null) {
      data['usages'] = usages!.toJson();
    }
    return data;
  }
}

class SkinColors {
  bool? dark;
  bool? fair;
  bool? medium;

  SkinColors({this.dark, this.fair, this.medium});

  SkinColors.fromJson(Map<String, dynamic> json) {
    dark = json['Dark'];
    fair = json['Fair'];
    medium = json['Medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Dark'] = dark;
    data['Fair'] = fair;
    data['Medium'] = medium;
    return data;
  }
}

class Heights {
  bool? tall;
  bool? short;
  bool? medium;

  Heights({this.tall, this.short, this.medium});

  Heights.fromJson(Map<String, dynamic> json) {
    tall = json['Tall'];
    short = json['Short'];
    medium = json['Medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Tall'] = tall;
    data['Short'] = short;
    data['Medium'] = medium;
    return data;
  }
}

class Usages {
  bool? party;
  bool? casual;
  bool? formal;
  bool? sports;

  Usages({this.party, this.casual, this.formal, this.sports});

  Usages.fromJson(Map<String, dynamic> json) {
    party = json['Party'];
    casual = json['Casual'];
    formal = json['Formal'];
    sports = json['Sports'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Party'] = party;
    data['Casual'] = casual;
    data['Formal'] = formal;
    data['Sports'] = sports;
    return data;
  }
}