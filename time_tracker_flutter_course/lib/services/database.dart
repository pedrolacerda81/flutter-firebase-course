import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:time_tracker_flutter_course/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  final String uid;
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final FirestoreService _service = FirestoreService.instance;

  Future<void> createJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, documentIdFromCurrentDate()),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid), builder: (data) => Job.fromMap(data));
}
