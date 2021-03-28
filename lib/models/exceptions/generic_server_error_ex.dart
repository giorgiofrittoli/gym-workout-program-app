class GenericServerError implements Exception {
  @override
  String toString() {
    return "Errore durante la comunicazione con il server";
  }
}
