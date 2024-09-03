class NotificationModel {
  int? id;
  String? verb;
  String? description;
  String? formatted_timestamp;

  NotificationModel({this.id, this.verb, this.description, this.formatted_timestamp});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verb = json['verb'];
    description = json['description'];
    formatted_timestamp = json['formatted_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['verb'] = this.verb;
    data['description'] = this.description;
    data['formatted_timestamp'] = this.formatted_timestamp;
    return data;
  }
}