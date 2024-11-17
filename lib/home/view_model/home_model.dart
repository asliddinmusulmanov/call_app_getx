class ContactsModel {
  final String? name;
  final String? number;
  final String? id;

  ContactsModel({
    this.name,
    this.number,
    this.id,
  });

  ContactsModel copyWith({
    String? name,
    String? number,
    String? id,
  }) =>
      ContactsModel(
        name: name ?? this.name,
        number: number ?? this.number,
        id: id ?? this.id,
      );

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
        name: json["name"],
        number: json["number"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "id": id,
      };

  @override
  String toString() {
    return 'ContactsModel(name: $name, number: $number, id: $id)';
  }
}
