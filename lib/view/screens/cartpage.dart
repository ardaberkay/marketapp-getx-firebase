import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketapp/controller/controllers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Color myColor = const Color(0xFFFAF0E6);

class CartPage extends StatelessWidget {
  final FoodController foodController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Foods',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(() {
        if (foodController.cartItems.isEmpty) {
          return const Center(
            child: Text(
              'Your Cart\'s Empty',
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: foodController.cartItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        key: Key(item.id.toString()),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                foodController.removeItem(item);
                              },
                              borderRadius: BorderRadius.circular(12),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF0E6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFAF0E6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(item.imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        color: Colors.white70,
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              final cartItem = CartItem(
                                                imageUrl: item.imageUrl,
                                                name: item.name,
                                                quantity: item.quantity - 1,
                                                id: item.id,
                                                foodCartPrice:
                                                    item.foodCartPrice,
                                              );
                                              foodController.addToCart(
                                                  cartItem, -1);
                                            },
                                            icon: const Icon(Icons.remove),
                                            iconSize: 20,
                                          ),
                                          Text(
                                            item.quantity.toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              final cartItem = CartItem(
                                                imageUrl: item.imageUrl,
                                                name: item.name,
                                                quantity: item.quantity + 1,
                                                id: item.id,
                                                foodCartPrice:
                                                    item.foodCartPrice,
                                              );
                                              foodController.addToCart(
                                                  cartItem, 1);
                                            },
                                            icon: const Icon(Icons.add),
                                            iconSize: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                        'Price: ₺ ${item.quantity * item.foodCartPrice}',
                                        style: const TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                       Text(
                        'Total Price: ₺ ${foodController.totalCartPrice}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 12.0,
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
