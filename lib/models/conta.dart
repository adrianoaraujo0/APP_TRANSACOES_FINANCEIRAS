class Conta {
  Conta(
      {required this.nomeConta, required this.valorConta, required this.horas});
  String nomeConta;
  double valorConta;
  DateTime horas;

  String toString() {
    return "nome: $nomeConta, valor: $valorConta";
  }
}
