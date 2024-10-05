import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';

class CircularImage extends StatelessWidget {
  const CircularImage(
    this._path, {
    super.key,
    this.size = 50.0,
    this.backgroundColor,
    this.paddingValue = 8.0,
  })  : this._file = null,
        this._url = null;

  const CircularImage.file(
    this._file, {
    super.key,
    this.size = 50.0,
    this.backgroundColor,
    this.paddingValue = 8.0,
  })  : this._url = null,
        this._path = null;

  const CircularImage.network(
    this._url, {
    super.key,
    this.size = 50.0,
    this.backgroundColor,
    this.paddingValue = 8.0,
  })  : this._file = null,
        this._path = null;

  final double paddingValue;
  final File? _file;
  final String? _path;
  final String? _url;
  final double size;
  final Color? backgroundColor;

  ImageProvider? _buildImage() {
    if (_path != null && _path.toString().isNotEmpty) {
      return AssetImage(_path!);
    }
    if (_file != null && _file!.path.toString().isNotEmpty) {
      return FileImage(_file!);
    }
    if (_url != null && _url.toString().isNotEmpty) {
      return CachedNetworkImageProvider(_url!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // return Center(child: _buildImage());
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backgroundColor,
        image: DecorationImage(
          alignment: AlignmentDirectional.center,
          image: _buildImage() ?? AssetImage(JobstopPngImg.signup),
          fit: BoxFit.cover,
        ),
      ),
      height: size,
      width: size,
      alignment: Alignment.center,
      padding: EdgeInsets.all(paddingValue),
    );
  }
}
