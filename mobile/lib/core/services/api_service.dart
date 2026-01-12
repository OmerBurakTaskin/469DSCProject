import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
    static const String baseUrl = 'http://10.225.222.241:8000';

  static Future<Map<String, dynamic>> processAudio(File audioFile) async {
    var uri = Uri.parse('$baseUrl/process');
    
    var request = http.MultipartRequest('POST', uri);
    
    request.files.add(await http.MultipartFile.fromPath(
      'audio', // Backend'deki parametre ismiyle aynı olmalı (main.py: audio)
      audioFile.path,
    ));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Connection Error: $e');
    }
  }
}