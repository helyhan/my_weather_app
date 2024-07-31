class Weather {
  String description;
  String icon;

  Weather(Map<String, dynamic> data):
        description = data['description'],
        icon = data['icon'];

  String get iconFormatted => 'https://openweathermap.org/img/wn/$icon@2x.png';

}