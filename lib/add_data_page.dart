import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/list_map_provider.dart';

class AddDataPage extends StatelessWidget {
  const AddDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add note"),
      ),
      body: Center(
        child: IconButton(onPressed: (){
          context.read<ListMapProvider>().addData({
            "name": "my contact ",
            "email": "alam@gmail,com",
          });
        }, icon: Icon(Icons.add)),
      ),
    );
  }
}
//context.read<ListMapProvider>().addData({
//             "name": "my contact ",
//             "email": "alam@gmail,com",
//           });