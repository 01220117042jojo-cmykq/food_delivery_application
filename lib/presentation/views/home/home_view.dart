import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../data/repositories/food_repositroy.dart';
import '../../manager/home/home_cubit.dart';
import '../../manager/home/home_state.dart';
import 'widgets/food_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(FoodRepository())..getFoods("Foods"),
      child: Scaffold(
        backgroundColor: ColorManager.background,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: AppSize.s20),
                _buildSearchBar(),
                const SizedBox(height: 30),
                _buildCategories(), // الأقسام اللي ضفناها
                const SizedBox(height: 30),
                _buildFoodList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu, color: ColorManager.black, size: AppSize.s28),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        "Delicious\nfood for you",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEEEE),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.black),
            hintText: "Search",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    List<String> categories = ["Foods", "Drinks", "Snacks", "Sauces"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 40),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0; // Foods هي الـ default حالياً
          return Container(
            margin: const EdgeInsets.only(right: 30),
            child: Column(
              children: [
                Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? ColorManager.primary : Colors.grey,
                  ),
                ),
                if (isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 2,
                    width: 40,
                    color: ColorManager.primary,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodList() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccess) {
          return SizedBox(
            height: 330,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              scrollDirection: Axis.horizontal,
              itemCount: state.foods.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) =>
                  FoodCard(food: state.foods[index]),
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
