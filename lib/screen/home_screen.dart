import 'package:flutter/material.dart';
import 'package:to_do_app_android/helpers/drawer_navigation.dart';
import 'package:to_do_app_android/screen/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do list'),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  async {Navigator.of(context).push(MaterialPageRoute(builder: (context) => TodoScreen()));
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
