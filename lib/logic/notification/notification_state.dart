part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {
  final List<NotificationModel> listNotifications;
  final EtatRequest etatRequest;
  const NotificationInitial({
    this.listNotifications = const [],
    this.etatRequest = EtatRequest.none,
  });
  NotificationInitial copywith(
      {EtatRequest? etatRequest, List<NotificationModel>? listNotifications}) {
    return NotificationInitial(
        listNotifications: listNotifications ?? this.listNotifications,
        etatRequest: etatRequest ?? this.etatRequest);
  }

  @override
  List<Object> get props => [listNotifications, etatRequest];
}
