import 'package:ali_pasha_graph/models/user_model.dart';

class BalanceModel {
  int? id;
  double? credit;
  double? debit;
  double? total;
  String? info;
  String? createdAt;
  UserModel? user;

  BalanceModel(
      {this.id,
      this.info,
      this.createdAt,
      this.credit,
      this.debit,
      this.total,
      this.user});

  factory BalanceModel.fromJson(Map<String, dynamic> data) {
    UserModel? dataUser = null;
    if (data['user'] != null) {
      dataUser = UserModel.fromJson(data['user']);
    }
    return BalanceModel(
      id: int.tryParse("${data['id']}"),
      info: "${data['info'] ?? ''}",
      createdAt: "${data['created_at'] ?? ''}",
      credit: double.tryParse("${data['credit'] ?? 0}"),
      debit: double.tryParse("${data['debit'] ?? 0}"),
      total: double.tryParse("${data['total'] ?? 0}"),
      user: dataUser,
    );
  }
}
