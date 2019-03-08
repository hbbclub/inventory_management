import 'package:flutter/material.dart';
import 'package:multi_image_picker/asset.dart';

class AssetView extends StatefulWidget {
  final int _index;
  final Asset _asset;

  AssetView(Key key, this._index, this._asset) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssetState();
}

class AssetState extends State<AssetView> {

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(AssetView oldWidget) {
    _loadImage();
    super.didUpdateWidget(oldWidget);
    
  }

  @override
  void deactivate() {
    this.widget._asset.release();
    super.deactivate();
    
  }

  void _loadImage() async {
    await this.widget._asset.requestThumbnail(300, 300, quality: 50);

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (null != this.widget._asset.thumbData) {
      return Image.memory(
        this.widget._asset.thumbData.buffer.asUint8List(),
        fit: BoxFit.fill,
        gaplessPlayback: true,
      );
    }

    return Text(
      '${this.widget._index}',
      style: Theme.of(context).textTheme.headline,
    );
  }
}
