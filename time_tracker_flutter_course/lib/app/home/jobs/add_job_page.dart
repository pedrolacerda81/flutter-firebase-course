import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/commun_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/commun_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class AddJobPage extends StatefulWidget {
  final Database database;

  const AddJobPage({Key key, @required this.database}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final Database database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJobPage(
          database: database,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (allNames.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please, choose a different job name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final job = Job(name: _name, ratePerHour: _ratePerHour);
          await widget.database.createJob(job);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Job'),
        elevation: 2.0,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  SingleChildScrollView _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child:
              Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildColumnChildren(),
      ),
    );
  }

  List<Widget> _buildColumnChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Job Name',
        ),
        validator: (String value) =>
            value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (String value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Rate per Hour',
        ),
        onSaved: (String value) => _ratePerHour = int.tryParse(value) ?? 0,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
      ),
    ];
  }
}
