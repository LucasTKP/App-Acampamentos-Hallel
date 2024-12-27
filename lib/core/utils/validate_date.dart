String? validateDate(String? date) {
  if (date == null || date.isEmpty) {
    return 'Campo obrigatório';
  }

  // Validate date format (DD/MM/YYYY)
  final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegex.hasMatch(date)) {
    return 'Formato de data inválido, use 00/00/0000';
  }

  // Parse the date
  final parts = date.split('/');
  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  // Check if date components are valid
  if (day == null || month == null || year == null) {
    return 'Data inválida';
  }

  // Validate date range and format
  if (month < 1 || month > 12) {
    return 'Mês inválido';
  }

  final daysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (day < 1 || day > daysInMonth[month - 1]) {
    return 'Dia inválido';
  }
  return null;
}
