class Operacoes {
  Operacoes({required this.nomeOperacao, required this.valorDaOperacao});
  String nomeOperacao;
  double valorDaOperacao;

  String toString() {
    return "nome: $nomeOperacao, valor: $valorDaOperacao";
  }
}
