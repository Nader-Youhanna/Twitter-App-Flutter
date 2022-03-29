import 'package:flutter/material.dart';

class TweetImage extends StatelessWidget {
  final List<String> imageUrl;
  final double imageHeight = 200.0;
  final double imageWidth = 200.0;
  TweetImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.length == 1) {
      return Container(
        width: imageWidth,
        height: imageHeight,
        child: Image(
          image: AssetImage(imageUrl[0]),
          width: imageWidth,
          height: imageHeight,
        ),
        padding: const EdgeInsets.all(5),
      );
    } else if (imageUrl.length == 2) {
      return Container(
        child: Row(
          children: [
            Container(
              child: Image(
                image: AssetImage(imageUrl[0]),
                width: imageWidth / 2,
                height: imageHeight / 2,
              ),
              padding: const EdgeInsets.all(5),
            ),
            Container(
              child: Image(
                image: AssetImage(imageUrl[1]),
                width: imageWidth / 2,
                height: imageHeight / 2,
              ),
              padding: const EdgeInsets.all(5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
      );
    } else if (imageUrl.length == 3) {
      return Container(
        child: Row(
          children: [
            Container(
              child: Image(
                image: AssetImage(imageUrl[0]),
                width: imageWidth / 3,
                height: imageHeight / 3,
              ),
              padding: const EdgeInsets.all(5),
            ),
            Container(
              child: Image(
                image: AssetImage(imageUrl[1]),
                width: imageWidth / 3,
                height: imageHeight / 3,
              ),
              padding: const EdgeInsets.all(5),
            ),
            Container(
              child: Image(
                image: AssetImage(imageUrl[2]),
                width: imageWidth / 3,
                height: imageHeight / 3,
              ),
              padding: const EdgeInsets.all(5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
      );
    } else {
      //4 imagaes
      return Container(
        child: Column(
          children: [
            Row(children: [
              Container(
                child: Image(
                  image: AssetImage(imageUrl[0]),
                  width: imageWidth / 2,
                  height: imageHeight / 2,
                ),
                padding: const EdgeInsets.all(5),
              ),
              Container(
                child: Image(
                  image: AssetImage(imageUrl[1]),
                  width: imageWidth / 2,
                  height: imageHeight / 2,
                ),
                padding: const EdgeInsets.all(5),
              ),
            ]),
            Row(
              children: [
                Container(
                  child: Image(
                    image: AssetImage(imageUrl[2]),
                    width: imageWidth / 2,
                    height: imageHeight / 2,
                  ),
                  padding: const EdgeInsets.all(5),
                ),
                Container(
                  child: Image(
                    image: AssetImage(imageUrl[3]),
                    width: imageWidth / 2,
                    height: imageHeight / 2,
                  ),
                  padding: const EdgeInsets.all(5),
                ),
              ],
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
      );
    }
  }
}
