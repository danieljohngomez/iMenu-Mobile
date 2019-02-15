import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';

class MenuModel extends Model {
  final List<MenuItemModel> menu;
  int _selectedIndex = 0;

  MenuModel({this.menu = const []});

  UnmodifiableListView<MenuItemModel> get items => UnmodifiableListView(menu);

  MenuItemModel getSelected() {
    return menu[_selectedIndex];
  }

  int getSelectedIndex() {
    return _selectedIndex;
  }

  void add(MenuItemModel menuItem) {
    menu.add(menuItem);
    notifyListeners();
  }

  void setSelected(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class MenuItemModel extends Model {
  String name;
  List<Category> categories;

  MenuItemModel(this.name, {this.categories = const []});
}

class Category {
  String name;
  List<CategoryItem> items;

  Category(this.name, {this.items = const []});
}

class CategoryItem {
  String name;
  String image;
  double price;

  CategoryItem(this.name, this.image, this.price);
}
