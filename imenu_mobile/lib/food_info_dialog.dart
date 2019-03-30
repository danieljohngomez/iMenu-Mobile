import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imenu_mobile/menu_model.dart';

class FoodInfoDialog extends AlertDialog {
  FoodInfoDialog(CategoryItem item, BuildContext context)
      : super(
            title: new Text(item.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IntrinsicHeight(
                  child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      placeholder: (context, s) =>
                          new CircularProgressIndicator(),
                      imageUrl: item.image),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  item.name,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("P${item.price}"),
                Visibility(
                  child: SizedBox(
                    height: 12,
                  ),
                  visible: item.description != null,
                ),
                Visibility(
                  child: Text(item.description == null ? "" : item.description,
                      style: TextStyle(fontSize: 16)),
                  visible: item.description != null,
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]);
}
