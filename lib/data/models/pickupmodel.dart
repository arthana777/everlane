class PickupLocation {
  final int? id;
  final String city;
  final String address;

  PickupLocation({
     this.id,
    required this.city,
    required this.address,
  });

  factory PickupLocation.fromJson(Map<String, dynamic> json) {
    return PickupLocation(
      id: json['id']??0,
      city: json['city']??"",
      address: json['address']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'address': address,
    };
  }
}
