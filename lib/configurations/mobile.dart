import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
Future<void> saveAndLaunchFile(List<int> bytes) async{
  final directory = await getExternalStorageDirectory();
  final path=directory!.path;
  final file=File('$path/Outpout.pdf');
  await file.writeAsBytes(bytes,flush: true);
  OpenFile.open('$path/Output.pdf');

}

