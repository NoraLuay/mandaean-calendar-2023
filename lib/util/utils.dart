import 'package:flutter/cupertino.dart';

class MyScrollBehavior extends ScrollBehavior {
    @override
    Widget buildOverscrollIndicator(
        BuildContext context, Widget child, ScrollableDetails details) {
        return child;
    }
}