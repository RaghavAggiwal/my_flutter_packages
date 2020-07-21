import 'package:flutter/material.dart';

Widget myAppBarWidget(BuildContext context, title, {List<Widget> actions: const [], Widget bottom}) {
  return AppBar(
      title: Text(
          title,
          style: Theme.of(context).textTheme.headline5
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      actions: actions,
      bottom: bottom
  );
}