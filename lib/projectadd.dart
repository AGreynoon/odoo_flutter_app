import 'package:flutter/material.dart';
import 'package:odoo/main.dart';
import 'package:odoo/navdrawer.dart';
import 'package:odoo/readproject.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

String nameProject = '';

class fourRoute extends StatelessWidget {
  const fourRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Add projects'),
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

  final orpc = OdooClient('http://http://31.220.95.199:8069/');
  TextEditingController NameProjectController = TextEditingController();

  Future<dynamic> check() async{
    await orpc.authenticate('test_wan', name, pass);
  }

  Future<dynamic> CreateProject(String nameproject) async{
    return orpc.callKw({
      'model': 'project.project',
      'method': 'create',
      'args': [{
        'name': nameproject,
      }],
      'kwargs': {},
    });
  }

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
              child: const Text('Add project to Odoo', style: TextStyle(fontSize: 20),)
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: NameProjectController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Project Name'
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Create Project'),
                onPressed: () async{
                  nameProject = NameProjectController.text;
                  await check();
                  await CreateProject(nameProject);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FiveRoute()));
                },
              )
          ),
        ],
      ),
    );
  }
}

