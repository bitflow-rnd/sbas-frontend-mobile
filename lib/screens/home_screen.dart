import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'LOGO',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            const Text(
              'Name님 안녕하세요!',
            ),
            const Text(
              '스마트 병상배정 시스템에 오신걸 환영합니다.',
            ),
            const Text(
              '신속한 병상배정 서비스를 경험해보세요.',
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: const Text(
                          '요청',
                        ),
                      ),
                      Container(
                        child: const Text(
                          '승인',
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Text(
                          '이송',
                        ),
                      ),
                      Container(
                        child: const Text(
                          '입원',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                const Text(
                  '최근 활동',
                ),
                Container(
                  child: const Text(
                    '더보기',
                  ),
                ),
              ],
            ),
            /*
            ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: const [
                    Text(
                      'Date',
                    ),
                    Text(
                      '병상요청',
                    ),
                    Text(
                      '[Name/남/88세/Address]',
                    ),
                  ],
                );
              },
            ),
            */
          ],
        ),
      ),
    );
  }

  static String routeName = 'home';
  static String routeUrl = '/home';
}
