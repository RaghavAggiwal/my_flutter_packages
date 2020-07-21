import 'package:flutter/material.dart';

Widget myAppBarWidget(BuildContext context, title, {List<Widget> actions: const [], Widget bottom}) {
  return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: actions,
      bottom: bottom
  );
}