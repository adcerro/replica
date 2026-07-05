import 'package:hive_ce/hive_ce.dart';
import '../domain/entities/category_info.dart';
import '../domain/entities/user.dart';
import '../domain/entities/transaction.dart';

@GenerateAdapters([
  AdapterSpec<User>(),
  AdapterSpec<Transaction>(),
  AdapterSpec<CategoryInfo>(),
])
part 'hive_adapters.g.dart';
