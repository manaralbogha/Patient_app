import 'package:patient_app/core/models/department_model.dart';
import 'package:patient_app/core/models/doctor_model.dart';

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
  final DepartmentModel departmentModel;
  final DoctorModel doctorModel;

  AppointmentModel({
    required this.date,
    required this.time,
    required this.doctorId,
    required this.description,
    required this.departmentId,
    required this.patientId,
    required this.status,
    required this.id,
    required this.departmentModel,
    required this.doctorModel,
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
      departmentModel: DepartmentModel.fromJson(jsonData['department']),
      doctorModel: DoctorModel.fromJson(jsonData['doctor']),
      cancelReason: jsonData['cancel_reason'] ?? '',
    );
  }
}
