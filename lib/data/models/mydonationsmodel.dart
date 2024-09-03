import 'dart:convert';

class Donation {
  final int disaster;
  final String disasterName;
  final int menDresses;
  final int womenDresses;
  final int kidsDresses;
  final List<String> images;
  final int pickupLocation;
  final DateTime donatedOn;
  final String donorName;

  Donation({
    required this.disaster,
    required this.disasterName,
    required this.menDresses,
    required this.womenDresses,
    required this.kidsDresses,
    required this.images,
    required this.pickupLocation,
    required this.donatedOn,
    required this.donorName,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      disaster: json['disaster'],
      disasterName: json['disaster_name'],
      menDresses: json['men_dresses'],
      womenDresses: json['women_dresses'],
      kidsDresses: json['kids_dresses'],
      images: List<String>.from(json['images']),
      pickupLocation: json['pickup_location'],
      donatedOn: DateTime.parse(json['donated_on']),
      donorName: json['donor_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disaster': disaster,
      'disaster_name': disasterName,
      'men_dresses': menDresses,
      'women_dresses': womenDresses,
      'kids_dresses': kidsDresses,
      'images': images,
      'pickup_location': pickupLocation,
      'donated_on': donatedOn.toIso8601String(),
      'donor_name': donorName,
    };
  }
}

class DonationResponse {
  final List<Donation> data;
  final int donationCount;

  DonationResponse({
    required this.data,
    required this.donationCount,
  });

  factory DonationResponse.fromJson(Map<String, dynamic> json) {
    return DonationResponse(
      data: (json['data'] as List)
          .map((item) => Donation.fromJson(item))
          .toList(),
      donationCount: json['donation_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((donation) => donation.toJson()).toList(),
      'donation_count': donationCount,
    };
  }
}
