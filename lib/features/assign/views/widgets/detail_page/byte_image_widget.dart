import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';

class ByteImageWidget extends StatelessWidget {
  final Future<List<Uint8List>> imageBytesFuture;

  const ByteImageWidget({
    required this.imageBytesFuture,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.6;

    return FutureBuilder<List<Uint8List>>(
      future: imageBytesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SBASProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading image');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          var images = snapshot.data!;

          if (images.length < 3) {
            return SizedBox(
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var imageBytes in images)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: screenWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.memory(
                            imageBytes,
                            width: screenWidth,
                            height: imageHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (images.length < 3)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: screenWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.asset(
                            "assets/auth_group/image_location.png",
                            width: screenWidth,
                            height: imageHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox(
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var imageBytes in images)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: screenWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.memory(
                            imageBytes,
                            width: screenWidth,
                            height: imageHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        } else {
          return Center(
            child: Container(
              width: screenWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset(
                "assets/auth_group/image_location.png",
                width: screenWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
    );
  }
}