import 'package:flutter/material.dart';
import 'package:odoo/respartnerpage.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

final orpc = OdooClient('http://http://31.220.95.199:8069/');
String name = '';
String pass = '';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Sample odoo Api';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int count = 0;

  void _incrementCounter() async{
    setState(() {
      count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text('Odoo Api with Flutter By Marouf',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 30),)
      ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text('Sign in', style: TextStyle(fontSize: 20),)
            ),
      Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'User Name'
          ),
        ),
      ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () async{
                print(nameController.text);
                print(passwordController.text);
                count = 0;
                try{
                  final x = orpc.authenticate("test_wan", nameController.text, passwordController.text);
                  name = nameController.text;
                  pass = passwordController.text;
                  count = 0;
                  print(x);
                }on OdooException catch(e){
                  print(count);
                  print('--------------------------------- catch');
                }
                finally{
                  print('aefaefwaef---------dawdawda------awdadaw-adwada');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdRoute()));
                }
              },
            )
          ),
        ],
      ),
    );
  }
}


