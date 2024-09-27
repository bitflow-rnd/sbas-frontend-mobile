import 'dart:typed_data';
import 'package:flutter/material.dart';

class ByteImageWidget extends StatelessWidget {
  final Future<Uint8List> imageBytesFuture;

  ByteImageWidget({required this.imageBytesFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: imageBytesFuture,  // 비동기 데이터를 기다립니다.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();  // 로딩 중
        } else if (snapshot.hasError) {
          return Text('Error loading image');  // 에러 처리
        } else if (snapshot.hasData) {
          return Image.memory(snapshot.data!);  // 데이터를 받아 Image.memory로 표시
        } else {
          return Text('No image available');  // 데이터가 없을 때
        }
      },
    );
  }
}
