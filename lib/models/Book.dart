// ignore_for_file: file_names

class Book {
  final int? id;
  final String code;
  final String name;
  final int idBook;
  final int order;

  Book({
    required this.code,
    required this.idBook,
    required this.order,
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'idBook': idBook,
      'order': order,
    };
  }

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      id: data['id'],
      code: data['code'],
      name: data["name"],
      idBook: data['idBook'],
      order: data['order'] ?? 0,
    );
  }
}
