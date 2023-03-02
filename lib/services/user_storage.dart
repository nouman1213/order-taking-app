import 'package:get_storage/get_storage.dart';

class UserStorage {
  final _box = GetStorage();

  String get email => _box.read('email') ?? '';
  set email(String value) => _box.write('email', value);

  String get password => _box.read('password') ?? '';
  set password(String value) => _box.write('password', value);
}