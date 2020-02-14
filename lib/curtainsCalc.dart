import 'dart:async';
import 'dart:convert';
import 'package:bedsheet_calc/bahasa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class kalkulatorGordyn extends StatefulWidget {
  @override
  _kalkulatorGordynState createState() => _kalkulatorGordynState();
}

class _kalkulatorGordynState extends State<kalkulatorGordyn> {
  static const snackBarDuration = Duration(seconds: 3);
  final snackBar = SnackBar(
    content: Text('Press back again to leave',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold)
    ),
    duration: snackBarDuration,
  );
  // ignore: close_sinks
  StreamController<List<ListPegawai>> _pegawaiController = new StreamController<List<ListPegawai>>.broadcast();

  @override
  void initState() {
    super.initState();
    setState(() {
      logoImage = 'assets/images/ic_logo.png';
    });
    loadPegawai();
  }
  var logoImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Curtains Calc"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<ListPegawai>>(
          stream: _pegawaiController.stream,
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
              return UserPopulate(listPegawai: snapshot.data);
            }
          },
        ),
      ),
    );
  }

  loadPegawai() async {
    await fetchPegawai().then((result) {
      _pegawaiController.sink.add(result);
    });
  }

  Future<List<ListPegawai>> fetchPegawai() async {
    final response =
    await http.post(SumberApi.dataHarga);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return compute(parsePegawai, response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  static List<ListPegawai> parsePegawai(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ListPegawai>((json) => ListPegawai.fromJson(json))
        .toList();
  }
}
class ListPegawai {
  String id;
  String iktp;
  String nama;
  String alamat;
  String alamatdomisili;
  DateTime tanggallahir;
  String notelepon;
  String tanggallahirstring;
  String tempatlahir;
  String agama;
  String jabatan;
  String pendaftar;
  String status;

  ListPegawai({
    this.id,
    this.iktp,
    this.nama,
    this.alamat,
    this.alamatdomisili,
    this.tanggallahir,
    this.notelepon,
    this.tanggallahirstring,
    this.tempatlahir,
    this.agama,
    this.jabatan,
    this.pendaftar,
    this.status,
  });

  factory ListPegawai.fromJson(Map<String, dynamic> json) => new ListPegawai(
    id: json["id"],
    iktp: json["id_ktp"],
    nama: json["nama"],
    alamat: json["alamat"],
    alamatdomisili: json["alamatdomisili"],
    notelepon: json["no_telepon"],
    tanggallahir: DateTime.parse(json["tanggal_lahir"]),
    tanggallahirstring: json["tanggal_lahir"],
    tempatlahir: json["tempat_lahir"],
    agama: json["agama"],
    jabatan: json["jabatan"],
    pendaftar: json["pendaftar"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_ktp": iktp,
    "namaLengkap": nama,
    "alamatLengkap": alamat,
    "alamatdomisili":alamatdomisili,
    "tanggal_lahir":
    "${tanggallahir.year.toString().padLeft(4, '0')}-${tanggallahir.month.toString().padLeft(2, '0')}-${tanggallahir.day.toString().padLeft(2, '0')}",
    "no_telepon": notelepon,
    "agama": agama,
    "jabatan": jabatan,
    "pendaftar":pendaftar,
    "status": status,

  };
}

// ignore: must_be_immutable
class UserPopulate extends StatefulWidget {
  List<ListPegawai> listPegawai;
  UserPopulate({Key key, this.listPegawai}) : super(key: key);

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
      itemCount: widget.listPegawai.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index)
      {return GestureDetector(
        onTap: () {
          return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              List<String> listbiodata = [
                ": "+widget.listPegawai[index].iktp,
                ": "+widget.listPegawai[index].nama,
                ": "+widget.listPegawai[index].alamat,
                ": "+widget.listPegawai[index].alamatdomisili,
                ": "+widget.listPegawai[index].notelepon,
                ": "+widget.listPegawai[index].tempatlahir+", "+widget.listPegawai[index].tanggallahirstring,
                ": "+widget.listPegawai[index].agama,
                ": "+widget.listPegawai[index].jabatan,
                ": "+widget.listPegawai[index].status,
              ];
              List<String> listLabel = [
                "KTP",
                "Nama",
                "Alamat",
                "Domisili",
                "No.Tlp",
                "TTL",
                "Agama",
                "Jabatan",
                "Status",
              ];
              return AlertDialog(
                title: Text('Detail Job '+widget.listPegawai[index].nama),
                content: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: ListView(
                    padding: EdgeInsets.all(1.0),
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listLabel.map((data) =>
                                Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(" "+data,
                                            style: TextStyle(fontWeight: FontWeight.bold),)
                                        ] ))).toList(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listbiodata.map((data) =>
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(" "+data)
                                        ] ))).toList(),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancle'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  FlatButton(
                    child: Text('Make Offline'),
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alert!'),
                            content: Container(
                              child: Text("Yakin ingin akhiri jam kerja "+widget.listPegawai[index].nama+'?'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Cancle'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              FlatButton(
                                child: Text('Yakin'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  FlatButton(
                    child: Text('Absensi'),
                    onPressed: () {
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Card(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            child: ListTile(
                title: Text(
                  widget.listPegawai[index].nama,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  'Pekerjaan: '+widget.listPegawai[index].jabatan+', Setatus: '+widget.listPegawai[index].pendaftar,
                ),
                leading:
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                )
            ),
          ),
        ),
      );
      },
    );
  }
}