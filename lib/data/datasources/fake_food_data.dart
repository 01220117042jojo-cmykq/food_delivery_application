import '../../domain/entities/food_entity.dart';

class FakeFoodData {
  static List<Food> getDummyFoods() {
    return [
      Food(
        id: '1',
        name: 'Veggie tomato mix',
        price: 'N1,900',
        image: 'assets/images/veggie.png',
        category: 'Foods',
        deliveryInfo:
            'Delivered between monday aug and thursday 20 from 8pm to 91:32 pm',
        returnPolicy:
            'All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.',
      ),
      Food(
        id: '2',
        name: 'Spicy fish sauce',
        price: 'N2,300',
        image: 'assets/images/fish.png',
        category: 'Foods',
        deliveryInfo: 'Delivered between 2pm to 4pm',
        returnPolicy: 'No return policy for this item.',
      ),
    ];
  }
}
