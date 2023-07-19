class AddAppointmentModel {
  String date;
  String time;
  String description;
  int departmentId;
  int doctorIid;
  AddAppointmentModel({
    required this.date,
    required this.time,
    required this.description,
    required this.departmentId,
    required this.doctorIid,
  });
}
