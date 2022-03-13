import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  
  final String name;
  final onPress;
  final assetImage;

  const ButtonWithIcon(this.name, this.assetImage, this.onPress);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        splashColor: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
              image: assetImage,
              height: 30,
            ),
            const SizedBox(width: 12.0),
            Text(
              name,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        onPressed: onPress);
  }
}
