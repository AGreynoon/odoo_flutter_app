import 'package:flutter/material.dart';
import 'package:odoo/main.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class ThirdRoute extends StatelessWidget {
  ThirdRoute({Key? key}) : super(key: key);

  final orpc = OdooClient('http://31.220.95.199:8069/');

  Future<dynamic> check() async{
    await orpc.authenticate('wan1', name, pass);
  }

  Future<dynamic> fetchContacts() async{
    await check();
    return orpc.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['id', 'name', 'email', '__last_update', 'image_128'],
        'limit': 80,
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    //check();
    var unique = record['__last_update'] as String;
    unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    final avatarUrl =
        '${orpc.baseURL}/web/image?model=res.partner&field=image_128&id=${record["id"]}&unique=$unique';
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      title: Text(record['name']),
      subtitle: Text(record['email'] is String ? record['email'] : ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Center(
        child: FutureBuilder(
            future: fetchContacts(),
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
                  return const Text('Password or Email is Not Correct Try Again !');
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
