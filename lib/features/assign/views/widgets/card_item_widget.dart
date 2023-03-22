import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.patientName,
    required this.patientSex,
    required this.patientAge,
    required this.symbol,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => RadialGradient(
                    colors: [
                      Colors.blue.shade700,
                      Colors.blue.shade300,
                    ],
                    center: Alignment.topCenter,
                    radius: 1,
                    tileMode: TileMode.clamp,
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$patientName ($patientSex/$patientAge세) ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: color.shade50,
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: Text(
                            symbol,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gaps.v4,
                    const Text(
                      '코로나바이러스 감염증-19',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      '서울특별시 구로구 구로동 디지털로 86가길 32',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4,
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: const Text(
                              '#임산부',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              top: 2,
              right: 4,
              child: Text(
                '3시간전',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final MaterialColor color;
  final String patientName, patientSex, patientAge, symbol;
}
