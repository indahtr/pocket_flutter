import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailTransaction extends StatefulWidget {
  DetailTransaction({Key? key, required this.user_id}) : super(key: key);

  final user_id;

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  var _transaction_type;

  final transactionTextInput = TextEditingController();

  Future fetch_user_data(var id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${id}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["anggota"];
    }

    return [];
  }

  Future fetch_transaction_type() async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/jenistransaksi");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["jenistransaksi"];
    }

    return [];
  }

  Future addTransaction(int user_id, String trx_id, String trx_nominal) async {
    final box = GetStorage();

    var data = {
      "anggota_id": user_id.toString(),
      "trx_id": trx_id,
      "trx_nominal": trx_nominal
    };

    var url = Uri.https("mobileapis.manpits.xyz", "api/tabungan");
    var response = await http.post(url, body: data, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });
    print(response.body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      print(decode);
      return decode;
    }

    return [];
  }

  Future get_all_transaction(int user_id) async {
    final box = GetStorage();

    var url = Uri.https("mobileapis.manpits.xyz", "api/tabungan/${user_id}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["tabungan"];
    }

    return [];
  }

  Future get_balance(int user_id) async {
    final box = GetStorage();

    var url = Uri.https("mobileapis.manpits.xyz", "api/saldo/${user_id}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["saldo"];
    }

    return 0;
  }

  void showNotification(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Notifikasi"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            fetch_user_data(widget.user_id),
            get_balance(widget.user_id),
            fetch_transaction_type(),
            get_all_transaction(widget.user_id)
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              var user_data = snapshot.data![0];
              var user_status = user_data["status_aktif"];
              var balance = int.parse(snapshot.data![1].toString());
              var items = <DropdownMenuItem<String>>[];

              for (var item in snapshot.data![2]) {
                if (item["trx_name"] != "Bunga Simpanan") {
                  items.add(DropdownMenuItem(
                    child: Text(item["trx_name"]),
                    value: item["trx_name"].toString(),
                  ));
                }
              }

              var list_transaction = <Widget>[];

              for (var item in snapshot.data![3]) {
                var item_type = "";
                for (var type in snapshot.data![2]) {
                  if (item["trx_id"].toString() == type["id"].toString()) {
                    item_type = type["trx_name"];
                    break;
                  }
                }
                list_transaction.add(Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(int.parse(item["trx_nominal"].toString()))),
                            Text(item["trx_tanggal"])
                          ],
                        ),
                        Text(item_type.toString())
                      ],
                    ),
                  ),
                ));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.badge),
                              title: Text(user_data["nomor_induk"].toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(user_data["nama"].toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(user_data["alamat"].toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.calendar_today),
                              title: Text(user_data["tgl_lahir"].toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text(user_data["telepon"].toString()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Saldo : " + NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(balance),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    if (user_status == 1) // form hanya ditampilkans saat status aktif
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Pilih Jenis Transaksi"),
                                SizedBox(height: 10),
                                DropdownButton(
                                  value: _transaction_type,
                                  isExpanded: true,
                                  items: items,
                                  onChanged: (value) {
                                    setState(() {
                                      _transaction_type = value!.toString();
                                    });
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Nominal",
                                    prefixIcon: Icon(Icons.money),
                                  ),
                                  controller: transactionTextInput,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukkan Nominal Transaksi";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      String formattedValue = NumberFormat("#,##0", "id_ID").format(int.parse(value.replaceAll('.', '')));
                                      transactionTextInput.value = TextEditingValue(
                                        text: formattedValue,
                                        selection: TextSelection.collapsed(offset: formattedValue.length),
                                      );
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    for (var item in snapshot.data![2]) {
                                      if (item["trx_name"] == _transaction_type) {
                                        if (_transaction_type == "Penarikan" && int.parse(transactionTextInput.text.replaceAll('.', '')) > balance) {
                                          showNotification("Saldo tidak cukup untuk melakukan penarikan.");
                                          return;
                                        }
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text("Konfirmasi"),
                                            content: const Text("Yakin ingin melanjutkan transaksi?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, "Cancel");
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  addTransaction(
                                                    widget.user_id,
                                                    item["id"].toString(),
                                                    transactionTextInput.text.replaceAll('.', '')
                                                  ).then((val) {
                                                    Navigator.pop(context, "remove alert dialog");
                                                    setState(() {});
                                                    transactionTextInput.clear(); // Clear the input field after transaction
                                                  });
                                                },
                                                child: Text("Ya"),
                                              ),
                                            ],
                                          ),
                                        );
                                        break; // Exit loop after finding a match
                                      }
                                    }
                                  },
                                  child: Text("Tambahkan Transaksi"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: list_transaction,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Text("No Data");
          },
        ),
      ),
    );
  }
}
