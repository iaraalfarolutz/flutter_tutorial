import 'package:uuid/uuid.dart';

class Location {
  final String name;
  final Uuid id;
  final double latitud;
  final double longitud;
  final bool confirmed;
  final String owner;

  Location(
      {this.id,
      this.name,
      this.latitud,
      this.longitud,
      this.confirmed,
      this.owner});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      id: json['_id'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      owner: json['owner'],
      confirmed: json['confirmed'],
    );
  }
}
