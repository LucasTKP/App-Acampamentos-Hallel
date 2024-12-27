class LiturgyModel {
  final String date;
  final String liturgy;
  final String color;
  final FirstLiturgy? firstLiturgy;
  final SecondLiturgy? secondLiturgy;
  final PsalmLiturgy? psalmLiturgy;
  final GospelLiturgy? gospelLiturgy;

  LiturgyModel({
    required this.date,
    required this.liturgy,
    required this.color,
    required this.firstLiturgy,
    required this.secondLiturgy,
    required this.psalmLiturgy,
    required this.gospelLiturgy,
  });

  factory LiturgyModel.fromJson(Map<String, dynamic> json) {
    return LiturgyModel(
      date: json['data'],
      liturgy: json['liturgia'],
      color: json['cor'],
      firstLiturgy: json['primeiraLeitura'] is Map ? FirstLiturgy.fromJson(json['primeiraLeitura']) : null,
      secondLiturgy: json['segundaLeitura'] is Map ? SecondLiturgy.fromJson(json['segundaLeitura']) : null,
      psalmLiturgy: json['salmo'] is Map ? PsalmLiturgy.fromJson(json['salmo']) : null,
      gospelLiturgy: json['evangelho'] is Map ? GospelLiturgy.fromJson(json['evangelho']) : null,
    );
  }
}

class FirstLiturgy {
  final String reference;
  final String title;
  final String text;

  FirstLiturgy({
    required this.reference,
    required this.title,
    required this.text,
  });

  factory FirstLiturgy.fromJson(Map<String, dynamic> json) {
    return FirstLiturgy(
      reference: json['referencia'],
      title: json['titulo'],
      text: json['texto'],
    );
  }
}

class SecondLiturgy {
  final String reference;
  final String title;
  final String text;

  SecondLiturgy({
    required this.reference,
    required this.title,
    required this.text,
  });

  factory SecondLiturgy.fromJson(Map<String, dynamic> json) {
    return SecondLiturgy(
      reference: json['referencia'],
      title: json['titulo'],
      text: json['texto'],
    );
  }
}

class PsalmLiturgy {
  final String reference;
  final String title;
  final String text;

  PsalmLiturgy({
    required this.reference,
    required this.title,
    required this.text,
  });

  factory PsalmLiturgy.fromJson(Map<String, dynamic> json) {
    return PsalmLiturgy(
      reference: json['referencia'],
      title: json['refrao'],
      text: json['texto'].replaceAll('\n', '\n\n'),
    );
  }
}

class GospelLiturgy {
  final String reference;
  final String title;
  final String text;

  GospelLiturgy({
    required this.reference,
    required this.title,
    required this.text,
  });

  factory GospelLiturgy.fromJson(Map<String, dynamic> json) {
    return GospelLiturgy(
      reference: json['referencia'],
      title: json['titulo'],
      text: json['texto'],
    );
  }
}
