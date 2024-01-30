part of add_card;

abstract class AddCardState extends Equatable {
  const AddCardState();
}

class AddCardInitial extends AddCardState {
  @override
  List<Object> get props => [];
}

class AddCardReady extends AddCardState {
  @override
  List<Object> get props => [];
}

class AddCardSuccess extends AddCardState {
  @override
  List<Object> get props => [];
}