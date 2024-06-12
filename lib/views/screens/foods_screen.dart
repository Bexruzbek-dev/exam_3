import 'package:exam_3/models/food.dart';
import 'package:exam_3/services/categories_http_services.dart';
import 'package:flutter/material.dart';

class FoodsScreen extends StatefulWidget {
  final String restaurantName;
  final List<Food> foods;
  final String imageUrl;

  FoodsScreen({
    Key? key,
    required this.restaurantName,
    required this.foods,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  final CategoriesHttpServices categoriesHttpServices =
      CategoriesHttpServices();
  int? selectedCategory;
  Future<List<Map<String, dynamic>>>? categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = categoriesHttpServices.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.restaurantName),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios_new_rounded),
        // ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;
            final filteredFoods = selectedCategory == null
                ? widget.foods
                : widget.foods
                    .where((food) => food.categoryId == selectedCategory)
                    .toList();

            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory = category['id'];
                            });
                          },
                          child: Chip(
                            label: Text(category['name']),
                            backgroundColor: selectedCategory == category['id']
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = filteredFoods[index];
                      return ListTile(
                        title: Text(food.name),
                        subtitle: Text(
                            "Sunt mollit ut cupidatat sunt duis laborum ea laboris consectetur ipsum."),
                        leading: Image.network(
                          food.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No categories found'));
          }
        },
      ),
    );
  }
}
