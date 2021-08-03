import 'package:flutter/material.dart';

class SkeletonScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  const SkeletonScaffold({Key? key, required this.body,required this.title}) : super(key: key, );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
        ),
        body: body,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Game'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/first',
                  );
                },
              ),
              ListTile(
                title: const Text('Other'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/second',
                  );
                },
              ),
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
