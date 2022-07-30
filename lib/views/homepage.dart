import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.fazerDeposito, required this.fazerSaque, Key? key})
      : super(key: key);

  TextEditingController depositoController = TextEditingController();
  TextEditingController saqueController = TextEditingController();

  Function(double) fazerDeposito;
  Function(double) fazerSaque;
  //  double.parse(saqueController.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildWidgetTransacao(
            controller: depositoController,
            hintText: "Fazer Deposito",
            transacao: fazerDeposito),
        SizedBox(
          height: 20,
        ),
        BuildWidgetTransacao(
            controller: saqueController,
            hintText: "Fazer saque",
            transacao: fazerSaque)
      ],
    );
  }

  Widget BuildWidgetTransacao(
      {required TextEditingController controller,
      required String hintText,
      required Function(double) transacao}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
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
            transacao(double.parse(controller.text));
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
