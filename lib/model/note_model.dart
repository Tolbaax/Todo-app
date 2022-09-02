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

  toJson() {
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
