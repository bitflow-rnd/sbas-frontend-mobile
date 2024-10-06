class HisSampleData {
  String pid;
  String admsDt;
  String monStrtDt;
  String monStrtTm;
  String deptNm;
  String wardNm;
  String roomNm;
  String spclNm;

  HisSampleData({
    required this.pid,
    required this.admsDt,
    required this.monStrtDt,
    required this.monStrtTm,
    required this.deptNm,
    required this.wardNm,
    required this.roomNm,
    required this.spclNm,
  });

  factory HisSampleData.fromJson(Map<String, dynamic> json) {
    return HisSampleData(
      pid: json['pid'],
      admsDt: json['admsDt'],
      monStrtDt: json['monStrtDt'],
      monStrtTm: json['monStrtTm'],
      deptNm: json['deptNm'],
      wardNm: json['wardNm'],
      roomNm: json['roomNm'],
      spclNm: json['spclNm'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pid': pid,
      'admsDt': admsDt,
      'monStrtDt': monStrtDt,
      'monStrtTm': monStrtTm,
      'deptNm': deptNm,
      'wardNm': wardNm,
      'roomNm': roomNm,
      'spclNm': spclNm,
    };
  }
}

class HisSampleDataService {
  List<HisSampleData> sampleDataList = [
    HisSampleData(
      pid: '0010001',
      admsDt: '20241002',
      monStrtDt: '20241002',
      monStrtTm: '230000',
      deptNm: '외과',
      wardNm: 'MICU',
      roomNm: 'MICU',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0010002',
      admsDt: '20240926',
      monStrtDt: '20240926',
      monStrtTm: '154600',
      deptNm: '외과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0010003',
      admsDt: '20241001',
      monStrtDt: '20241001',
      monStrtTm: '210000',
      deptNm: '호흡기내과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0010004',
      admsDt: '20240922',
      monStrtDt: '20240922',
      monStrtTm: '210000',
      deptNm: '감염내과',
      wardNm: '76동병동',
      roomNm: '7602',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0010005',
      admsDt: '20240923',
      monStrtDt: '20240923',
      monStrtTm: '210345',
      deptNm: '외과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0020001',
      admsDt: '20241003',
      monStrtDt: '20241003',
      monStrtTm: '193800',
      deptNm: '외과',
      wardNm: 'MICU',
      roomNm: 'MICU',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0020002',
      admsDt: '20241004',
      monStrtDt: '20241004',
      monStrtTm: '230000',
      deptNm: '감염내과',
      wardNm: '76서병동',
      roomNm: '7629',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0020003',
      admsDt: '20240929',
      monStrtDt: '20240929',
      monStrtTm: '230000',
      deptNm: '외과',
      wardNm: 'MICU',
      roomNm: 'MICU',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0020004',
      admsDt: '20241002',
      monStrtDt: '20241002',
      monStrtTm: '233500',
      deptNm: '감염내과',
      wardNm: '66서병동',
      roomNm: '6621',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0020005',
      admsDt: '20241001',
      monStrtDt: '20241001',
      monStrtTm: '230000',
      deptNm: '외과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0030001',
      admsDt: '20240924',
      monStrtDt: '20240924',
      monStrtTm: '220000',
      deptNm: '혈액종양내과',
      wardNm: 'SICU',
      roomNm: 'SICU',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0030002',
      admsDt: '20240928',
      monStrtDt: '20240928',
      monStrtTm: '230000',
      deptNm: '호흡기내과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0030003',
      admsDt: '20240928',
      monStrtDt: '20240928',
      monStrtTm: '230000',
      deptNm: '감염내과',
      wardNm: '76서동',
      roomNm: '7628',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0030004',
      admsDt: '20240903',
      monStrtDt: '20240903',
      monStrtTm: '233000',
      deptNm: '외과',
      wardNm: 'MICU',
      roomNm: 'MICUC',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0030005',
      admsDt: '20240930',
      monStrtDt: '20240930',
      monStrtTm: '200000',
      deptNm: '감염내과',
      wardNm: '43병동',
      roomNm: '4328',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0040001',
      admsDt: '20241005',
      monStrtDt: '20241005',
      monStrtTm: '230000',
      deptNm: '감염내과',
      wardNm: '43병동',
      roomNm: '4324',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0040002',
      admsDt: '20241002',
      monStrtDt: '20241002',
      monStrtTm: '210000',
      deptNm: '감염내과',
      wardNm: '43병동',
      roomNm: '4328',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0040003',
      admsDt: '20241004',
      monStrtDt: '20241004',
      monStrtTm: '210000',
      deptNm: '감염내과',
      wardNm: '66동병동',
      roomNm: '6604',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0040004',
      admsDt: '20241002',
      monStrtDt: '20241002',
      monStrtTm: '225200',
      deptNm: '외과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
    HisSampleData(
      pid: '0040005',
      admsDt: '20240927',
      monStrtDt: '20240927',
      monStrtTm: '160000',
      deptNm: '외과',
      wardNm: 'ICU2',
      roomNm: 'ERW',
      spclNm: '전문의',
    ),
  ];

  HisSampleData? getHisSampleData(String? pid) {
    try {
      return sampleDataList.firstWhere((data) => data.pid == pid);
    } catch (e) {
      return null;
    }
  }
}
