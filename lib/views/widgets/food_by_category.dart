
import 'package:exam_3/services/restaurant_http_service.dart';
import 'package:flutter/material.dart';

class FoodByCategory extends StatefulWidget {
  final String category;

  const FoodByCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<FoodByCategory> createState() => _FoodByCategoryState();
}

class _FoodByCategoryState extends State<FoodByCategory> {
  final restaurantHttpService = RestaurantHttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foods in ${widget.category}'),
      ),
      body: FutureBuilder(
        future: restaurantHttpService.getRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final restaurants = snapshot.data!;
            final foodsInCategory = restaurants
                .where((food) => food['category'] == widget.category)
                .toList();

            return ListView.builder(
              itemCount: foodsInCategory.length,
              itemBuilder: (context, index) {
                final food = foodsInCategory[index];
                return ListTile(
                  title: Text(food['name']),
                  subtitle: Text(food['description'] ?? ''),
                );
              },
            );
          } else {
            return Center(child: Text('No foods found'));
          }
        },
      ),
    );
  }
}
