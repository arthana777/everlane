class ChangePassModel {
  final String old_Password;
  final String new_Password;

  ChangePassModel({
    required this.old_Password,
    required this.new_Password,
  });

  Map<String, dynamic> toJson() => {
        'old_password': old_Password,
        'new_password': new_Password,
      };
}
