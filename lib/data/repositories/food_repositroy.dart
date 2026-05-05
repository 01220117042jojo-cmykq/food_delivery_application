import '../../domain/entities/food_entity.dart';
import '../datasources/fake_food_data.dart';

class FoodRepository {
  List<Food> getFoods() {
    return FakeFoodData.getDummyFoods();
  }

  List<Food> getFoodsByCategory(String category) {
    return FakeFoodData.getDummyFoods()
        .where((food) => food.category == category)
        .toList();
  }
}
