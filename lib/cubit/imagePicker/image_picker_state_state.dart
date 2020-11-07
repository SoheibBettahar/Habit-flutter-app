part of 'image_picker_cubit.dart';

@immutable
abstract class ImagePickerState {
  const ImagePickerState();
}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerLoaded extends ImagePickerState {
  final List<String> imagesPaths;

  const ImagePickerLoaded({
    @required this.imagesPaths,
  });

  ImagePickerLoaded copyWith({
    List<String> imagesPaths,
  }) {
    if ((imagesPaths == null || identical(imagesPaths, this.imagesPaths))) {
      return this;
    }

    return new ImagePickerLoaded(
      imagesPaths: imagesPaths ?? this.imagesPaths,
    );
  }

  @override
  String toString() {
    return 'ImagePickerLoaded{imagesPaths: $imagesPaths}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImagePickerLoaded &&
          runtimeType == other.runtimeType &&
          imagesPaths == other.imagesPaths);

  @override
  int get hashCode => imagesPaths.hashCode;

  factory ImagePickerLoaded.fromMap(Map<String, dynamic> map) {
    return new ImagePickerLoaded(
      imagesPaths: map['imagesPaths'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'imagesPaths': this.imagesPaths,
    } as Map<String, dynamic>;
  }

}
