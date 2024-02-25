import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solutionchallenge2024/models/notification.dart';
import 'package:solutionchallenge2024/services/firestore.dart';
import 'package:solutionchallenge2024/utils/enum.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirestoreService service = FirestoreService();
  late StreamSubscription subscription;
  NotificationBloc() : super(const NotificationInitial()) {
    on<LoadData>((event, emit) async {
      try {
        emit((state as NotificationInitial)
            .copywith(etatRequest: EtatRequest.loading));
        var data = await service.getAllNotifications();
        emit((state as NotificationInitial).copywith(
            etatRequest: EtatRequest.loaded, listNotifications: data));
      } catch (e) {
        emit((state as NotificationInitial)
            .copywith(etatRequest: EtatRequest.error));
      }
    });
    subscription = service.streamNotifications().listen((event) {
      add(LoadData());
    });
  }
  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
