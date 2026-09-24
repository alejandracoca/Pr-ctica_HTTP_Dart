import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final nombrePokemon = 'pikachu'; // Cambia a 'pokemonfalso' para probar el caso 404
  final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nombrePokemon');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      final String nombre = data['name'];
      final int altura = data['height'];
      final int peso = data['weight'];
      
      List<dynamic> typesList = data['types'];
      List<String> tipos = typesList.map((t) => t['type']['name'].toString()).toList();

      print('--- INFORMACIÓN DEL POKÉMON ---');
      print('Nombre: $nombre');
      print('Altura: $altura');
      print('Peso: $peso');
      print('Tipos: ${tipos.join(", ")}');
    } else if (response.statusCode == 404) {
      print('Error 404: El pokémon "$nombrePokemon" no fue encontrado.');
    } else {
      print('Error inesperado. Código de estado: ${response.statusCode}');
    }
  } catch (e) {
    print('Error de conexión: No se pudo conectar con PokeAPI. ($e)');
  }
}
