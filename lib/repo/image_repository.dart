import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageRepository {
  Future<List<dynamic>> getNetworkImages() async {
    try {
      String endpointUrl = 'https://pixabay.com/api/?key=41104137-249d3caf96f35a6d685145cde&q=people&image_type=illustration&pretty=true';
      final response = await http.get(Uri.parse(endpointUrl));
      if (response.statusCode == 200) {
        final dynamic decoded = jsonDecode(response.body);
        final List<dynamic> _imageList = decoded['hits'].map((listItem) {
          return ExternalImage.fromJson(listItem);
        }).toList();
        return _imageList;
      }
      throw Exception('API not successful');
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException {
      throw Exception('Couldn\'t retrieve images');
    } on FormatException {
      throw Exception('Bad response format');
    } catch (e) {
      throw Exception('Unknown error occured');
    }
  }
}