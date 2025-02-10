bool verifyVersionApp({required String atual, required String minima}) {
  String atualList = atual.replaceAll(".", "");
  String minimaList = minima.replaceAll(".", "");

  while (minimaList.length != atualList.length) {
    if (minimaList.length < atualList.length) {
      minimaList = "${minimaList}0";
    } else {
      atualList = "${atualList}0";
    }
  }

  return BigInt.parse(atualList) >= BigInt.parse(minimaList);
}
