enum TitleBackgroundImage {
  TOWN('town');

  const TitleBackgroundImage(this.name);

  String get path => 'image/background/$name.png';

  final String name;
}
