class InteriorTheme {
  final String image;
  final String title;

  InteriorTheme({required this.image, required this.title});

  // Factory method to create an object from JSON
  factory InteriorTheme.fromJson(Map<String, dynamic> json) {
    return InteriorTheme(
      image: json["image"].toString(),
      title: json["title"].toString(),
    );
  }
}
