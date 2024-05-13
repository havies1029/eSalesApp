import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';
import 'package:esalesapp/models/jobreal/jobrealcrud_model.dart';
import 'package:esalesapp/repositories/jobreal/jobrealcrud_repository.dart';

part 'jobrealcrud_event.dart';
part 'jobrealcrud_state.dart';

class JobRealCrudBloc extends Bloc<JobRealCrudEvents, JobRealCrudState> {
  final JobRealCrudRepository repository;
  JobRealCrudBloc({required this.repository})
      : super(const JobRealCrudState()) {
    on<JobRealCrudUbahEvent>(onUbahJobRealCrud);
    on<JobRealCrudTambahEvent>(onTambahJobRealCrud);
    on<JobRealCrudHapusEvent>(onHapusJobRealCrud);
    on<JobRealCrudLihatEvent>(onLihatJobRealCrud);
    on<ComboJobcatChangedEvent>(onComboJobcatChanged);
    on<ComboJobChangedEvent>(onComboJobChanged);
    on<ComboMediaChangedEvent>(onComboMediaChanged);
    on<ComboCustomerChangedEvent>(onComboCustomerChanged);
  }

  Future<void> onTambahJobRealCrud(
      JobRealCrudTambahEvent event, Emitter<JobRealCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.jobRealCrudTambah(event.record);
    hasFailure = !returnData.success;
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahJobRealCrud(
      JobRealCrudUbahEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.jobRealCrudUbah(event.record);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusJobRealCrud(
      JobRealCrudHapusEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.jobRealCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatJobRealCrud(
      JobRealCrudLihatEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    JobRealCrudModel record = await repository.jobRealCrudLihat(event.recordId);

    ComboJobcatModel? comboJobcat = record.comboJobcat;
    ComboJobModel? comboJob = record.comboJob;
    ComboCustomerModel? comboCustomer = record.comboCustomer;
    ComboMediaModel? comboMedia = record.comboMedia;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record,
      comboCustomer: comboCustomer, comboJob: comboJob, comboJobCat: comboJobcat,
      comboMedia: comboMedia));
  }

  Future<void> onComboJobcatChanged(
      ComboJobcatChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboJobcatModel comboJobcat = event.comboJobcat;
    ComboJobModel? comboJob;

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        comboJob: comboJob,
        comboJobCat: comboJobcat));
  }

  Future<void> onComboJobChanged(
      ComboJobChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboJobModel comboJob = event.comboJob;

    emit(state.copyWith(isLoading: false, isLoaded: true, comboJob: comboJob));
  }

  Future<void> onComboCustomerChanged(
      ComboCustomerChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboCustomerModel comboCustomer = event.comboCustomer;
    JobRealCrudModel rec = state.record!;
    rec.mrekanId = comboCustomer.mrekanId;
    rec.comboCustomer = comboCustomer;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onComboMediaChanged(
      ComboMediaChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboMediaModel comboMedia = event.comboMedia;
    JobRealCrudModel rec = state.record!;
    rec.mmediaId = comboMedia.mmediaId;
    rec.comboMedia = comboMedia;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }
}