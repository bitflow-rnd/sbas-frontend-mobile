import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class AppLicensePage extends StatefulWidget {
  const AppLicensePage({super.key});

  @override
  State<AppLicensePage> createState() => _AppLicensePageState();
}

class _AppLicensePageState extends State<AppLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: Bitflow.getAppBar(
        '오픈소스 라이선스',
        true,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
                openSourceLicenseCard(
                    "Retrofit2", "Apache 2.0", "https://github.com/square/okhttp/blob/master/LICENSE.txt", "Version 4.9.2", "https://github.com/square/okhttp"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget openSourceLicenseCard(String name, String lib, String url, String version, String url2) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1a645c5c),
            offset: Offset(0, 3),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: CTS.bold(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            lib,
            style: CTS.medium(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            url,
            style: CTS(
              color: const Color(0xff676a7a),
              fontSize: 13,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            version,
            style: CTS(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            url2,
            style: CTS(
              color: const Color(0xff676a7a),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
