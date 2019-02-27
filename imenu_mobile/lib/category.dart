import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imenu_mobile/menu_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuPageState();
  }
}

class MenuPageState extends State<MenuPage>
    with AutomaticKeepAliveClientMixin<MenuPage> {
  bool loading = true;

  MenuModel menuModel = new MenuModel();

  final FirebaseStorage storage = FirebaseStorage(
      app: FirebaseApp.instance, storageBucket: "gs://imenu-59599.appspot.com");

  @override
  void initState() {
    Firestore.instance
        .collection("menu")
        .getDocuments()
        .then((menuSnapshot) async {
      var documents = menuSnapshot.documents;
      List<QuerySnapshot> allCategoryDocuments = [];
      for (var document in documents) {
        var categoryDocuments =
            await document.reference.collection("categories").getDocuments();
        allCategoryDocuments.add(categoryDocuments);
      }

      List<Category> categories = [];
      for (var response in allCategoryDocuments) {
        for (var category in response.documents) {
          var categoryModel = new Category(category["name"]);
          categories.add(categoryModel);

          category.reference
              .collection("items")
              .getDocuments()
              .then((items) async {
            List<CategoryItem> categoryItems = [];
            for (var item in items.documents) {
              var itemModel = new CategoryItem(
                  item["name"], item["image"], item["price"] + .0);
              categoryItems.add(itemModel);

              var url =
                  await storage.ref().child(itemModel.image).getDownloadURL();
              itemModel.image = url;
              itemModel.loadImage = true;
            }
            categoryModel.loaded = true;
            print("Loaded category items for category " + categoryModel.name);
            categoryModel.setItems(categoryItems);
          });
        }
      }
      setState(() {
        loading = false;
        menuModel.add(new MenuItemModel("aaa", categories: categories));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? Center(child: CircularProgressIndicator())
        : new ListView(
            padding: EdgeInsets.all(16), children: buildListItem(menuModel));
  }

  @override
  bool get wantKeepAlive => true;
}

List<Widget> buildListItem(MenuModel menuModel) {
  return menuModel.items
      .expand((menuItemModel) => menuItemModel.categories)
      .map((category) {
    return ScopedModel<Category>(
        model: category,
        child:
            ScopedModelDescendant<Category>(builder: (context, child, model) {
          if (model.loaded && model.items.isEmpty) return SizedBox();
          return new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new SizedBox(
                  height: 20,
                ),
                Text(
                  model.name,
                  style: TextStyle(fontSize: 20),
                ),
                new SizedBox(height: 10),
                buildCategoryList(model),
              ]);
        }));
  }).toList();
}

Widget buildCategoryList(Category model) {
  if (!model.loaded) return Center(child: CircularProgressIndicator());
  if (model.items.isEmpty)
    return Container(
      height: 10,
    );
  return Container(
    height: 200,
    child: new ListView(
      key: Key(model.name),
      scrollDirection: Axis.horizontal,
      children: buildCategory(model),
    ),
  );
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
          categoryItem.loadImage
              ? Expanded(
                  child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  placeholder: (context, s) => new CircularProgressIndicator(),
                  imageUrl: categoryItem.image,
                ))
              : new CircularProgressIndicator(),
          new SizedBox(
            height: 10,
          ),
          new Text(
            categoryItem.name,
            style: TextStyle(fontSize: 18),
          ),
          new Text(
            "P${categoryItem.price}",
            style: TextStyle(fontSize: 16),
          ),
          new SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}
