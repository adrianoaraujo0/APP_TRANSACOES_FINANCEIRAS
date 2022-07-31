import 'package:flutter/material.dart';
import 'package:transacoes_financeiras/views/home_page.dart';

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
                  "R\$: ${saldo.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: HomePage(
            fazerDeposito: fazerDeposito,
            fazerSaque: fazerSaque,
            saldo: saldo,
          ),
        ),
      ),
    );
  }

  void fazerDeposito(double deposito) {
    setState(() {
      if (deposito > 0) {
        saldo += deposito;
      }
    });
  }

  void fazerSaque(double deposito) {
    setState(() {
      saldo -= deposito;
    });
  }
}
