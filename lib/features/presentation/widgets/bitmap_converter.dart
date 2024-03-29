import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

/*class BitmapConverter extends StatefulWidget {
  BitmapConverter({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  BitmapConverterState createState() => BitmapConverterState();
}

class BitmapConverterState extends State<BitmapConverter> {
  late ui.Image image;
  bool isImageloaded = false;
  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load('assets/image.jpeg');
    image = await loadImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return CustomPaint(
        painter: PngImagePainter(image: image),
      );
    } else {
      return Center(child: Text('loading'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: _buildImage(),
        ));
  }
}*/

class BitmapConverter {
  BitmapConverter();

  Canvas drawCanvas(Size size, Canvas canvas, ui.Image image) {
    final center = Offset(150, 50);
    final radius = math.min(size.width, size.height) / 8;

    // The circle should be paint before or it will be hidden by the path
    Paint paintCircle = Paint()..color = Colors.black;
    Paint paintBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width / 36
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);

    double drawImageWidth = 0;
    var drawImageHeight = -size.height * 0.8;

    Path path = Path()
      ..addOval(Rect.fromLTWH(drawImageWidth, drawImageHeight,
          image.width.toDouble(), image.height.toDouble()));

    canvas.clipPath(path);

    canvas.drawImage(image, Offset(drawImageWidth, drawImageHeight), Paint());
    return canvas;
  }

  Future<String> saveCanvas(Size size, ui.Image image) async {
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;

    drawCanvas(size, canvas, image);

    var pic = pictureRecorder.endRecording();
    ui.Image img = await pic.toImage(image.width, image.height);
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    var documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(join(documentDirectory.path,
        '${DateTime.now().toUtc().toIso8601String()}.png'));
    file.writeAsBytesSync(buffer);

    print(file.path);
    return file.path;
  }
}
