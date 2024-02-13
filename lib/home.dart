import 'package:brain_train/jigsaw/jigsaw_demo.dart';
import 'package:brain_train/jigsaw/jigsaw_screen.dart';
import 'package:brain_train/math_basic.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50))),
            child: const ListTile(
              contentPadding: EdgeInsets.only(left: 30, right: 30),
              title: Text(
                'Welcome',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              subtitle: Text(
                'Mr Kashif!',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/kashif_fizz.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GridView.extent(
                        shrinkWrap: true,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        maxCrossAxisExtent: 200,
                        children: [
                          gridItem(context, 'Maths', Icons.add, Colors.red),
                          gridItem(context, 'Puzzle', Icons.bug_report, Colors.pink),
                          gridItem(context, 'Find Pairs', Icons.search, Colors.cyan),
                          gridItem(context, 'Memory', Icons.people, Colors.blue),
                          gridItem(
                              context, 'Attention', Icons.calendar_month, Colors.orange),
                          gridItem(context, 'Scores', Icons.score, Colors.green),
                          gridItem(context, 'About', Icons.info_outline, Colors.cyan),
                          gridItem(
                              context, 'History', Icons.history, Colors.indigoAccent),
                          gridItem(
                              context, 'Feedback', Icons.feedback_outlined, Colors.red),
                        ],
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

InkWell gridItem(BuildContext context, String title, IconData iconData, Color iconColor) {
  return InkWell(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const JigsawDemo()
          ));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.2))
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor),
              child: Icon(
                iconData,
                color: Colors.white,
                size: 25,
              )),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
          )
        ],
      ),
    ),
  );
}
