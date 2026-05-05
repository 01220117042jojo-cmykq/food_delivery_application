import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../domain/entities/food_entity.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220, // عرض الكارت عشان يكفي في الـ ListView العرضية
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. الكارت الأبيض اللي شايل النصوص
          Container(
            margin: const EdgeInsets.only(top: 40),
            // مسافة عشان الصورة تنزل فوقه
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // بياخد مساحة المحتوى بس
              children: [
                const SizedBox(height: 60),
                // فراغ داخلي عشان الصورة اللي هتتحط فوق
                Text(
                  food.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  food.price,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),

          // 2. صورة الطبق اللي طالعة بره الكارت (Positioned)
          Positioned(
            top: 0, // بتبدأ من أول الـ Stack فوق خالص
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 55, // حجم الطبق
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(food.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
