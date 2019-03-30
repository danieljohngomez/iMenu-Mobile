import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';

class MenuModel extends Model {
  List<MenuItemModel> menu = [];
  int _selectedIndex = 0;

  MenuModel();

  List<MenuItemModel> get items => menu;

  MenuItemModel getSelected() {
    return menu[_selectedIndex];
  }

  int getSelectedIndex() {
    return _selectedIndex;
  }

  void add(MenuItemModel menuItem) {
    menu.add(menuItem);
//    notifyListeners();
  }

  void setSelected(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setMenu(List<MenuItemModel> menu) {
    this.menu = menu;
//    setSelected(0);
  }
}

class MenuItemModel extends Model {
  String name;
  List<Category> categories;

  MenuItemModel(this.name, {this.categories = const []});
}

class Category extends Model{
  bool loaded = false;
  String name;
  List<CategoryItem> items;

  Category(this.name, {this.items = const []});

  void setItems(List<CategoryItem> items) {
    this.items = items;
    notifyListeners();
  }
}

class CategoryItem extends Model {
  String name;
  String image;
  double price;
  bool loadImage = false;
  String description;

  CategoryItem(this.name, this.image, this.price, this.description);

  void setImage(String image) {
    this.image = image;
    loadImage = true;
    notifyListeners();
  }
}
