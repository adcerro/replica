import 'package:hive_ce/hive_ce.dart';
import '../domain/entities/user.dart';
import '../domain/entities/transaction.dart';

@GenerateAdapters([AdapterSpec<User>(), AdapterSpec<Transaction>()])
part 'hive_adapters.g.dart';
