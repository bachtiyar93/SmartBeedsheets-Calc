import 'package:bedsheet_calc/sample.dart';
import 'package:bedsheet_calc/spreiBcKomplit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Management',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: DashBoardPage(),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List<Color> _backgroundColor;
  Color _iconColor;
  Color _textColor;
  List<Color> _actionContainerColor;
  Color _borderContainer;
  bool colorSwitched = false;
  var logoImage;

  TextEditingController ukuranController = new TextEditingController();

  void changeTheme() async {
    if (colorSwitched) {
      setState(() {
        logoImage = 'assets/images/ic_logo.png';
        _backgroundColor = [
          Color.fromRGBO(252, 214, 0, 1),
          Color.fromRGBO(251, 207, 6, 1),
          Color.fromRGBO(250, 197, 16, 1),
          Color.fromRGBO(249, 161, 28, 1),
        ];
        _iconColor = Colors.white;
        _textColor = Color.fromRGBO(253, 211, 4, 1);
        _borderContainer = Color.fromRGBO(34, 58, 90, 0.2);
        _actionContainerColor = [
          Color.fromRGBO(47, 75, 110, 1),
          Color.fromRGBO(43, 71, 105, 1),
          Color.fromRGBO(39, 64, 97, 1),
          Color.fromRGBO(34, 58, 90, 1),
        ];
      });
    } else {
      setState(() {
        logoImage = 'assets/images/ic_logo.png';
        _borderContainer = Color.fromRGBO(252, 233, 187, 1);
        _backgroundColor = [
          Color.fromRGBO(249, 249, 249, 1),
          Color.fromRGBO(241, 241, 241, 1),
          Color.fromRGBO(233, 233, 233, 1),
          Color.fromRGBO(222, 222, 222, 1),
        ];
        _iconColor = Colors.black;
        _textColor = Colors.black;
        _actionContainerColor = [
          Color.fromRGBO(255, 212, 61, 1),
          Color.fromRGBO(255, 212, 55, 1),
          Color.fromRGBO(255, 211, 48, 1),
          Color.fromRGBO(255, 211, 43, 1),
        ];
      });
    }
  }

  @override
  void initState() {
    changeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onLongPress: () {
            if (colorSwitched) {
              colorSwitched = false;
            } else {
              colorSwitched = true;
            }
            changeTheme();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.3, 0.5, 0.8],
                    colors: _backgroundColor)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  logoImage,
                  fit: BoxFit.contain,
                  height: 250.0,
                  width: 250.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Smart Calc Sprei & Gorden',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      'Sweet Room Medan',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: _borderContainer,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.2, 0.4, 0.6, 0.8],
                              colors: _actionContainerColor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 70,
                            child: Center(
                              child: FlatButton(
                                onPressed: igPeluncur,
                                child: ListView(
                                  children: <Widget>[
                                    Text(
                                      '1.703',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: _textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    Text(
                                      'Catalogue Ready',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: _iconColor, fontSize: 16),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          Table(
                            border: TableBorder.symmetric(
                              inside: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 0.5),
                            ),
                            children: [
                              TableRow(
                                  children: [
                                    FlatButton.icon(
                                      onPressed: () => _menuKalkulator(context),
                                      icon:  _actionList('assets/images/ic_bed.png', 'Bedheets Calc'),
                                      label: Text(''),

                                    ),
                                    FlatButton.icon(
                                      onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RadioButton()));
                                      },
                                      icon:   _actionList('assets/images/ic_curtains.png', 'Curtains Calc'),
                                      label: Text(''),

                                    ),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    FlatButton.icon(
                                      onPressed: () {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (context) => faktur()));
                                      },
                                      icon:   _actionList('assets/images/ic_transact.png', 'Library'),
                                      label: Text(''),

                                    ),
                                    FlatButton.icon(
                                      onPressed: () {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (context) => faktur()));
                                      },
                                      icon:    _actionList('assets/images/ic_reward.png', 'Top Brand'),
                                      label: Text(''),
                                    ),
                                  ]
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionList(String iconPath, String desc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            iconPath,
            fit: BoxFit.contain,
            height: 45.0,
            width: 45.0,
            color: _iconColor,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: TextStyle(color: _iconColor),
          )
        ],
      ),
    );
  }

  igPeluncur()  async {
      const url = 'https://www.instagram.com/sweetroommedan/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

  //Mulai ke Menu
  _menuKalkulator(BuildContext context) {
    final flatButtonColor = Colors.deepPurple;
    print('Panggi Faktur');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height*0.3,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Text(
                  'What do you need?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                FlatButton(
                  color: Colors.yellow,
                  onPressed: () {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Option'),
                          content: Container(
                              height: MediaQuery.of(context).size.height*0.3,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Center(
                                child: Container(
                                  child: Wrap(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.yellow,
                                        onPressed: () {},
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        textColor: flatButtonColor,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text('Custome Advanced',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        color: Colors.yellow,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => SpreiCalc()));

                                        },
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        textColor: flatButtonColor,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text('Standart Size',
                                          textAlign: TextAlign.center,
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          actions: <Widget>[
                            FlatButton(
                              textColor: flatButtonColor,
                              child: Text('cancle',),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  textColor: flatButtonColor,
                  child: Text('Sprei Set (Complete) Recomended',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                FlatButton(
                  color: Colors.yellow,
                  onPressed: () {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Option'),
                          content: Container(
                              height: MediaQuery.of(context).size.height*0.17,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Center(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.yellow,
                                        onPressed: () {},
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        textColor: flatButtonColor,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text('Custome Advanced',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        color: Colors.yellow,
                                        onPressed: () {},
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        textColor: flatButtonColor,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text('Standart Size',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          actions: <Widget>[
                            FlatButton(
                              textColor: flatButtonColor,
                              child: Text('cancle',),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  textColor: flatButtonColor,
                  child: Text('Cover Only (Pillow Cover & Bolster Cover)',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                FlatButton(
                  color: Colors.yellow,
                  onPressed: () {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Option'),
                          content: Container(
                              height: MediaQuery.of(context).size.height*0.17,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Center(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.yellow,
                                        onPressed: () {},
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        textColor: flatButtonColor,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text('Custome Advanced',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        color: Colors.yellow,
                                        onPressed: () {},
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        textColor: flatButtonColor,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text('Standart Size',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          actions: <Widget>[
                            FlatButton(
                              textColor: flatButtonColor,
                              child: Text('cancle',),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  textColor: flatButtonColor,
                  child: Text('Pillow & Bolster Only',
                  ),
                ),
              ],
            ),
          );
        });
  }
}