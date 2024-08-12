import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:marketapp/model/foods_model.dart';

class FoodController extends GetxController {
  final foodList = <Foods>[].obs;
  var cartItems = <CartItem>[].obs;
  var quantity = 0.obs;


  @override
  void onInit() {
    super.onInit();
    zeroQuantity();
    fetchFoods();
  }

  void fetchFoods() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Foods').get();

    querySnapshot.docs.forEach((doc) {
      var food = Foods(
        food_id: doc.id,
        food_price: doc['food_price'] as int,
        food_name: doc['food_name'],
        food_image: doc['food_image'],
      );
      foodList.add(food);
    });
  }



  void zeroQuantity() {
    quantity.value = 0;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void removeItem(item) {
    cartItems.remove(item);
  }

  int get totalCartPrice{
    return cartItems.fold(0, (sum, item) => sum + item.quantity * item.foodCartPrice);
  }

  void addToCart(CartItem newItem, int quantity) {
    bool found = false;
    for (var item in cartItems) {
      if (item.id == newItem.id && quantity > 0) {
        item.quantity += quantity;
        found = true;
        break;
      }
      if (item.id == newItem.id && quantity < 0 && item.quantity > 0) {
        item.quantity += quantity;
        found = true;
        if (item.quantity < 1) {
          removeItem(item);
        }
        break;
      }
    }
    if (!found) {
      cartItems.add(newItem);
    }
    cartItems.refresh();
  }
}

class CartItem {
  final String id;
  String imageUrl;
  String name;
  int quantity;
  int foodCartPrice;

  CartItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.foodCartPrice,
  });
}
