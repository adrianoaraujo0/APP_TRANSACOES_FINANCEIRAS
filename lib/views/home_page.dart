import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transacoes_financeiras/views/list_transacoes.dart';

import '../models/conta.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.fazerDeposito, required this.fazerSaque, Key? key})
      : super(key: key);

  Function(double) fazerDeposito;
  Function(double) fazerSaque;

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
            setState(() {
              double valor = double.parse(controller.text);

              if (valor != null && hintText == "Deposito") {
                operacoes.add(Operacoes(
                    nomeOperacao: "Deposito", valorDaOperacao: valor));
              } else if (valor != null && hintText == "Saque") {
                operacoes.add(
                    Operacoes(nomeOperacao: "Saque", valorDaOperacao: valor));
              }

              print(operacoes.toString());
            });

            transacao(double.parse(controller.text));
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
}
