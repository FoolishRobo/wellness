import 'package:flutter/cupertino.dart';

class Size {
  BuildContext context;
  Size(this.context);

  double width() {
    return MediaQuery.of(context).size.width;
  }

  double height() {
    return MediaQuery.of(context).size.height;
  }
}
