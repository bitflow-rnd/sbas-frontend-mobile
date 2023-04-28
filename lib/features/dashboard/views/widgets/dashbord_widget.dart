import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dashbord extends StatelessWidget {
  const Dashbord({
    super.key,
    required this.title,
    required this.edge,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.grey.shade300,
        onTap: () {
          if (kDebugMode) {
            print(title);
          }
        },
        child: Container(
          margin: edge,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a645c5c),
                offset: Offset(0, 3),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/home/${path}_icon.png',
                      height: 76,
                    ),
                    AutoSizeText(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxFontSize: 20,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: const AutoSizeText(
                    '25',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    maxFontSize: 16,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String title, path;
  final EdgeInsets edge;
}
