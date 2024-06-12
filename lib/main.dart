import 'package:exam_3/models/food.dart';
import 'package:exam_3/views/screens/foods_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodsScreen(
        restaurantName: "Besh Qozon",
        foods: [
          Food(
              name: "To'y oshi",
              imageUrl:
                  "https://media.express24.uz/r/848/1500/DyIgRzRg4vJbXhEXFCkHl.jpg",
              price: 40000,
              categoryId: 2,
              )
        ],
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRynLfE3ASKi9kao9xrB3O4VOKIUGqXKf70tg&s",
      ),
    );
  }
}
