import 'package:flutter/material.dart';

class RelaxPage extends StatefulWidget {
  const RelaxPage({Key? key}) : super(key: key);

  @override
  State<RelaxPage> createState() => _RelaxPageState();
}

class _RelaxPageState extends State<RelaxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.deepPurple.shade200,
            leading: const Icon(Icons.menu),
            //title: const Text('SliverAppBar'),
            expandedHeight: 300,
            //the floating property helps whenever you scroll and stop you see the navbar
            floating: true,
            //pinned shows the navbar as you scroll
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Relax friends'),
              centerTitle: true,
              background: Image.asset('assets/chat_image.jpg',
                fit: BoxFit.fitWidth,
                width: 50,height: 50,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,

                  color: Colors.deepPurple.shade200,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 300,
                  color: Colors.deepPurple.shade200,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Colors.deepPurple.shade200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
