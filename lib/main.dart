import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketapp/controller/controllers.dart';
import 'package:marketapp/view/screens/cartpage.dart';
import 'package:marketapp/view/screens/foodcontent.dart';
import 'package:marketapp/view/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:marketapp/view/screens/profilepage.dart';
import 'model/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(FoodController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [Homepage(), const ProfilePage()];
    final RxInt selectedIndex = 0.obs;

    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Götür App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(
        () => Scaffold(
          appBar: MyApp.appBar,
          body: IndexedStack(
            index: selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'Foods',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex.value,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  static final appBar = AppBar(
    title: const Center(
      child: Text(
        'Foods',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          // Sepet sayfasına gitmek için navigasyon
          Get.to(() => CartPage());
        },
      ),
    ],
  );
}
