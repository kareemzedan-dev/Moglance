
import '../../../domain/entities/bank_accounts_entity/bank_accounts_entity.dart';

class BankAccountsModel extends BankAccountsEntity {
  BankAccountsModel({
    super.id,
    super.bankName,
    super.accountName,
    super.accountNumber,
    super.iban,
    super.swiftCode,
    super.notes,
    super.isActive,
    super.createdAt,
    super.updatedAt,
  });

  factory BankAccountsModel.fromJson(Map<String, dynamic> json) {
    return BankAccountsModel(
      id: json['id'] as String?,
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      iban: json['iban'] as String?,
      swiftCode: json['swift_code'] as String?,
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
      'iban': iban,
      'swift_code': swiftCode,
      'notes': notes,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

  factory BankAccountsModel.fromEntity(BankAccountsEntity entity) {
    return BankAccountsModel(
      id: entity.id,
      bankName: entity.bankName,
      accountName: entity.accountName,
      accountNumber: entity.accountNumber,
      iban: entity.iban,
      swiftCode: entity.swiftCode,
      notes: entity.notes,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  BankAccountsEntity toEntity() {
    return BankAccountsEntity(
      id: id,
      bankName: bankName,
      accountName: accountName,
      accountNumber: accountNumber,
      iban: iban,
      swiftCode: swiftCode,
      notes: notes,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
