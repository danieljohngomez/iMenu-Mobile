import 'package:flutter/material.dart';
import 'package:imenu_mobile/menu_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MenuModel>(
        builder: (context, child, menu) => new ListView(
            padding: EdgeInsets.all(16), children: buildListItem(menu)));
  }
}

List<Widget> buildListItem(MenuModel menuModel) {
  return menuModel
      .items
      .expand((menuItemModel) => menuItemModel.categories)
      .map((category) =>
          new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            new SizedBox(
              height: 20,
            ),
            Text(
              category.name,
              style: TextStyle(fontSize: 20),
            ),
            new SizedBox(height: 10),
            Container(
              height: 200,
              child: new ListView(
                key: Key(category.name),
                scrollDirection: Axis.horizontal,
                children: buildCategory(category),
              ),
            ),
          ]))
      .toList();
}

List<Widget> buildCategory(Category category) {
  return category.items
      .map((categoryItem) => buildCategoryItem(categoryItem))
      .toList();
}

Widget buildCategoryItem(CategoryItem categoryItem) {
  return Container(
    width: 200,
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  placeholder: (context, s) => new CircularProgressIndicator(),
                  imageUrl: 'https://picsum.photos/250?image=9',
                )),
            new SizedBox( height: 10,),
            new Text(categoryItem.name, style: TextStyle(fontSize: 18),),
            new Text("P${categoryItem.price}", style: TextStyle(fontSize: 16),),
            new SizedBox( height: 10,),
          ],
        ),
      ),
  );
}
