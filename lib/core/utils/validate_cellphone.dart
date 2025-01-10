String? validateCellPhone(String? value) {
  // Expressão regular para validar o formato de número de celular
  String pattern = r'^\(\d{2}\)\s\d{5}-\d{4}$';
  RegExp regex = RegExp(pattern);

  // Verifica se o valor é nulo ou vazio
  if (value == null || value.isEmpty) {
    return 'Por favor, insira um número de celular.';
  }

  // Verifica se o valor corresponde ao formato esperado
  if (!regex.hasMatch(value)) {
    return 'Número inválido, esperado: (XX) 99999-9999';
  }

  return null; // Retorna null se for válido
}
