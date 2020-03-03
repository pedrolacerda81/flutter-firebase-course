import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'package:time_tracker_flutter_course/app/home/models/job.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FireStoreDatabase implements Database {
  final String uid;
  FireStoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) async {
    final path = '/users/$uid/jobs/job_abc';
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
  }
}