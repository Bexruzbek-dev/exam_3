import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantHttpService {
  Future<List<Map<String, dynamic>>> getRestaurants() async {
    final url = Uri.parse('https://exam-3-6cd7d-default-rtdb.firebaseio.com/restaurants.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Map<String, dynamic>> categories = data.values.map((restaurant) => restaurant as Map<String, dynamic>).toList();
      return categories;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
