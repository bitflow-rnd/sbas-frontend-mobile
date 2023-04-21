import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/dashboard/views/widgets/dashbord_widget.dart';
import 'package:sbas/util.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Image.asset(
          'assets/home/home_logo.png',
          alignment: Alignment.topLeft,
        ),
        leadingWidth: 256,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF696969),
            ),
          ),
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF696969),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${prefs.getString('id')}님 안녕하세요!',
              style: CTS.bold(
                fontSize: 18,
              ),
              maxFontSize: 24,
              maxLines: 1,
            ),
            Gaps.v8,
            AutoSizeText(
              '병상배정 통합연계시스템에 오신걸 환영합니다.\n신속한 병상배정 서비스를 경험해보세요.',
              style: CTS(
                color: Colors.grey,
              ),
              maxFontSize: 18,
            ),
            Gaps.v16,
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: const [
                          Dashbord(
                            title: '요청',
                            edge: EdgeInsets.only(
                              right: 6,
                              bottom: 6,
                            ),
                            path: 'request',
                          ),
                          Dashbord(
                            title: '승인',
                            edge: EdgeInsets.only(
                              left: 6,
                              bottom: 6,
                            ),
                            path: 'assign',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: const [
                          Dashbord(
                            title: '이송',
                            edge: EdgeInsets.only(
                              top: 6,
                              right: 6,
                            ),
                            path: 'transfer',
                          ),
                          Dashbord(
                            title: '입원',
                            edge: EdgeInsets.only(
                              top: 6,
                              left: 6,
                            ),
                            path: 'hospitalization',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최근 활동',
                  style: CTS.bold(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '더보기',
                    style: CTS.medium(color: Palette.greyText, fontSize: 11),
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
