import 'package:equatable/equatable.dart';

import '../../../domain/entities/food_entity.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Food> foods;

  HomeSuccess(this.foods);

  @override
  List<Object?> get props => [foods];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
