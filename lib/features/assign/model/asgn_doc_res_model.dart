class AsgnDocRes {
  final bool? isAlreadyApproved;
  final String? message;

  AsgnDocRes({
    this.isAlreadyApproved,
    this.message,
  });

  AsgnDocRes.fromJson(Map<String, dynamic> json)
      : isAlreadyApproved = json['isAlreadyApproved'] as bool?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {'isAlreadyApproved': isAlreadyApproved, 'message': message};
}
