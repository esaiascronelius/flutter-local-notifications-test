class Notification {
  final int id;
  final String title;
  final String body;
  final String payload;

  /// Creates a new instance of [Notification].
  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  /// Creates a new instance of [Notification] from a JSON object.
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      payload: json['payload'],
    );
  }
}
