import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController saldoController = TextEditingController();
  TextEditingController depositoController = TextEditingController();
  TextEditingController saqueController = TextEditingController();
  double saldo = 0;

  void depositar() {
    setState(() {
      saldo += double.parse(depositoController.text);
    });
  }

  void sacar() {
    setState(() {
      saldo -= double.parse(saqueController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, condition) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              backgroundColor: Colors.blue[400],
              title: Text("Unique Bank"),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text(
                  "R\$: ${saldo}",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: saqueController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Fazer saque",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        sacar();
                      },
                      child: Icon(Icons.remove))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: depositoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Fazer depósito",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (depositoController.text != null) {
                          depositar();
                        }
                      },
                      child: Icon(Icons.add))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
