import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:gourmetize/config/app_config.dart';
import 'package:http_parser/http_parser.dart';

class UploadService {
  final String baseUrl = AppConfig.baseUrl + '/images';

  Future<String> uploadImage(File imageFile, int userId) async {

  final url = Uri.parse('$baseUrl/upload');

    try {
      final request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Nome do parâmetro esperado no backend
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.fields['userId'] = userId.toString();

      final response = await request.send();

      if (response.statusCode == 200) {

        final responseBody = await response.stream.bytesToString();
        print('Upload realizado com sucesso: $responseBody');
        return responseBody.toString();
      } else {
        print('Erro ao fazer upload da imagem. Código: ${response.statusCode}');
      }
      return Future.error('Erro ao fazer upload da imagem. Código: ${response.statusCode}');
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      return Future.error('Erro ao fazer upload da imagem.');
    }
  }
}
