import 'package:camera/camera.dart';
import 'package:image/image.dart' as imageLib;

class ImageUtilities {
  static imageLib.Image convertYUV420toImage(CameraImage cameraImage) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = imageLib.Image(width: width, height: height);

    for (int x = 0; x < width; ++x) {
      for (int y = 0; y < height; ++y) {
        final int uvIndex = uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;

        final Y = cameraImage.planes[0].bytes[index];
        final U = cameraImage.planes[1].bytes[uvIndex];
        final V = cameraImage.planes[2].bytes[uvIndex];

        imageLib.Color c = ImageUtilities.yuv2rgb(Y, U, V);
        image.setPixel(x, y, c);
      }
    }
    return image;
  }

  static imageLib.Color yuv2rgb(int y, int u, int v) {
    double Y = y.toDouble();
    double Cb = u.toDouble();
    double Cr = v.toDouble();

    int r = (Y + 1.40200 * (Cr - 0x80)).round();
    int g = (Y - 0.34414 * (Cb - 0x80) - 0.71414 * (Cr - 0x80)).round();
    int b = (Y + 1.77200 * (Cb - 0x80)).round();

    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return imageLib.ColorInt32.rgb(r, g, b);
  }
}