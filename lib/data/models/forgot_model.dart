class ForgotModel {

  String username;

  ForgotModel({required this.username});

  
  ForgotModel.fromJson(Map<String, dynamic> json) : 
    username = json['username'];

  
  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }
}
