class BelongAgencyModel {
  final List<String> debuggingList;

  BelongAgencyModel({
    required this.debuggingList,
  });

  BelongAgencyModel.isDebugging()
      : debuggingList = [
          '디',
          '버',
          '깅',
        ];
}
