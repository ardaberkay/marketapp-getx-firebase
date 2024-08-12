import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketapp/controller/controllers.dart';
import 'package:marketapp/view/screens/foodcontent.dart';

Color myColor = const Color(0xFFFAF0E6);

class Homepage extends StatelessWidget {
  final FoodController foodController = Get.put(FoodController());

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: List.generate(foodController.foodList.length, (index) {
            var food = foodController.foodList[index];
            return GestureDetector(
              onTap: () {
                Get.to(FoodContent(
                  foodImageUrl: food.food_image,
                  foodName: food.food_name,
                  foodPrice: food.food_price,
                  name: '',
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: myColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(food.food_image),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              food.food_name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\₺ ${food.food_price.toString()}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
