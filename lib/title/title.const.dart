enum TitleBackgroundImage {
  TOWN('town'),
  TOWN_NIGHT('town_night');

  const TitleBackgroundImage(this.name);

  String get path => 'image/background/$name.png';

  final String name;
}
