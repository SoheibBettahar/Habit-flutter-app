class OnBoardingPage {
  final int _id;
  final String _title;
  final String _description;
  final String _imagePath;

  const OnBoardingPage(
      this._id, this._title, this._description, this._imagePath);

  int get id => _id;

  String get imagePath => _imagePath;

  String get description => _description;

  String get title => _title;
}
