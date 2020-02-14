import 'dart:convert';
import 'package:bedsheet_calc/bahasa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class spreiBcKomplit extends StatefulWidget {
  spreiBcKomplit({Key key}) : super(key: key);

  @override
  _spreiBcKomplitState createState() => _spreiBcKomplitState();
}
class _spreiBcKomplitState extends State<spreiBcKomplit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController orderController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();
  TextEditingController customerController =new TextEditingController();
  TextEditingController rincianController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController bahanController = new TextEditingController();
  TextEditingController sizeController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();


  List<String> _jenisTinggi = ["20","25","30","35","40","45"];
  String _selectedTinggi;
  List<String> _jenisBahan = ['Emboss', 'Katun CVC (Lokal)', 'Katun Jepang', 'Sutra Organik', 'Sutra Silk Thick','Sutra Silk Thin', 'Serat Bamboo','KingKoil','Panel (Jepang)'];
  String _selectedBahan;
  List<String> _jenisSize = ['3K 100x200', '4K 120x200', '5K 160x200', '6K 180x200', '7K 200x200'];
  String _selectedSize;
  List<String> _model = ['Karet', 'Rimpel'];
  String _selectedmodel;
  double hargaCount, untung=0.35, sizenya,upahJahitBC, bedcover ,hargaBC,
      hargaKain, hargaModel, tas=6000, upahJahit, pakaiKain, pakaiKainBC;
  var bantalSpek;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standar Size (Sprei Set + Bedcover)'),),
      body:
      Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new TextFormField(
                          validator: (e) {
                          if (e.isEmpty) {
                            return "Please Insert Name";
                          }
                          return null;
                        },
                          controller: customerController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (e) {},
                          decoration: new InputDecoration(
                              labelText: "Customer",
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new DropdownButton(
                          hint: Text('Fabric'), // Not necessary for Option 1
                          value: _selectedBahan,
                          onChanged: (bon)
                          {
                            setState(() {
                              _selectedBahan = bon;
                              bahanController.text=_selectedBahan;
                            });
                          } ,
                          items: _jenisBahan.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new DropdownButton(
                          hint: Text('Model'), // Not necessary for Option 1
                          value: _selectedmodel,
                          onChanged: (model)
                          {
                            setState(() {
                              _selectedmodel = model;
                              modelController.text=_selectedmodel;
                            });
                          } ,
                          items: _model.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new DropdownButton(
                          hint: Text('Bed Size'), // Not necessary for Option 1
                          value: _selectedSize,
                          onChanged: (bon)
                          {
                            setState(() {
                              _selectedSize = bon;
                              sizeController.text=_selectedSize;
                            });
                          } ,
                          items: _jenisSize.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new DropdownButton(
                          hint: Text('Height'), // Not necessary for Option 1
                          value: _selectedTinggi,
                          onChanged: (bon)
                          {
                            setState(() {
                              _selectedTinggi = bon;
                              heightController.text=_selectedTinggi as String;
                            });
                          } ,
                          items: _jenisTinggi.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new TextFormField(validator: (e) {
                          if (e.isEmpty) {
                            return "Value Order Can,t empty";
                          }
                          else if (e.length<1) {
                            return "Failed order (min: 1)";
                          }
                          return null;
                        },
                          controller: orderController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (e) {},
                          decoration: new InputDecoration(
                              labelText: "Order Amount",
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new TextFormField(validator: (e) {
                          if (e.isEmpty) {
                            return "Address Empty";
                          }
                          else if (e.length<10) {
                            return "Invalid Address";
                          }
                          return null;
                        },
                          controller: alamatController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (e) {},
                          decoration: new InputDecoration(
                              labelText: "Delivery Address",
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new TextFormField(
                          validator: (e) {if (e.isEmpty) {return null;}return null; },
                          controller: rincianController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (e) {},
                          decoration: new InputDecoration(
                              labelText: "Note Details (Optional)",
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            return showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                if(bahanController.text=="Emboss"){hargaKain=34000;}
                                else if(bahanController.text=="Katun CVC (Lokal)"){hargaKain=34000;}
                                else if(bahanController.text=="Katun Jepang"){hargaKain=55000;}
                                else if(bahanController.text=="Sutra Organik"){hargaKain=135000;}
                                else if(bahanController.text=="Sutra Silk Thick"){hargaKain=75000;}
                                else if(bahanController.text=="Sutra Silk Thin"){hargaKain=65000;}
                                else if(bahanController.text=="Serat Bamboo"){hargaKain=155000;}
                                else if(bahanController.text=="KingKoil"){hargaKain=125000;}
                                else if(bahanController.text=="Panel (Jepang)"){hargaKain=135000;}
                                //harga model
                                if(_selectedmodel=="Karet"){
                                  hargaModel=0;
                                }else if(_selectedmodel=="Rimpel"){
                                  if (sizeController.text=="3K 100x200"){
                                    hargaModel=(1.8*hargaKain+15000)+((1.8*hargaKain+15000)*untung);
                                  }else if (sizeController.text=="4K 120x200"){
                                    hargaModel=(1.8*hargaKain+15000)+((1.8*hargaKain+15000)*untung);
                                  }else {hargaModel=(2.4*hargaKain+20000)+((2.4*hargaKain+20000)*untung);}}
                                  //Upah jahit
                                  if (sizeController.text=="3K 100x200"){
                                    upahJahit=22500;
                                  }else if (sizeController.text=="4K 120x200"){
                                    upahJahit=22500;
                                  }else {upahJahit=25000;}
                                  //Pemakaian kain
                                  if (sizeController.text=="3K 100x200"){
                                    pakaiKainBC=3.2;
                                    upahJahitBC=25000;
                                    bantalSpek="1 Pillow Cover + 1 Bolster Cover";
                                    if(heightController.text=="20"){pakaiKain=2.3;}
                                    else if(heightController.text=="25"){pakaiKain=2.5;}
                                    else if(heightController.text=="30"){pakaiKain=2.7;}
                                    else if(heightController.text=="35"){pakaiKain=2.9;}
                                    else if (heightController.text=="40"){pakaiKain=3.1;}
                                    else {pakaiKain=3.3;}
                                  }else if (sizeController.text=="4K 120x200"){
                                    pakaiKainBC=3.6;
                                    upahJahitBC=25000;
                                    bantalSpek="1 Pillow Cover + 1 Bolster Cover";
                                    if(heightController.text=="20"){pakaiKain=2.5;}
                                    else if(heightController.text=="25"){pakaiKain=2.7;}
                                    else if(heightController.text=="30"){pakaiKain=2.9;}
                                    else if(heightController.text=="35"){pakaiKain=3.1;}
                                    else if (heightController.text=="40") {pakaiKain=3.3;}
                                    else {pakaiKain=3.5;}
                                  }else if (sizeController.text=="5K 160x200"){
                                    pakaiKainBC=4.4;
                                    upahJahitBC=30000;
                                    bantalSpek="2 Pillow Cover + 1 Bolster Cover";
                                    if(heightController.text=="20"){pakaiKain=4.0;}
                                    else if(heightController.text=="25"){pakaiKain=4.2;}
                                    else if(heightController.text=="30"){pakaiKain=4.4;}
                                    else if(heightController.text=="35"){pakaiKain=4.6;}
                                    else if (heightController.text=="40"){pakaiKain=4.8;}
                                    else {pakaiKain=5;}
                                  }else if (sizeController.text=="6K 180x200"){
                                    pakaiKainBC=4.8;
                                    upahJahitBC=30000;
                                    bantalSpek="2 Pillow Cover + 2 Bolster Cover";
                                    if(heightController.text=="20"){pakaiKain=4.2;}
                                    else if(heightController.text=="25"){pakaiKain=4.4;}
                                    else if(heightController.text=="30"){pakaiKain=4.6;}
                                    else if(heightController.text=="35"){pakaiKain=4.8;}
                                    else if (heightController.text=="40"){pakaiKain=5.0;}
                                    else {pakaiKain=5.2;}
                                  }else{
                                    pakaiKainBC=5.2;
                                    upahJahitBC=30000;
                                    bantalSpek="2 Pillow Cover + 2 Bolster Cover";
                                    if(heightController.text=="20"){pakaiKain=4.4;}
                                    else if(heightController.text=="25"){pakaiKain=4.6;}
                                    else if(heightController.text=="30"){pakaiKain=4.8;}
                                    else if(heightController.text=="35"){pakaiKain=5.0;}
                                    else if (heightController.text=="40"){pakaiKain=5.2;}
                                    else {pakaiKain=5.4;}
                                  }

                                      bedcover=pakaiKainBC*hargaKain+upahJahitBC;
                                      sizenya = pakaiKain*hargaKain+upahJahit+tas;
                                      hargaCount=(sizenya*untung+sizenya)*double.tryParse(orderController.text)+hargaModel+(bedcover*untung+bedcover);


                                return AlertDialog(
                                  title: Text('Order Details /Spesifikasi'),
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      children: <Widget>[
                                        Text("to :"+customerController.text,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text("Sprei "+bahanController.text,
                                        ),
                                        Text("Size "+sizeController.text+"x"+heightController.text+"x"+orderController.text+"Set + Bedcover"),
                                        Text("Include "+bantalSpek),
                                        Text('Model '+modelController.text),
                                        Text("Address to "+alamatController.text),
                                        Text("Best Deals :"+' Rp. '+hargaCount.toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text("Note / Details:"),
                                        Text(rincianController.text),
                                        Text(""),
                                        Text(""),
                                        Text(""),
                                        Text("We make sure the best price we have provided. Does not include postage.",
                                        textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      color: Colors.red,
                                      child: Text('Kembali'),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.green,
                                      child: Text('Order via Whatsapp'),
                                      onPressed: ()  async {
                                    var url =
                                    'https://api.whatsapp.com/send?phone=+6287749169513&text=Hallo%20saya%20'+customerController.text+
                                    '%0ASaya%20tertarik%20untuk%20memesan%20'+bahanController.text+'%20Ukuran%20'+sizeController.text+'x'+heightController.text+'%20sebanyak%20'+orderController.text+'%20Set%20+%20Bedcover'+
                                    '%0AHarga%20dari%20aplikasi%20sebesar%20Rp.'+hargaCount.toString()+
                                    '%0AAlamat%20pengantaran%20ke%20'+alamatController.text+
                                    '%0ACatatan:%20'+rincianController.text;
                                    if (await canLaunch(url)) {
                                    await launch(url);
                                    } else {
                                    throw 'Could not launch $url';
                                    }
                                    },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Count",
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
        ),
      ),
    );
  }

  check() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      prosesHitung();
    }
  }

  prosesHitung() async {
    String _customer = customerController.text;
    String _alamat = alamatController.text;
    String _rincian = rincianController.text;
    String _size = sizeController.text+"x"+heightController.text;
    String _bahan = bahanController.text;
    String _jumlahOrder = orderController.text;



    try {final response = await http.post(SumberApi.dataHarga, body: {
      "id_customer":_customer,
      "id_alamat": _alamat,
      "id_rincian":_rincian,
    });
    final data = jsonDecode(response.body);
    String pesan = data['message'];
    if (response.statusCode < 200 || response.statusCode > 300) {
      print(response.statusCode);
      throw new Exception('Failed to insert data');
    } else {
    }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}