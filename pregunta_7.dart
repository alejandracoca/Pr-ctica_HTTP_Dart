import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final id = 5; // Cambia a 99999 para probar el caso 404
  final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String title = data['title'];
      final bool completed = data['completed'];
      
      print('--- TAREA ENCONTRADA ---');
      print('Título: $title');
      print('Estado: ${completed ? "Completada" : "Pendiente"}');
    } else if (response.statusCode == 404) {
      print('Error 404: La tarea con ID $id no fue encontrada.');
    } else {
      print('Error inesperado. Código de estado: ${response.statusCode}');
    }
  } catch (e) {
    print('Error de conexión: No se pudo realizar la solicitud. ($e)');
  }
}
