class ConsultationModel {
  final String question;
  final String questionDate;
  final String doctorID;
  final int patientID;
  final int id;
  final String? answer;
  final String? answerDate;

  ConsultationModel({
    required this.question,
    required this.questionDate,
    required this.doctorID,
    required this.patientID,
    required this.id,
    this.answer,
    this.answerDate,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> jsonData) {
    return ConsultationModel(
      question: jsonData['question'],
      questionDate: jsonData['question_date'],
      doctorID: jsonData['doctor_id'],
      patientID: jsonData['patient_id'],
      id: jsonData['id'],
      answer: jsonData['answer'] ?? '',
      answerDate: jsonData['answer_date'] ?? '',
    );
  }
}
