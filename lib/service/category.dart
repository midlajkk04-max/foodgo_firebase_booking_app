import 'package:firebase_project_hotel_bookking/model/category_model.dart';

List<CategoryModel> getcategores(){


  List<CategoryModel> category = [];
  CategoryModel categoryModel =  CategoryModel();

  categoryModel.name ="Pizza";
  categoryModel.images = "assets/images/category.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name ="Burger";
  categoryModel.images = "assets/images/category_1.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name ="Momos";
  categoryModel.images = "assets/images/category_2.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name ="pastha";
  categoryModel.images = "assets/images/category_3.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name ="Loaded fries";
  categoryModel.images = "assets/images/category_4.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}