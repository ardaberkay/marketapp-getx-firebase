import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketapp/controller/controllers.dart';
import 'package:marketapp/main.dart';
import 'package:marketapp/model/foods_model.dart';

class FoodContent extends StatelessWidget {
  final String foodImageUrl;
  final String foodName;
  final int foodPrice;
  final String name;

  FoodContent(
      {required this.foodImageUrl,
      required this.foodName,
      required this.foodPrice,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find();
    foodController.zeroQuantity();

    return Scaffold(
      appBar: MyApp.appBar,
      body: Column(
        children: [
          Image.network(foodImageUrl),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(foodName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          ),
          Text('₺ ${foodPrice.toString()}',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          Obx(() => Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: foodController.decrementQuantity,
                          icon: const Icon(Icons.remove),
                          iconSize: 30,
                        ),
                        Text(
                          foodController.quantity.toString(),
                          style: const TextStyle(fontSize: 30),
                        ),
                        IconButton(
                          onPressed: (foodController.incrementQuantity),
                          icon: const Icon(Icons.add),
                          iconSize: 30,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final cartItem = CartItem(
                          imageUrl: foodImageUrl,
                          name: foodName,
                          quantity: foodController.quantity.value,
                          id: foodName,
                          foodCartPrice: foodPrice,
                        );
                        foodController.addToCart(
                            cartItem, foodController.quantity.value);
                      },
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    )
                  ],
                ),
              )),
          Obx(() {
            final totalPrice = foodController.quantity.value * foodPrice;
            return Text(
              'Total: ₺ $totalPrice',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            );
          }),
        ],
      ),
    );
  }
}
