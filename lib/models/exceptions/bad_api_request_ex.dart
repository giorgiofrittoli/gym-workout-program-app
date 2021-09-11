class BadApiRequestError implements Exception {

  final List<Map<String,Object>>? errors;

  BadApiRequestError(this.errors);

  @override
  String toString() {
    return "Errore durante la comunicazione con il server";
  }
}