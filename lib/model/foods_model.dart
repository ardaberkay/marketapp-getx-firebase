class Foods {
  String food_id;
  int food_price;
  String food_name;
  String food_image;

  Foods(
      {required this.food_id,
      required this.food_price,
      required this.food_name,
      required this.food_image});

  factory Foods.fromJson(Map<String, dynamic> json, String key) {
    return Foods(
        food_id: key,
        food_name: json["food_name"] as String,
        food_price: json["food_price"] as int,
        food_image: json["food_image"] != null ? json["food_image"] as String: ""
    );
  }
}


