class Disaster {
  int id;
  String firstName;
  String name;
  String adhar;
  String location;
  String description;
  bool isApproved;
  DateTime createdOn;
  int requiredMenDresses;
  int requiredWomenDresses;
  int requiredKidsDresses;
  int fulfilledMenDresses;
  int fulfilledWomenDresses;
  int fulfilledKidsDresses;
  int? user;
  int createdBy;

  Disaster({
    required this.id,
    required this.firstName,
    required this.name,
    required this.adhar,
    required this.location,
    required this.description,
    required this.isApproved,
    required this.createdOn,
    required this.requiredMenDresses,
    required this.requiredWomenDresses,
    required this.requiredKidsDresses,
    required this.fulfilledMenDresses,
    required this.fulfilledWomenDresses,
    required this.fulfilledKidsDresses,
    this.user,
    required this.createdBy,
  });

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      name: json['name'] ?? '',
      adhar: json['adhar'] ?? '',
      location: json['location'] ?? "",
      description: json['description'] ?? "",
      isApproved: json['is_approved'] ?? false, // Boolean check
      createdOn: DateTime.parse(json['created_on']),
      requiredMenDresses: json['required_men_dresses'] ?? 0, // Default to 0
      requiredWomenDresses: json['required_women_dresses'] ?? 0, // Default to 0
      requiredKidsDresses: json['required_kids_dresses'] ?? 0, // Default to 0
      fulfilledMenDresses: json['fulfilled_men_dresses'] ?? 0, // Default to 0
      fulfilledWomenDresses: json['fulfilled_women_dresses'] ?? 0, // Default to 0
      fulfilledKidsDresses: json['fulfilled_kids_dresses'] ?? 0, // Default to 0
      user: json['user'] != null ? json['user'] as int : null, // Nullable int
      createdBy: json['created_by'] ?? 0, // Default to 0
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'name': name,
      'adhar': adhar,
      'location': location,
      'description': description,
      'is_approved': isApproved,
      'created_on': createdOn.toIso8601String(),
      'required_men_dresses': requiredMenDresses,
      'required_women_dresses': requiredWomenDresses,
      'required_kids_dresses': requiredKidsDresses,
      'fulfilled_men_dresses': fulfilledMenDresses,
      'fulfilled_women_dresses': fulfilledWomenDresses,
      'fulfilled_kids_dresses': fulfilledKidsDresses,
      'user': user,
      'created_by': createdBy,
    };
  }
}
