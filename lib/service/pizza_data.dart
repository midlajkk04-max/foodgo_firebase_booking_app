import 'package:firebase_project_hotel_bookking/model/pizza_model.dart';
import 'package:firebase_project_hotel_bookking/service/remote%20configure.dart';

List<PizzaModel> getpizza(RemoteConfigService remoteConfigService) {
  List<PizzaModel> pizza = [];
  PizzaModel pizzaModel = PizzaModel();

  pizzaModel.name = remoteConfigService.getString('pizza_name_1');
  pizzaModel.image = "assets/images/download (12).png";
  pizzaModel.prize = remoteConfigService.getString('pizza_price_1');
  pizza.add(pizzaModel);

  pizzaModel = PizzaModel();
  pizzaModel.name = remoteConfigService.getString('pizza_name_2');
  pizzaModel.image = "assets/images/download (13).png";
  pizzaModel.prize = remoteConfigService.getString('pizza_price_2');
  pizza.add(pizzaModel);

  pizzaModel = PizzaModel();
  pizzaModel.name = remoteConfigService.getString('pizza_name_3');
  pizzaModel.image = "assets/images/download (14).png";
  pizzaModel.prize = remoteConfigService.getString('pizza_price_3');
  pizza.add(pizzaModel);

  pizzaModel = PizzaModel();
  pizzaModel.name = remoteConfigService.getString('pizza_name_4');
  pizzaModel.image = "assets/images/download (16).png";
  pizzaModel.prize = remoteConfigService.getString('pizza_price_4');
  pizza.add(pizzaModel);

  return pizza;
}