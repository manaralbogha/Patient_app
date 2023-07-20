class AppointmentModel<T> {
  final String date;
  final String time;
  final T doctorId;
  final String description;
  final T departmentId;
  final int patientId;
  final String status;
  final int id;
  final String? cancelReason;

  AppointmentModel({
    required this.date,
    required this.time,
    required this.doctorId,
    required this.description,
    required this.departmentId,
    required this.patientId,
    required this.status,
    required this.id,
    this.cancelReason,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> jsonData) {
    return AppointmentModel(
      date: jsonData['date'],
      time: jsonData['time'],
      doctorId: jsonData['doctor_id'],
      description: jsonData['description'],
      departmentId: jsonData['department_id'],
      patientId: jsonData['patient_id'],
      status: jsonData['status'],
      id: jsonData['id'],
      cancelReason: jsonData['cancel_reason'] ?? '',
    );
  }
}
