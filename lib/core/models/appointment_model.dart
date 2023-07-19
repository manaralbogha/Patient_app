class AppointmentModel {
  bool? success;
  String? message;
  Appointment? appointment;

  AppointmentModel({this.success, this.message, this.appointment});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    appointment = json['Appointment'] != null
        ? Appointment.fromJson(json['Appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (appointment != null) {
      data['Appointment'] = appointment!.toJson();
    }
    return data;
  }
}

class Appointment {
  String? date;
  String? time;
  String? doctorId;
  String? description;
  String? departmentId;
  int? patientId;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Appointment(
      {this.date,
      this.time,
      this.doctorId,
      this.description,
      this.departmentId,
      this.patientId,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Appointment.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    doctorId = json['doctor_id'];
    description = json['description'];
    departmentId = json['department_id'];
    patientId = json['patient_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['doctor_id'] = doctorId;
    data['description'] = description;
    data['department_id'] = departmentId;
    data['patient_id'] = patientId;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
