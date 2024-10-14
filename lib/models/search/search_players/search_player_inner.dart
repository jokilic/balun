import 'birth/birth.dart';

class SearchPlayerInner {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final int? age;
  final Birth? birth;
  final String? nationality;
  final String? height;
  final String? weight;
  final int? number;
  final String? position;
  final String? photo;

  SearchPlayerInner({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.age,
    this.birth,
    this.nationality,
    this.height,
    this.weight,
    this.number,
    this.position,
    this.photo,
  });

  factory SearchPlayerInner.fromMap(Map<String, dynamic> map) => SearchPlayerInner(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        firstName: map['firstName'] != null ? map['firstName'] as String : null,
        lastName: map['lastName'] != null ? map['lastName'] as String : null,
        age: map['age'] != null ? map['age'] as int : null,
        birth: map['birth'] != null ? Birth.fromMap(map['birth'] as Map<String, dynamic>) : null,
        nationality: map['nationality'] != null ? map['nationality'] as String : null,
        height: map['height'] != null ? map['height'] as String : null,
        weight: map['weight'] != null ? map['weight'] as String : null,
        number: map['number'] != null ? map['number'] as int : null,
        position: map['position'] != null ? map['position'] as String : null,
        photo: map['photo'] != null ? map['photo'] as String : null,
      );

  @override
  String toString() =>
      'SearchPlayerInner(id: $id, name: $name, firstName: $firstName, lastName: $lastName, age: $age, birth: $birth, nationality: $nationality, height: $height, weight: $weight, number: $number, position: $position, photo: $photo)';

  @override
  bool operator ==(covariant SearchPlayerInner other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id &&
        other.name == name &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.birth == birth &&
        other.nationality == nationality &&
        other.height == height &&
        other.weight == weight &&
        other.number == number &&
        other.position == position &&
        other.photo == photo;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      age.hashCode ^
      birth.hashCode ^
      nationality.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      number.hashCode ^
      position.hashCode ^
      photo.hashCode;
}
