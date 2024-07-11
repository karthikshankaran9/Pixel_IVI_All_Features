
enum ActionButtonCurrentEvent {
  onSkipBackward,
  onFavourite,
  onStop,
  onSkipForward,
}

enum ButtonState{
  normal,
  selected,
  unselected,
}

String getFMImageFolderName() {
  return "assets/images/fm";
}

 List<String> backwardkImages = [
    'p_icon_48X48_backward.svg',
    'p_icon_48X48_backward_selected.svg',
    'p_icon_48X48_backward_unselected.svg',
  ];

  List<String> favouriteImages = [
    'p_icon_48X48_favourite_add_selected.svg',
    'p_icon_48X48_favourite_sub_selected.svg',
    'p_icon_48X48_favourite_add_unselected.svg',
  ];

  List<String> stopImages = [
    'p_icon_48X48_power_icon.svg',
  ];

  List<String> forwardImages = [
    'p_icon_48X48_forward.svg',
    'p_icon_48X48_forward_selected.svg',
    'p_icon_48X48_forward_unselected.svg',
  ];

   List<String> increaseImages = [
    'p_icon_48X48_add_normal.svg',
    'p_icon_48X48_add_selected.svg',
    'p_icon_48X48_add_disabled.svg',
  ];

  List<String> decreaseImages = [
    'p_icon_48X48_minus_normal.svg',
    'p_icon_48X48_minus_selected.svg',
    'p_icon_48X48_minus_disabled.svg',
  ];