class BankAccountsEntity {
  final String? id;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final String? iban;
  final String? swiftCode;
  final String? notes;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BankAccountsEntity({
    this.id,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.iban,
    this.swiftCode,
    this.notes,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });
}
