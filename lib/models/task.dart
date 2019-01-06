import 'package:meta/meta.dart';
import 'dart:convert';

class Task {
  static final db_uuid = "uuid";
  static final db_id = "id";
  static final db_subject = "subject";
  static final db_description = "description";
  static final db_notes = "notes";
  static final db_star = "star";

  String uuid, id, subject, description, notes, star;
  //First author
  String author;
  bool starred;
  Task({
    @required this.uuid,
    @required this.id,
    @required this.subject,
    @required this.description,
    this.starred = false,
    this.notes = "",
  });

  Task.fromMap(Map<String, dynamic> map): this(
    subject: map[db_subject],
    uuid: map[db_uuid],
    id: map[db_id],
    starred: map[db_star] == 1,
    notes: map[db_notes],
    description: map[db_description],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_subject: subject,
      db_uuid: uuid,
      db_id: id,
      db_notes: notes,
      db_star: starred? 1:0,
      db_description: description,
    };
  }

  getTaskId() {
    return id;
  }

  getSubject() {
    return subject;
  }
}

