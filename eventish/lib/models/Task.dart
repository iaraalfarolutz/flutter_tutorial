class Task {
  String title = "";
  String id;
  String eventId;
  String user;
  bool confirmed;
  String description = "";

  Task(
      {this.id,
      this.title,
      this.eventId,
      this.user,
      this.confirmed,
      this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      id: json['_id'],
      eventId: json['event'],
      user: json['user'],
      description: json['description'],
      confirmed: json['confirmed'],
    );
  }

  String getTaskInfo() {
    String shortdesc = this.description.trim().replaceAll("\n", " ");
    String info = "{ \"title\": \"" +
        this.title.trim() +
        "\", " +
        "\"event\": \"" +
        this.eventId.toString() +
        "\", " +
        "\"user\": \"" +
        this.user.trim() +
        "\", " +
        "\"description\": \"" +
        shortdesc +
        "\", " +
        "\"confirmed\": " +
        this.confirmed.toString() +
        "}";
    return info;
  }
}
