import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xapptor_business/wpe/model/shift_participant.dart';
import 'package:xapptor_business/wpe/workplace_exam_view.dart';

enum ShiftType {
  first,
  second,
  night,
  normal,
}

class Shift {
  String id;
  String supervisor_id;
  ShiftType type;
  List<ShiftParticipant> participants;
  DateTime start;
  DateTime end;

  Shift({
    required this.id,
    required this.supervisor_id,
    required this.type,
    required this.participants,
    required this.start,
    required this.end,
  });

  Map<String, dynamic> to_json() {
    return {
      'supervisor_id': supervisor_id,
      'type': type,
      'participants': participants,
      'start': start,
      'end': end,
    };
  }
}

Future<Shift> get_shift_from_snapshot(
  String id,
  Map<String, dynamic> snapshot,
) async {
  return Shift(
    id: id,
    supervisor_id: snapshot['supervisor_id'],
    type: get_most_similar_enum_value(
      ShiftType.values,
      snapshot['type'],
    ),
    participants:
        await get_shift_participants(snapshot['participants'] as List<String>),
    start: (snapshot['start'] as Timestamp).toDate(),
    end: (snapshot['end'] as Timestamp).toDate(),
  );
}

Future<List<Shift>> get_shifts(List<String> shifts_id) async {
  List<Shift> shifts = [];

  for (var shift_id in shifts_id) {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('shifts')
        .doc(shift_id)
        .get();

    shifts.add(
      await get_shift_from_snapshot(
          shift_id, snapshot.data() as Map<String, dynamic>),
    );
  }
  return shifts;
}
