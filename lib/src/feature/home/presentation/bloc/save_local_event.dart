part of 'save_local_bloc.dart';

@immutable
sealed class SaveLocalEvent {}
class SaveLocally extends SaveLocalEvent{
  final List<StudioModel> params;

  SaveLocally({required this.params});
}