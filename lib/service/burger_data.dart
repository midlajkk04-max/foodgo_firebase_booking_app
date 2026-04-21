
import 'package:firebase_project_hotel_bookking/model/burger_model.dart';

List <BurgerModel> getburger(){
  List<BurgerModel> burger =[];
  BurgerModel burgerModel =  BurgerModel();

  burgerModel.name ="burger";
  burgerModel.image ="assets/images/category_1.png";
  burgerModel.prize ="50";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  
  burgerModel.name ="burger";
  burgerModel.image ="assets/images/category_1.png";
  burgerModel.prize ="50";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  
  burgerModel.name ="burger";
  burgerModel.image ="assets/images/category_1.png";
  burgerModel.prize ="50";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  
  burgerModel.name ="burger";
  burgerModel.image ="assets/images/category_1.png";
  burgerModel.prize ="50";
  burger.add(burgerModel);
  burgerModel = BurgerModel();

  return burger;
}