import 'package:flutter/material.dart';

/// This class is used to represent media in a tweet.
class TweetImage extends StatelessWidget {
  final List<String> imageUrl;
  final double imageHeight = 200.0;
  final double imageWidth = 200.0;
  TweetImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    try {
      if (imageUrl.length == 1) {
        return Container(
          width: imageWidth,
          height: imageHeight,
          padding: const EdgeInsets.all(5),
          child: Image.network(
            imageUrl[0],
            width: imageWidth,
            height: imageHeight,
          ),
        );
      } else if (imageUrl.length == 2) {
        imageUrl[0] = 'https://picsum.photos/250?image=9';
        imageUrl[1] = 'https://picsum.photos/250?image=9';

        Image image1 = Image(image: AssetImage('images/test_image.png'));
        Image image2 = Image(image: AssetImage('images/test_image.png'));
        try {
          image1 = Image.network(
            imageUrl[0],
            width: imageWidth / 2,
            height: imageHeight / 2,
          );
        } catch (e) {
          image1 = Image(image: AssetImage('images/test_image.png'));
        }

        try {
          image2 = Image.network(
            imageUrl[1],
            width: imageWidth / 2,
            height: imageHeight / 2,
          );
        } catch (e) {
          image2 = Image(image: AssetImage('images/test_image.png'));
        }

        return Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Container(child: image1, padding: const EdgeInsets.all(5)),
              Container(child: image2, padding: const EdgeInsets.all(5)),
            ],
          ),
        );
      } else if (imageUrl.length == 3) {
        Image image1 = Image.network(
          imageUrl[0],
          width: imageWidth / 3,
          height: imageHeight / 3,
        );
        Image image2 = Image.network(
          imageUrl[1],
          width: imageWidth / 3,
          height: imageHeight / 3,
        );
        Image image3 = Image.network(
          imageUrl[2],
          width: imageWidth / 3,
          height: imageHeight / 3,
        );

        return Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Image.network(
                  imageUrl[0],
                  width: imageWidth / 3,
                  height: imageHeight / 3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Image.network(
                  imageUrl[1],
                  width: imageWidth / 3,
                  height: imageHeight / 3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Image.network(
                  imageUrl[2],
                  width: imageWidth / 3,
                  height: imageHeight / 3,
                ),
              ),
            ],
          ),
        );
      } else {
        //4 imagaes
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    imageUrl[0],
                    width: imageWidth / 2,
                    height: imageHeight / 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    imageUrl[1],
                    width: imageWidth / 2,
                    height: imageHeight / 2,
                  ),
                ),
              ]),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                      imageUrl[2],
                      width: imageWidth / 2,
                      height: imageHeight / 2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                      imageUrl[3],
                      width: imageWidth / 2,
                      height: imageHeight / 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    } catch (e) {
      return Container();
    }
  }
}
