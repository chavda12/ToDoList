import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

late BuildContext navigationContext;
 Box? todoBox;
String id = Uuid().v1();