class MessageModel {
  final String message;
  final bool success;

  MessageModel({required this.message, required this.success});

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
        message: jsonData['message'], success: jsonData['success']);
  }
}
