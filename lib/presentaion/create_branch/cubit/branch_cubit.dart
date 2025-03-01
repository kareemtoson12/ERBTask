import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/data/DAO/Branch_dao.dart';

import 'package:task/domain/models/branch.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchDao databaseObject;

  BranchCubit(this.databaseObject) : super(BranchInitial());

  Future<void> fetchBranches() async {
    try {
      emit(BranchLoading());
      final branches = await databaseObject.getBranches();
      emit(BranchLoaded(branches));
    } catch (e) {
      emit(BranchError('Failed to load branches'));
    }
  }

  Future<void> addBranch(Branch branch) async {
    try {
      await databaseObject.insertBranch(branch);
      fetchBranches();
    } catch (e) {
      emit(BranchError('Failed to add branch'));
    }
  }

  Future<void> deleteBranch(int id) async {
    try {
      await databaseObject.deleteBranch(id);
      fetchBranches();
    } catch (e) {
      emit(BranchError('Failed to delete branch'));
    }
  }
}
