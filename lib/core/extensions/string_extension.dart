import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  DateTime toDateTime() {
    final parts = split('/');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  Timestamp toTimestamp() {
    return Timestamp.fromDate(toDateTime());
  }

  String removeDiacritics() {
    String text = this;
    var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      text = text.replaceAll(withDia[i], withoutDia[i]);
    }

    return text;
  }

  List<TextSpan> formatGospelWithBoldNumbers() {
    final text = this;
    List<TextSpan> textSpans = [];

    // Atualiza a RegExp para capturar números de versículos apenas no contexto esperado
    RegExp regex = RegExp(r'(?<=^|\s)(\d+)(?=(["“”]|[A-Za-zÀ-ÿ]))');

    int lastEnd = 0;

    // Procura todos os matches no texto completo
    Iterable<Match> matches = regex.allMatches(text);

    for (Match match in matches) {
      // Adiciona o texto antes do número
      if (match.start > lastEnd) {
        textSpans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
        ));
      }

      // Adiciona o número em negrito com espaços
      textSpans.add(TextSpan(
        text: ' ${text.substring(match.start, match.end)} ',
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
      ));

      lastEnd = match.end;
    }

    // Adiciona o resto do texto após o último número
    if (lastEnd < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(lastEnd),
      ));
    }

    return textSpans;
  }
}
