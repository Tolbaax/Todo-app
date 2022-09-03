class TaskModel {
  String? title;
  String? note;
  String? deadLine;
  String? startTime;
  String? endTime;
  int? colorId;
  String? loggedBy;

  TaskModel({
    this.title,
    this.note,
    this.deadLine,
    this.startTime,
    this.endTime,
    this.colorId,
    this.loggedBy,
  });

  toJson() {
    return {
      'title': title,
      'note': note,
      'deadLine': deadLine,
      'startTime': startTime,
      'endTime': endTime,
      'colorId': colorId,
      'loggedBy': loggedBy,
    };
  }
}
