class Location {
  String name;
  String id;
  double latitud;
  double longitud;
  bool confirmed;
  String owner;

  Location(
      {this.id,
      this.name,
      this.latitud,
      this.longitud,
      this.confirmed,
      this.owner});

  factory Location.createFromOwner(String owner) {
    return Location(owner: owner);
  }

  String getInfo() {
    String info = "{ \"name\": \"" +
        this.name.trim() +
        "\", " +
        "\"latitud\": " +
        this.latitud.toString() +
        ", " +
        "\"longitud\": " +
        this.longitud.toString() +
        ", " +
        "\"confirmed\": " +
        this.confirmed.toString() +
        ", " +
        "\"owner\": \"" +
        this.owner.trim() +
        "\"}";
    return info;
  }

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
