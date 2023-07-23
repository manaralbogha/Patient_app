import 'package:patient_app/core/models/user_model.dart';

class PatientModel {
  final int? id;
  final int? userID;
  final int? wallet;
  final String? address;
  final String? fcmToken;
  final String? gender;
  final String? birthDate;
  final User? userModel;

  PatientModel({
    this.id,
    this.userID,
    this.wallet,
    this.address,
    this.fcmToken,
    this.gender,
    this.birthDate,
    this.userModel,
  });

  factory PatientModel.fromJson(Map<String, dynamic> jsonData) {
    return PatientModel(
      id: jsonData['id'],
      userID: jsonData['user_id'],
      wallet: jsonData['patient_wallet'],
      address: jsonData['address'],
      fcmToken: jsonData['FCMToken'],
      gender: jsonData['gender'],
      birthDate: jsonData['birth_date'],
      userModel: User.fromJson(jsonData['user']),
    );
  }
}
