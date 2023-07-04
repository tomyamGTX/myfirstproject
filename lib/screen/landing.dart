import 'package:flutter/material.dart';
import 'package:testproject/screen/home.dart';

import '../components/body.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.tealAccent,
      key: _scaffoldKey,
      endDrawer: const Drawer(),
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("This is appbar"),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: const BodyComponent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home())),
        label: const Text("Next"),
        icon: const Icon(Icons.navigate_next_sharp),
      ),
    ));
  }
}
