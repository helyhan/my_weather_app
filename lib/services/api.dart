import 'package:http/http.dart' as http;
import '../models/settings.dart';

class Api
{
  static get(String latitude, String longitude) async {
    final String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
    final Map<String, String> queryParams = {
      'lat': latitude,
      'lon': longitude,
      'units': Settings.system,
      'exclude': 'minutely',
      'appid': 'a81a3b05a15910da647840d981e79421', // TODO: access api key from .env file
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    return await http.get(uri);
  }
}

