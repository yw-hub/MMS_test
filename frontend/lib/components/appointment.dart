import 'package:flutter/foundation.dart';

class Appointment {
  final String id;
  final String pid;
  final String title;
  final String detail;
  final DateTime date;
  final int duration;
  final String note;
  final String userNote;
  final String status;

  Appointment(
      {this.id,
        this.pid,
        this.title,
        this.detail,
        this.date,
        this.duration,
        this.note,
        this.userNote,
        this.status});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        id: json['id'],
        pid: json['uid'],
        title: json['title'],
        detail: json['detail'],
        date: DateTime.parse(json['date']),
        duration: json['duration'] as int,
        note: json['note'],
        userNote: json['user_note'],
        status: json['status']
    );
  }
}