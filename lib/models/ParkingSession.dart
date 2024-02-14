class ParkingSession {
  String uuid;
  String lot;
  String slot_number;
  int timestamp_start;
  int? timestamp_end;
  String parked_on;
  int? amount_accumulated;

  ParkingSession(
      {required this.uuid,
      required this.lot,
      required this.slot_number,
      required this.timestamp_start,
      this.timestamp_end,
      required this.parked_on,
      required this.amount_accumulated});

  factory ParkingSession.fromJson(Map<String, dynamic> json) {
    return ParkingSession(
        uuid: json['uuid'],
        lot: json['lot'],
        slot_number: json['slot_number'],
        timestamp_start: json['timestamp_start'],
        timestamp_end: json['timestamp_end'],
        parked_on: json['parked_on'],
        amount_accumulated: json['amount_accumulated']);
  }
}
