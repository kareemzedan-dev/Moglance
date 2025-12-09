import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/services/supabase_service.dart';
import '../../../data_sources/remote/get_bank_accounts_remote_data_source/get_bank_accounts_remote_data_source.dart';
import '../../../models/bank_accounts_model/bank_accounts_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: GetBankAccountsRemoteDataSource)
class GetBankAccountsRemoteDataSourceImpl
    implements GetBankAccountsRemoteDataSource {

  final SupabaseService service;
  RealtimeChannel? _channel;

  GetBankAccountsRemoteDataSourceImpl(this.service);

  // STREAM باستخدام StreamController
  final _controller = StreamController<Either<Failures, List<BankAccountsModel>>>.broadcast();

  @override
  Stream<Either<Failures, List<BankAccountsModel>>> subscribeToBankAccounts() {
    _initRealtime();
    return _controller.stream;
  }

  void _initRealtime() async {
    // 1️⃣ أول Fetch
    final initialData = await getBankAccountsFromRemote();
    _controller.add(initialData);

    // 2️⃣ Realtime Updates
    _channel = Supabase.instance.client
        .channel('bank_accounts_changes')
        .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'bank_accounts',
      callback: (payload) async {
        final updated = await getBankAccountsFromRemote();
        _controller.add(updated); // 🔥 مفيش yield هنا
      },
    ).subscribe();
  }

  @override
  Future<Either<Failures, List<BankAccountsModel>>> getBankAccountsFromRemote() async {
    try {
      final List<Map<String, dynamic>> response = await service.getAll(
        table: 'bank_accounts',
        filters: {'is_active': true},
      );

      if (response.isEmpty) return const Right([]);

      final accounts =
      response.map((json) => BankAccountsModel.fromJson(json)).toList();

      return Right(accounts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    _controller.close();
  }
}
