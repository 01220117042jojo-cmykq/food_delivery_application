import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/food_repositroy.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FoodRepository _foodRepository;

  HomeCubit(this._foodRepository) : super(HomeInitial());

  void getFoods(String category) {
    emit(HomeLoading());
    try {
      final foods = _foodRepository.getFoodsByCategory(category);
      if (foods.isEmpty) {
        emit(HomeError("No foods found in this category"));
      } else {
        emit(HomeSuccess(foods));
      }
    } catch (e) {
      emit(HomeError("Failed to fetch foods: ${e.toString()}"));
    }
  }
}
