import 'package:cloud_firestore/cloud_firestore.dart';

extension DateTimeExtension on DateTime {
  String toDDMMYYYY() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    return '$day/$month/$year';
  }

  String abbreviatedMonth(){
    switch(month){
      case 1: return 'Jan';
      case 2: return 'Fev';
      case 3: return 'Mar';
      case 4: return 'Abr';
      case 5: return 'Mai';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Ago';
      case 9: return 'Set';
      case 10: return 'Out';
      case 11: return 'Nov';
      case 12: return 'Dez';
      default: return '';
    }
  }

  Timestamp toTimestamp() {
    return Timestamp.fromDate(this);
  }

  DateTime zeroTime() {
    return DateTime(year, month, day);
  }
}
