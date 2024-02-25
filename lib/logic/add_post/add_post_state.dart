part of 'add_post_bloc.dart';

sealed class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

final class AddPostInitial extends AddPostState {
  final EtatRequest etatRequest;
  final EtatField etatCoordonnees;
  const AddPostInitial({
    this.etatRequest = EtatRequest.none,
    this.etatCoordonnees = EtatField.none,
  });
  AddPostInitial copywith({
    EtatRequest? etatRequest,
    EtatField? etatCoordonnees,
  }) =>
      AddPostInitial(
        etatCoordonnees: etatCoordonnees ?? this.etatCoordonnees,
        etatRequest: etatRequest ?? this.etatRequest,
      );
  @override
  List<Object> get props => [etatCoordonnees, etatRequest];
}
