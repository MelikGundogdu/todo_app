import 'package:flutter/material.dart';
import 'package:to_do_app_android/screen/categories_screen.dart';
import 'package:to_do_app_android/screen/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
               backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2022/05/05/20/01/australian-shepherd-7176981_960_720.jpg'),
              ),
                accountName: Text('test'),
                accountEmail: Text('admin,admin'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> HomeScreen())
              ),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> CategoriesScreen())
              ),
            ),

          ],
       ),
      ),
    );

  }
}
