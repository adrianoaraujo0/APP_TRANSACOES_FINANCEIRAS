import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transacoes_financeiras/views/list_transacoes.dart';

import '../models/conta.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {required this.fazerDeposito,
      required this.fazerSaque,
      required this.saldo,
      Key? key})
      : super(key: key);

  Function(double) fazerDeposito;
  Function(double) fazerSaque;
  double saldo;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController depositoController = TextEditingController();

  TextEditingController saqueController = TextEditingController();

  List<Operacoes> operacoes = [];
  //  double.parse(saqueController.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        BuildWidgetTransacao(
            controller: depositoController,
            hintText: "Deposito",
            transacao: widget.fazerDeposito),
        SizedBox(
          height: 20,
        ),
        BuildWidgetTransacao(
            controller: saqueController,
            hintText: "Saque",
            transacao: widget.fazerSaque),
        SizedBox(
          height: 0,
        ),
        Flexible(
          child: ListView(
            children: [
              for (Operacoes operacao in operacoes)
                ListTransacoes(
                  nome_operacao: operacao.nomeOperacao,
                  valor_operacao: operacao.valorDaOperacao,
                )
            ],
          ),
        ),
      ],
    );
  }

  //Construtores de widgets
  Widget BuildWidgetTransacao(
      {required TextEditingController controller,
      required String hintText,
      required Function(double) transacao}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(),
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {
            double valor = double.parse(controller.text);

            setState(() {
              if (valor != null && hintText == "Deposito") {
                operacoes.add(Operacoes(
                    nomeOperacao: "Deposito", valorDaOperacao: valor));
                transacao(double.parse(controller.text));
              } else if (valor != null && hintText == "Saque") {
                if (widget.saldo - valor < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(ShowSnackBar());
                } else if (widget.saldo - valor >= 0) {
                  print("ERRADO");

                  transacao(double.parse(controller.text));

                  operacoes.add(
                      Operacoes(nomeOperacao: "Saque", valorDaOperacao: valor));
                }
              }

              // print(operacoes.toString());
            });

            controller.clear();
          },
          child: Icon(Icons.keyboard_arrow_right_outlined),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  SnackBar ShowSnackBar() {
    return SnackBar(
      backgroundColor: Colors.red[400],
      action: SnackBarAction(
        label: 'Fechar',
        textColor: Color.fromARGB(223, 0, 0, 0),
        onPressed: () {},
      ),
      content: const Text('Saldo insuficiente!'),
      duration: const Duration(seconds: 4),
      width: 310.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
