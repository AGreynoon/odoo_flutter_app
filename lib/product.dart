import 'package:flutter/material.dart';
import 'package:odoo/main.dart';
import 'package:odoo/navdrawer.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class sixRoute extends StatelessWidget {
  sixRoute({Key? key}) : super(key: key);

  final orpc = OdooClient('http://31.220.95.199:8069/');

  Future<dynamic> check() async{
    await orpc.authenticate('wan1', name, pass);
  }

  Future<dynamic> fetchProduct() async{
    await check();
    return orpc.callKw({
      'model': 'product.template',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['id', 'name', 'list_price', 'qty_available', 'image_128'],
        'limit': 80,
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    //check();
    return ListTile(
      //leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      title: Text(record['name']),
      subtitle: Text(record['list_price'] is String ? record['list_price'] : ''),
      //subtitle: Text(record['list_price']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('products'),
      ),
      body: Center(
        child: FutureBuilder(
            future: fetchProduct(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record =
                      snapshot.data[index] as Map<String, dynamic>;
                      return buildListItem(record);
                    });
              } else {
                if (snapshot.hasError)
                  //Navigator.of(context).pop();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute()));
                  const Text('Password or Email is Not Correct Try Again !');
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
