class TaskModel {
  String? title;
  String? note;
  String? deadLine;
  String? startTime;
  String? endTime;
  int? colorId;

  TaskModel({
    this.title,
    this.note,
    this.deadLine,
    this.startTime,
    this.endTime,
    this.colorId,
  });
  TaskModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    note = json['note'];
    deadLine = json['deadLine'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    colorId = json['colorId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'deadLine': deadLine,
      'startTime': startTime,
      'endTime': endTime,
      'colorId': colorId,
    };
  }
}
