import 'package:brain_train/screens/about_screen.dart';
import 'package:brain_train/screens/empty_screen.dart';
import 'package:brain_train/jigsaw/jigsaw_demo.dart';
import 'package:brain_train/screens/find_the_no.dart';
import 'package:brain_train/screens/find_the_pair.dart';
import 'package:brain_train/screens/math_basic.dart';
import 'package:brain_train/screens/repeat_the_no.dart';
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

    if(userName!=null && userName!.isNotEmpty) {
      setState(() {
        userName;
      });
    }else {
      showUserNameDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                // borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50))
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 30, right: 30),
                title: Text(
                  'Welcome to Brain Train',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                subtitle: InkWell(
                  onTap: (){
                    showUserNameDialog(context);
                  },
                  child: Text(
                    userName??'Click to set your name',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/icons/brain_train_logo_wbg_512px.jpg'),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 28,
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
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
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
                            gridItem(context, 'Human Calculator', Icons.add, Colors.red),
                            gridItem(context, 'Classic Puzzle', Icons.join_left_rounded, Colors.pink),
                            gridItem(context, 'Repeat the Numbers', Icons.repeat_one, Colors.blue),
                            gridItem(context, 'Find the Number', Icons.remove_red_eye, Colors.blue),
                            gridItem(context, 'Find the Pair', Icons.search, Colors.cyan),
                            gridItem(context, 'Remember the Path', Icons.route_sharp, Colors.blue),
                            gridItem(context, 'Attention', Icons.calendar_month, Colors.orange),
                            gridItem(context, 'Scores', Icons.score, Colors.green),
                            gridItem(context, 'About', Icons.info_outline, Colors.cyan),
                            gridItem(context, 'History', Icons.history, Colors.indigoAccent),
                            gridItem(context, 'Feedback', Icons.feedback_outlined, Colors.red),
                          ],
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }//build

  Future<void> showUserNameDialog(BuildContext context) async {
    String? valueText;

    saveInput(){
      if( !isNullOrEmpty(valueText) ) {
        valueText = valueText!.trim();
        savePrefs('username', valueText!);

        setState(() {
          userName = valueText!;
        });

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your name can\'t be empty'),));
      }
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('What should we call you?', style: TextStyle(fontSize: 18),),
            content: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,

              onChanged: (value) {
                setState(() {
                  valueText = value.toString();
                });
              },

              onSubmitted: (value){
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

  Future<void> savePrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

}

InkWell gridItem(BuildContext context, String title, IconData iconData, Color iconColor) {
  return InkWell(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {

                switch(title){
                  case 'Human Calculator':
                    return MathBasic(appBarTitle: title);
                  case 'Classic Puzzle':
                    return JigsawDemo(appBarTitle: title);
                  case 'Repeat the Numbers':
                    return RepeatNo(appBarTitle: title);
                  case 'Find the Number':
                    return FindTheNo(appBarTitle: title);
                  case 'Find the Pair':
                    return FindThePair(appBarTitle: title);
                  case 'About':
                    return AboutScreen(appBarTitle: title);
                  default:
                    return EmptyScreen(appBarTitle: title);
                }

              }
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
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    ),
  );
}//gridItem

