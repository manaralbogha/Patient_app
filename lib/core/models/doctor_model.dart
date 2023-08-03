import 'package:patient_app/core/models/user_model.dart';

class DoctorModel {
  final int id;
  final String specialty;
  final String description;
  final String imagePath;
  final int departmentID;
  final int consultationPrice;
  final int review;
  final int userID;
  final UserModel user;
  String? departmentImage;

  DoctorModel({
    required this.id,
    required this.specialty,
    required this.description,
    required this.imagePath,
    required this.departmentID,
    required this.consultationPrice,
    required this.review,
    required this.userID,
    required this.user,
    this.departmentImage,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> jsonData) {
    return DoctorModel(
      id: jsonData['id'],
      specialty: jsonData['specialty'],
      description: jsonData['description'],
      imagePath: jsonData['image_path'],
      departmentID: jsonData['department_id'],
      consultationPrice: jsonData['consultation_price'],
      review: jsonData['review'],
      userID: jsonData['user_id'],
      user: UserModel.fromJson(jsonData['user']),
    );
  }

  // factory DoctorModel.fromJsonFavourite(Map<String, dynamic> jsonData) {
  //   return DoctorModel(
  //     id: jsonData['id'],
  //     specialty: jsonData['specialty'],
  //     description: jsonData['description'],
  //     imagePath: jsonData['image_path'],
  //     departmentID: jsonData['department_id'],
  //     consultationPrice: jsonData['consultation_price'],
  //     review: jsonData['review'],
  //     userID: jsonData['user_id'],
  //   );
  // }
}
