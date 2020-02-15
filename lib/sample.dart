
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Radio Button Group Example"),
          ),
          body: SafeArea(
              child : Center(

                child:RadioGroup(),

              )
          )
      ),
    );
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class FruitsList {
  String name;
  int index;
  FruitsList({this.name, this.index});
}

class RadioGroupWidget extends State {

  // Default Radio Button Item
  String radioItem = 'Sprei Set';
  String radioItem2 = 'Sprei Set';

  // Group Value for Radio Button.
  int id = 1;
  int id2 = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Sprei Set",
    ),
    FruitsList(
      index: 2,
      name: "Pillow & Bolster Cover Only",
    ),
    FruitsList(
      index: 3,
      name: "Pillow Cover Only",
    ),
    FruitsList(
      index: 4,
      name: "Bolster Cover Only",
    ),
  ];
  List<FruitsList> produkBC = [
    FruitsList(
      index: 1,
      name: "ya",
    ),
    FruitsList(
      index: 2,
      name: "tidak",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 23))
        ),

        Expanded(
            child: Container(
              height: 350.0,
              child: Column(
                children:
                fList.map((data) => RadioListTile(
                  title: Text("${data.name}"),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      radioItem = data.name ;
                      id = data.index;
                    });
                  },
                )).toList(),
              ),
            )),
        Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('Bedcover', style: TextStyle(fontSize: 23))
        ),
        Expanded(
            child: Container(
              height: 350.0,
              child: Column(
                children:
                produkBC.map((data) => RadioListTile(
                  title: Text("${data.name}"),
                  groupValue: id2,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      radioItem2 = data.name ;
                      id2 = data.index;
                    });
                  },
                )).toList(),
              ),
            )
        )

      ],
    );
  }
}