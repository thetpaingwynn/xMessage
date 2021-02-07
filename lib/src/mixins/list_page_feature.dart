import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef Future<dynamic> FutureAction();

mixin ListPageFeature<T extends StatefulWidget> on State<T> {
  bool inAsyncCall = false;

  Future<bool> progressCall(FutureAction call) async {
    try {
      setState(() => inAsyncCall = true);
      await call();
      setState(() => inAsyncCall = false);
      return true;
    } catch (e) {
      setState(() => inAsyncCall = false);
      return false;
    }
  }

  Future<bool> confirm(String message) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(message, style: Theme.of(context).textTheme.headline6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Yes', style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  RaisedButton(
                    child: Text('No'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
    );
    return result ?? false;
  }

  void showMessage(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(MdiIcons.informationOutline, color: Colors.green),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  void showError(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(MdiIcons.alertOutline, color: Theme.of(context).errorColor),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
