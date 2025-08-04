import 'package:flutter/material.dart';
import 'package:todo_bloc/post/components/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M E"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
    );
  }
}
