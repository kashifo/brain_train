import 'package:brain_train/components/home_grid_item.dart';
import 'package:brain_train/screens/about_screen.dart';
import 'package:brain_train/screens/empty_screen.dart';
import 'package:brain_train/sub_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/commons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('username');

    if (userName != null && userName!.isNotEmpty) {
      setState(() {
        userName;
      });
    } else {
      showUserNameDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(statusBarColor: Colors.green),
        child: Column(
          children: [
            Container(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4, 1.0],
                colors: [Colors.green, Colors.blue],
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 30, right: 30),
              leading: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.2))
                  ],
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/icons/brain_train_logo_wbg_512px.jpg'),
                ),
              ),
              title: Text(
                'Welcome to Brain Train',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              subtitle: InkWell(
                onTap: () {
                  showUserNameDialog(context);
                },
                child: Text(
                  userName ?? 'Click to set your name',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                  padding: EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GridView.extent(
                      shrinkWrap: true,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      maxCrossAxisExtent: 200,
                      children: [
                        gridItem(context, 'Memory', Colors.green),
                        gridItem(context, 'Imagination', Colors.blue),
                        gridItem(context, 'Attention', Colors.orange),
                        gridItem(context, 'Math', Colors.red),
                        gridItem(context, 'Scores', Colors.green),
                        gridItem(context, 'About', Colors.cyan),
                        gridItem(context, 'History', Colors.indigoAccent),
                        gridItem(context, 'Feedback', Colors.red),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
      ),
    );
  } //build

  Future<void> showUserNameDialog(BuildContext context) async {
    String? valueText;

    saveInput() {
      if (!isNullOrEmpty(valueText)) {
        valueText = valueText!.trim();
        savePrefString('username', valueText!);

        setState(() {
          userName = valueText!;
        });

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your name can\'t be empty'),
        ));
      }
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'What should we call you?',
              style: TextStyle(fontSize: 18),
            ),
            content: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                setState(() {
                  valueText = value.toString();
                });
              },
              onSubmitted: (value) {
                valueText = value;
                saveInput();
              },
              decoration: const InputDecoration(
                  hintText: "Enter your name here",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.white,
                textColor: Colors.green,
                child: const Text('SAVE'),
                onPressed: () {
                  saveInput();
                },
              ),
            ],
          );
        });
  }
}

InkWell gridItem(BuildContext context, String title, Color iconColor) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        switch (title) {
          case 'Memory' || 'Imagination' || 'Attention' || 'Math':
            return SubHomeScreen(
                appBarTitle: title,
                iconColor: iconColor);
          case 'About':
            return AboutScreen(appBarTitle: title);
          default:
            return EmptyScreen(appBarTitle: title);
        }
      }));
    },
    child: getHomeGrid(title, iconColor),
  );
} //gridItem
