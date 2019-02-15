import 'package:flutter/material.dart';
import 'package:imenu_mobile/menu_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MenuModel>(
        builder: (context, child, menu) =>
            ListView(children: buildListItem(menu)));
  }
}

List<Text> buildListItem(MenuModel menuModel) {
  return menuModel
      .getSelected()
      .categories
      .map((category) => Text(category.name))
      .toList();
}
