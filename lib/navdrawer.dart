import 'package:flutter/material.dart';
import 'package:odoo/loginpage.dart';
import 'package:odoo/product.dart';
import 'package:odoo/readproject.dart';
import 'package:odoo/respartnerpage.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Odoo Api with Flutter', style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              title: const Text('Contacts'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ThirdRoute()));
              },
            ),
            ListTile(
              title: const Text('Projects'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>fiveRoute()));
              },
            ),
            ListTile(
              title: const Text('Prducts'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>sixRoute()));
              },
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const SecondRoute()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
