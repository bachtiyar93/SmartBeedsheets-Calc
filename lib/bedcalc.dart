import 'dart:async';
import 'dart:convert';
import 'package:bedsheet_calc/bahasa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types
class kalkulatorSprei extends StatefulWidget {
  @override
  _kalkulatorSpreiState createState() => _kalkulatorSpreiState();
}

// ignore: camel_case_types
class _kalkulatorSpreiState extends State<kalkulatorSprei> {
  static const snackBarDuration = Duration(seconds: 3);
  final snackBar = SnackBar(
    content: Text('Press back again to leave',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold),),
    duration: snackBarDuration,
  );
  // ignore: close_sinks
  StreamController<List<listDataServer>> _dataController =
  new StreamController<List<listDataServer>>.broadcast();

  @override
  void initState() {
    super.initState();
    setState(() {
      logoImage = 'assets/images/ic_logo.png';
    });
    loadDataServer();
  }
var logoImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bedsheets Calc"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<listDataServer>>(
          stream: _dataController.stream,
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: 100,
                height: 100,
                child: Center(
                            child: Wrap(
                              children: <Widget>[
                                Center( child:
                                  Image.asset(
                                    logoImage,
                                    fit: BoxFit.contain,
                                    height: 200.0,
                                    width: 200.0,
                                  ),),
                                Center(
                                  child: CircularProgressIndicator()
                                    ),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.03,
                                  ),
                                Center(child: Text("Load data from server..")
                                 )
                                  ],
                            )
                          ),
            );
            } else {
              return UserPopulate(listHarga: snapshot.data);
            }
          },
        ),
      ),
    );
  }

  loadDataServer() async {
    await ambilData().then((result) {
      _dataController.sink.add(result);
    });
  }

  Future<List<listDataServer>> ambilData() async {
    final response = await http.post(SumberApi.dataHarga,
    body:{"metode":"1",});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return compute(parseHarga, response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  static List<listDataServer> parseHarga(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<listDataServer>((json) => listDataServer.fromJson(json))
        .toList();
  }
}
// ignore: camel_case_types
class listDataServer {
  String jenis;
  String item;
  String harga;
  String grosir;


  listDataServer({
    this.jenis,
    this.item,
    this.harga,
    this.grosir,
  });

  factory listDataServer.fromJson(Map<String, dynamic> json) => new listDataServer(
    jenis: json["jenis"],
    item: json["item"],
    harga: json["harga"],
    grosir: json["grosir"],
  );

  Map<String, dynamic> toJson() => {
    "jenis": jenis,
    "item": item,
    "harga": harga,
    "grosir": grosir,
  };
}

// ignore: must_be_immutable
class UserPopulate extends StatefulWidget {
  List<listDataServer> listHarga;
  UserPopulate({Key key, this.listHarga}) : super(key: key);

  @override
  _UserPopulateState createState() => _UserPopulateState();
}


class _UserPopulateState extends State<UserPopulate> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index)
      {return
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin:
                  const EdgeInsets.only(left: 30.0, right: 30.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          color: Colors.green,
                          onPressed: () {},
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: new Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Bedcover Only",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 30.0, right: 30.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          color: Colors.green,
                          onPressed: () {},
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: new Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Sprei set + Bedcover (Complete)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 30.0, right: 30.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          color: Colors.indigo,
                          onPressed: () {},
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: new Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Sprei Set Only (Sprei+Sarung Bantal)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
          );
      },
    );
  }
}