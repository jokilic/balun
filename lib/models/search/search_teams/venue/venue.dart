class Venue {
  final int? id;
  final String? name;
  final String? address;
  final String? city;
  final int? capacity;
  final String? surface;
  final String? image;

  Venue({
    this.id,
    this.name,
    this.address,
    this.city,
    this.capacity,
    this.surface,
    this.image,
  });

  factory Venue.fromMap(Map<String, dynamic> map) => Venue(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        address: map['address'] != null ? map['address'] as String : null,
        city: map['city'] != null ? map['city'] as String : null,
        capacity: map['capacity'] != null ? map['capacity'] as int : null,
        surface: map['surface'] != null ? map['surface'] as String : null,
        image: map['image'] != null ? map['image'] as String : null,
      );

  @override
  String toString() => 'Venue(id: $id, name: $name, address: $address, city: $city, capacity: $capacity, surface: $surface, image: $image)';

  @override
  bool operator ==(covariant Venue other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.address == address && other.city == city && other.capacity == capacity && other.surface == surface && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode ^ city.hashCode ^ capacity.hashCode ^ surface.hashCode ^ image.hashCode;
}
