import 'package:cloud_firestore/cloud_firestore.dart';

extension StringExtension on String {
  DateTime toDateTime() {
    final parts = split('/');
    return DateTime(
      int.parse(parts[2]), 
      int.parse(parts[1]),  
      int.parse(parts[0])   
    );
  }

  Timestamp toTimestamp() {
    return Timestamp.fromDate(toDateTime());
  }
}