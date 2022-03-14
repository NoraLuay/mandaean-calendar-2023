import 'package:flutter/cupertino.dart';

class DateLegend extends StatelessWidget {
    final String name;
    final int hexColor;
    
    const DateLegend(this.name, this.hexColor);
    
    @override
    Widget build(BuildContext context) {
        return ListView(
            shrinkWrap: true,
            children: <Widget>[
                Row(
                    children: <Widget>[
                        Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Color(0xFF4788C7)),
                                color: Color(hexColor),
                            ),
                        ),
                        SizedBox(width: 12.0),
                        Text(name,
                            style: TextStyle(fontSize: 16.0)),
                    ]
                ),
            ],
        );
    }
}