

class Statusmodel {
  final String? status;
  final String? message;
  Statusmodel( { this.status,  this.message,});

  factory Statusmodel.fromJson(Map<String, dynamic> json) {
    return Statusmodel(
      status: json['status'],
      message: json['message'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }
}