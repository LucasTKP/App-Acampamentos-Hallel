import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension TimeStampExtension on Timestamp {
  String toDDMMYYYY() {
    final date = toDate();
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String toDDMMYYYYHHMM() {
    final date = toDate();
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}
