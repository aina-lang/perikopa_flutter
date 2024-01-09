// ignore_for_file: file_names

class Book {
  final int? id;
  final int idTestament;
  final String nom;
  Book({required this.idTestament, required this.nom, this.id,});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nom': nom, 'idTestament': idTestament};
  }

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      id: data['id'],
      nom: data['nom'],
      idTestament: data['idTestament'],
    );
  }

}