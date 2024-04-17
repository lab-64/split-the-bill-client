import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imgLib;

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.img});

  final imgLib.Image img;

Image displayImage() {
  final _img = Image.memory(img.data!.getBytes(order: imgLib.ChannelOrder.rgb));
  return _img;
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return displayImage();
  }

}