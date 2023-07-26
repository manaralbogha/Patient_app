class WorkDayModel {
  final int id;
  final String day;
  final String startTime;
  final String endTime;
  final int doctorID;

  WorkDayModel({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.doctorID,
  });

  factory WorkDayModel.fromJson(Map<String, dynamic> jsonData) {
    return WorkDayModel(
      id: jsonData['id'],
      day: jsonData['day'],
      startTime: jsonData['start_time'],
      endTime: jsonData['end_time'],
      doctorID: jsonData['doctor_id'],
    );
  }
}
