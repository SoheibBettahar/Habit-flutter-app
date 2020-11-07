import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit/cubit/imagePicker/image_picker_cubit.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CHOOSE_ICON),
      ),
      body: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, state) {
        if (state is ImagePickerLoaded) {
          List<String> _imagePaths = state.imagesPaths;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10),
              padding: EdgeInsets.only(
                  right: listItemPaddingHorizontal,
                  left: listItemPaddingHorizontal,
                  top: listItemPaddingVertical),
              clipBehavior: Clip.hardEdge,
              itemCount: _imagePaths.length,
              itemBuilder: (context, index) {
                String imagePath = _imagePaths[index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, imagePath);
                  },
                  child: SvgPicture.asset(
                    imagePath,
                    placeholderBuilder: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
