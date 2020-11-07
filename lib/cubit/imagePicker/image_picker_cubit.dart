import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'image_picker_state_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerLoading());

  Future initImages(BuildContext context) async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('illustrations/'))
        .where((String key) => key.contains('.svg'))
        .toList();

    emit(ImagePickerLoaded(imagesPaths: imagePaths));
  }
}
