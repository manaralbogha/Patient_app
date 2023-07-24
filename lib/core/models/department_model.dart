class DepartmentModel {
  final int id;
  final String name;
  final String img;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.img,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> jsonData) {
    return DepartmentModel(
      id: jsonData['id'],
      name: jsonData['name'],
      img: jsonData['img'],
    );
  }
}
