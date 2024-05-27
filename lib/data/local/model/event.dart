class Event {
  int? id;
  String? title;
  String? desc;
  String? date;
  String? time;
  String? reminderTime;
  String? pic;

  Event({
    this.id,
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
    required this.reminderTime,
    required this.pic,
  });

  // Dari JSON ke model User
  Event.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    desc = json['desc'];
    date = json['date'];
    time = json['time'];
    reminderTime = json['reminderTime'];
    pic = json['pic'];
  }

  // Dari model User ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
      'time': time,
      'reminderTime': reminderTime,
      'pic': pic,
    };
  }
}
