import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

typedef RealtimeCallback =
    void Function(Map<String, dynamic> record, String action);
final supabase = Supabase.instance.client;

@singleton
class SupabaseService {
  final SupabaseClient supabaseClient;

  SupabaseService(this.supabaseClient);

  // ============ BASIC CRUD OPERATIONS ============

  /// Create a single record
  Future<Map<String, dynamic>> create({
    required String table,
    required Map<String, dynamic> data,
    bool generateId = true,
  }) async {
    try {
      final Map<String, dynamic> recordData = Map.from(data);

      if (generateId && !recordData.containsKey('id')) {
        recordData['id'] = const Uuid().v4();
      }

      final response =
          await supabaseClient
              .from(table)
              .insert(recordData)
              .select()
              .single();

      return response;
    } on PostgrestException catch (e) {
      throw Exception('Failed to create record in $table: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> createMultiple({
    required String table,
    required List<Map<String, dynamic>> data,
    bool generateIds = true,
  }) async {
    try {
      final List<Map<String, dynamic>> recordsData =
          data.map((item) {
            if (generateIds && !item.containsKey('id')) {
              return {...item, 'id': const Uuid().v4()};
            }
            return Map<String, dynamic>.from(item);
          }).toList();

      final response =
          await supabaseClient.from(table).insert(recordsData).select();

      // الطريقة الآمنة للتحويل
      return response.map<Map<String, dynamic>>((item) {
        return Map<String, dynamic>.from(item as Map<dynamic, dynamic>);
      }).toList();
    } on PostgrestException catch (e) {
      throw Exception(
        'Failed to create multiple records in $table: ${e.message}',
      );
    }
  }

  /// Get a single record by ID
  Future<Map<String, dynamic>?> getById({
    required String table,
    required String id,
    List<String>? columns,
  }) async {
    try {
      final query = supabaseClient
          .from(table)
          .select(columns != null ? columns.join(', ') : '*')
          .eq('id', id);

      final response = await query.maybeSingle();
      return response;
    } on PostgrestException catch (e) {
      throw Exception('Failed to get record from $table: ${e.message}');
    }
  }

  /// Get all records with optional filtering and pagination
  /// Get all records with optional filtering and pagination
  Future<List<Map<String, dynamic>>> getAll({
    required String table,
    Map<String, dynamic>? filters,
    List<String>? columns,
    int? limit,
    int? offset,
    String? orderBy,
    bool ascending = true,
  }) async {
    try {
      // البدء بـ PostgrestFilterBuilder ثم التحويل
      PostgrestFilterBuilder<PostgrestList> query = supabaseClient
          .from(table)
          .select(columns != null ? columns.join(', ') : '*');

      if (filters != null) {
        filters.forEach((key, value) {
          if (value != null) { // ← مهم جداً
            if (value is List) {
              query = query.inFilter(key, value);
            } else {
              query = query.eq(key, value);
            }
          }
        });
      }



      // التحويل إلى PostgrestTransformBuilder للطلب والتقسيم
      PostgrestTransformBuilder<PostgrestList> transformQuery = query;

      // Apply ordering
      if (orderBy != null) {
        transformQuery = transformQuery.order(orderBy, ascending: ascending);
      }

      // Apply pagination
      if (limit != null) {
        transformQuery = transformQuery.limit(limit);
        if (offset != null) {
          transformQuery = transformQuery.range(offset, offset + limit - 1);
        }
      }
      final response = await transformQuery;

// filter out anything that is not a Map
      final safeResponse = response
          .whereType<Map>()  // بس العنصر اللي هو Map
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      return safeResponse;


    } on PostgrestException catch (e) {
      throw Exception('Failed to get records from $table: ${e.message}');
    }
  }

  /// Update a record by ID
  Future<Map<String, dynamic>> update({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response =
          await supabaseClient
              .from(table)
              .update(data)
              .eq('id', id)
              .select()
              .single();

      return response;
    } on PostgrestException catch (e) {
      throw Exception('Failed to update record in $table: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> updateMultiple({
    required String table,
    required Map<String, dynamic> data,
    Map<String, dynamic>? conditions,
  }) async {
    try {
      // البدء بـ PostgrestFilterBuilder ثم إضافة الشروط
      var query = supabaseClient.from(table).update(data);

      // Apply conditions
      if (conditions != null) {
        conditions.forEach((key, value) {
          if (value is List) {
            query = query.inFilter(key, value);
          } else {
            query = query.eq(key, value);
          }
        });
      }

      // التحويل إلى select للحصول على البيانات المحدثة
      final response = await query.select();
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw Exception(
        'Failed to update multiple records in $table: ${e.message}',
      );
    }
  }

  /// Delete a record by ID
  Future<void> delete({required String table, required String id}) async {
    try {
      await supabaseClient.from(table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw Exception('Failed to delete record from $table: ${e.message}');
    }
  }

  /// Delete multiple records with conditions
  Future<void> deleteMultiple({
    required String table,
    Map<String, dynamic>? conditions,
  }) async {
    try {
      var query = supabaseClient.from(table).delete();

      // Apply conditions
      if (conditions != null) {
        conditions.forEach((key, value) {
          if (value is List) {
            query = query.inFilter(key, value);
          } else {
            query = query.eq(key, value);
          }
        });
      }

      await query;
    } on PostgrestException catch (e) {
      throw Exception(
        'Failed to delete multiple records from $table: ${e.message}',
      );
    }
  }

  Future<int> count({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = supabaseClient.from(table).select('id');

      // Apply filters
      if (filters != null) {
        filters.forEach((key, value) {
          if (value is List) {
            query = query.inFilter(key, value);
          } else {
            query = query.eq(key, value);
          }
        });
      }

      final response = await query;
      return response.length;
    } on PostgrestException catch (e) {
      throw Exception('Failed to count records in $table: ${e.message}');
    }
  }

  // ============ ADVANCED QUERIES ============

  /// Execute custom query using RPC
  Future<List<Map<String, dynamic>>> customQuery({
    required String functionName,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await supabaseClient.rpc(
        functionName,
        params: parameters ?? {},
      );
      return List<Map<String, dynamic>>.from(response as List);
    } on PostgrestException catch (e) {
      throw Exception('Failed to execute custom query: ${e.message}');
    }
  }
  Stream<List<Map<String, dynamic>>> subscribeToTableByValue({
    required String table,
    String? column,
    String? value,
  }) {
    final baseStream = supabaseClient.from(table).stream(primaryKey: ['id']);

    final filteredStream = (column != null && value != null)
        ? (baseStream).eq(column, value)
        : baseStream;

    return filteredStream.map(
          (events) => events.map((e) => e).toList(),
    );
  }

  Future<List<Map<String, dynamic>>> search({
    required String table,
    required String searchColumn,
    required String searchTerm,
    List<String>? columns,
    int? limit,
  }) async {
    try {
      PostgrestTransformBuilder<PostgrestList> query = supabaseClient
          .from(table)
          .select(columns != null ? columns.join(', ') : '*')
          .textSearch(searchColumn, searchTerm);

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw Exception('Failed to search records in $table: ${e.message}');
    }
  }

  // ============ REALTIME SUBSCRIPTIONS ============

  /// Subscribe to table changes
  Stream<List<Map<String, dynamic>>> subscribeToTable({
    required String table,
    String? filter,
  }) {
    return supabaseClient
        .from(table)
        .stream(primaryKey: ['id'])
        .map((events) => events.map((e) => e).toList());
  }

  /// Subscribe to specific record changes
  Stream<Map<String, dynamic>?> subscribeToRecord({
    required String table,
    required String recordId,
  }) {
    return supabaseClient
        .from(table)
        .stream(primaryKey: ['id'])
        .eq('id', recordId)
        .map(
          (events) =>
              events.isNotEmpty ? events.first : null,
        );
  }

  /// Advanced realtime subscription with callbacks
  RealtimeChannel subscribeWithCallbacks({
    required String table,
    required RealtimeCallback onData,
    String schema = 'public',
  }) {
    final channel = supabaseClient.channel('custom_${table}_channel');

    channel
        .onPostgresChanges(
          schema: schema,
          table: table,
          event: PostgresChangeEvent.all,
          callback: (payload) {
            onData(
              Map<String, dynamic>.from(payload.newRecord ?? {}),
              payload.eventType.name,
            );
          },
        )
        .subscribe();

    return channel;
  }

  // ============ FILE STORAGE OPERATIONS ============

  /// Upload file to storage
  Future<String> uploadFile({
    required String bucket,
    required String filePath,
    String? fileName,
    File? file,
  }) async {
    try {
      final String actualFileName = fileName ?? filePath.split('/').last;

      if (file != null) {
        await supabaseClient.storage.from(bucket).upload(actualFileName, file);
      } else {
        await supabaseClient.storage
            .from(bucket)
            .upload(actualFileName, File(filePath));
      }

      return supabaseClient.storage.from(bucket).getPublicUrl(actualFileName);
    } on StorageException catch (e) {
      throw Exception('Failed to upload file: ${e.message}');
    }
  }

  /// Download file URL
  String getFileUrl({required String bucket, required String fileName}) {
    return supabaseClient.storage.from(bucket).getPublicUrl(fileName);
  }

  /// Delete file from storage
  Future<void> deleteFile({
    required String bucket,
    required String fileName,
  }) async {
    try {
      await supabaseClient.storage.from(bucket).remove([fileName]);
    } on StorageException catch (e) {
      throw Exception('Failed to delete file: ${e.message}');
    }
  }

  // ============ AUTHENTICATION HELPERS ============

  /// Get current user
  User? get currentUser => supabaseClient.auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => supabaseClient.auth.currentUser != null;

  // ============ UTILITY METHODS ============

  /// Check if record exists
  Future<bool> exists({required String table, required String id}) async {
    final record = await getById(table: table, id: id);
    return record != null;
  }

  /// Execute transaction (batch operations)
  Future<void> executeTransaction(List<Future<dynamic>> operations) async {
    try {
      await Future.wait(operations);
    } catch (e) {
      throw Exception('Transaction failed: $e');
    }
  }

  // ============ BATCH OPERATIONS ============

  /// Execute multiple operations in batch
  Future<List<dynamic>> executeBatch(List<Future<dynamic>> operations) async {
    try {
      return await Future.wait(operations);
    } catch (e) {
      throw Exception('Batch operation failed: $e');
    }
  }

  /// Upsert operation (insert or update)
  Future<Map<String, dynamic>> upsert({
    required String table,
    required Map<String, dynamic> data,
    String? onConflict,
  }) async {
    try {
      final response =
          await supabaseClient
              .from(table)
              .upsert(data, onConflict: onConflict)
              .select()
              .single();

      return response;
    } on PostgrestException catch (e) {
      throw Exception('Failed to upsert record in $table: ${e.message}');
    }
  }

  // ============ CLEANUP ============

  @disposeMethod
  void dispose() {
    // Cleanup any resources if needed
  }


  Future<Map<String, dynamic>?> updateDataInSupabase({
    required String tableName,
    required Map<String, dynamic> data,
    required Map<String, dynamic> match,
  }) async {
    try {
      var query = supabase.from(tableName).update(data);


      match.forEach((key, value) {
        query = query.eq(key, value);
      });

      final updatedData = await query.select().maybeSingle();

      print('Data updated successfully in $tableName: $updatedData');
      return updatedData;
    } catch (e) {
      print('Exception updating in $tableName: $e');
      return null;
    }
  }
  Future<Map<String, dynamic>?> sendDataToSupabase({
    required String tableName,
    required Map<String, dynamic> data,
    String? conflictColumn,
  }) async {
    try {
      final insertedData = await supabase
          .from(tableName)
          .upsert(data, onConflict: conflictColumn)
          .select()
          .single();

      print('Data inserted/updated successfully into $tableName: $insertedData');
      return insertedData;
    } catch (e) {
      print('Exception inserting/updating into $tableName: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getDataFromSupabase({
    required String tableName,
    Map<String, dynamic>? filters,
    String? or, // 👈 عشان تدعم or
  }) async {
    try {
      var query = supabase.from(tableName).select();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      if (or != null) {
        query = query.or(or);
      }

      final response = await query;

      print('Data fetched successfully from $tableName: $response');
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Exception fetching from $tableName: $e');
      return null;
    }
  }


}
