import 'drinks.dart';
import 'foods.dart';

class Menu {
  List<Foods> foods;
  List<Drinks> drinks;

  Menu({
    this.foods,
    this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> parsedJson) {
    var listFood  = parsedJson['foods'] as List;
    List<Foods> foodList;
    if (listFood != null) {
      foodList  = listFood.map((i) => Foods.fromJson(i)).toList();
    }
    var listDrink  = parsedJson['drinks'] as List;
    List<Drinks> drinkList;
    if (listDrink != null) {
      drinkList  = listDrink.map((i) => Drinks.fromJson(i)).toList();
    }
    return Menu(
      foods: foodList,
      drinks: drinkList,
    );
  }
}