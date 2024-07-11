class TimerInfo {
  int id;
  String timerName;

  TimerInfo({
    required this.id,
    required this.timerName,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() => {
        'id': id,
        'timerName': timerName,
      };

  // JSON에서 객체 생성
  factory TimerInfo.fromJson(Map<String, dynamic> json) => TimerInfo(
        id: json['id'],
        timerName: json['timerName'],
      );
}
