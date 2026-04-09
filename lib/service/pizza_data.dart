import 'package:firebase_project_hotel_bookking/model/pizza_model.dart';

List <PizzaModel> getpizza(){
  List<PizzaModel> pizza =[];
  PizzaModel pizzaModel =new PizzaModel();

  pizzaModel.name ="chicken pizza";
  pizzaModel.image ="assets/images/download (12).png";
  pizzaModel.prize ="50";
  pizza.add(pizzaModel);
  pizzaModel =new PizzaModel();

  pizzaModel.name =" Cheese Pizza";
  pizzaModel.image ="assets/images/download (13).png";
  pizzaModel.prize ="80";
  pizza.add(pizzaModel);
  pizzaModel =new PizzaModel();

  pizzaModel.name ="Egg pizza";
  pizzaModel.image ="assets/images/download (14).png";
  pizzaModel.prize ="80";
  pizza.add(pizzaModel);
  pizzaModel =new PizzaModel();

  pizzaModel.name ="peri peri pizza";
  pizzaModel.image ="assets/images/download (16).png";
  pizzaModel.prize ="80";
  pizza.add(pizzaModel);
  pizzaModel =new PizzaModel();
   

  return pizza;
}