import 'package:mpc_remote_control/app/core/enums/jump_distance.dart';

import '../models/command.dart';

final _commands = {
  "quickOpenFile": {"name": "Quick Open File", "cod": 969},
  "reopenFile": {"name": "Reopen File", "cod": 976},
  "close": {"name": "Close", "cod": 804},
  "exit": {"name": "Exit", "cod": 816},
  "togglePlayAndPause": {"name": "Toggle Play And Pause", "cod": 889},
  "play": {"name": "Play", "cod": 887},
  "pause": {"name": "Pause", "cod": 888},
  "stop": {"name": "Stop", "cod": 890},
  "frameStep": {"name": "Frame Step", "cod": 891},
  "frameStepBack": {"name": "Frame Step Back", "cod": 892},
  "increaseRate": {"name": "Increase Rate", "cod": 895},
  "decreaseRate": {"name": "Decrease Rate", "cod": 894},
  "resetRate": {"name": "Reset Rate", "cod": 896},
  "audioDelayAdd10Ms": {"name": "Audio Delay Add 10Ms", "cod": 905},
  "audioDelaySubtract10Ms": {"name": "Audio Delay Subtract 10Ms", "cod": 906},
  "jumpBackwardSmall": {"name": "Jump Backward Small", "cod": 899},
  "jumpBackwardMedium": {"name": "Jump Backward Medium", "cod": 901},
  "jumpBackwardLarge": {"name": "Jump Backward Large", "cod": 903},
  "jumpForwardSmall": {"name": "Jump Forward Small", "cod": 900},
  "jumpForwardMedium": {"name": "Jump Forward Medium", "cod": 902},
  "jumpForwardLarge": {"name": "Jump Forward Large", "cod": 904},
  "jumpToBeginning": {"name": "Jump To Beginning", "cod": 996},
  "jumpBackwardKeyframe": {"name": "Jump Backward Keyframe", "cod": 897},
  "jumpForwardKeyframe": {"name": "Jump Forward Keyframe", "cod": 898},
  "repeatForever": {"name": "Repeat Forever", "cod": 33449},
  "repeatModeFile": {"name": "Repeat Mode File", "cod": 33450},
  "repeatModePlaylist": {"name": "Repeat Mode Playlist", "cod": 33451},
  "next": {"name": "Next", "cod": 922},
  "previous": {"name": "Previous", "cod": 921},
  "nextFile": {"name": "Next File", "cod": 920},
  "previousFile": {"name": "Previous File", "cod": 919},
  "quickAddFavorite": {"name": "Quick Add Favorite", "cod": 975},
  "toggleSeekBar": {"name": "Toggle Seek Bar", "cod": 818},
  "toggleControls": {"name": "Toggle Controls", "cod": 819},
  "toggleStatus": {"name": "Toggle Status", "cod": 822},
  "togglePlaylistBar": {"name": "Toggle Playlist Bar", "cod": 824},
  "fullscreen": {"name": "Fullscreen", "cod": 830},
  "zoom25": {"name": "Zoom 25", "cod": 813},
  "zoom50": {"name": "Zoom 50", "cod": 832},
  "zoom100": {"name": "Zoom 100", "cod": 833},
  "zoom200": {"name": "Zoom 200", "cod": 834},
  "zoomAutoFit": {"name": "Zoom Auto Fit", "cod": 968},
  "zoomAutoFitLargerOnly": {"name": "Zoom Auto Fit Larger Only", "cod": 4900},
  "vidFrmHalf": {"name": "Video From Half", "cod": 835},
  "vidFrmNormal": {"name": "Video From Normal", "cod": 836},
  "vidFrmDouble": {"name": "Video From Double", "cod": 837},
  "vidFrmStretch": {"name": "Video From Stretch", "cod": 838},
  "vidFrmInside": {"name": "Video From Inside", "cod": 839},
  "vidFrmOutside": {"name": "Video From Outside", "cod": 840},
  "vidFrmZoom1": {"name": "Video From Zoom 1", "cod": 841},
  "vidFrmZoom2": {"name": "Video From Zoom 2", "cod": 842},
  "vidFrmSwitchZoom": {"name": "Video From Switch Zoom", "cod": 843},
  "alwaysOnTop": {"name": "Always On Top", "cod": 919},
  "pnsReset": {"name": "PNS Reset", "cod": 861},
  "pnsIncSize": {"name": "PNS Increase Size", "cod": 862},
  "pnsIncWidth": {"name": "PNS Increase Width", "cod": 864},
  "pnsIncHeight": {"name": "PNS Increase Height", "cod": 866},
  "pnsDecSize": {"name": "PNS Decrease Size", "cod": 863},
  "pnsDecWidth": {"name": "PNS Decrease Width", "cod": 865},
  "pnsDecHeight": {"name": "PNS Decrease Height", "cod": 867},
  "pnsCenter": {"name": "PNS Center", "cod": 876},
  "pnsLeft": {"name": "PNS Left", "cod": 868},
  "pnsRight": {"name": "PNS Right", "cod": 869},
  "pnsUp": {"name": "PNS Up", "cod": 870},
  "pnsDown": {"name": "PNS Down", "cod": 871},
  "pnsUpLeft": {"name": "PNS Up Left", "cod": 872},
  "pnsUpRight": {"name": "PNS Up Right", "cod": 873},
  "pnsDownLeft": {"name": "PNS Down Left", "cod": 874},
  "pnsDownRight": {"name": "PNS Down Right", "cod": 875},
  "pnsRotateX": {"name": "PNS  Rotate X", "cod": 877},
  "pnsSubtractRotateX": {"name": "PNS Subtract Rotate X", "cod": 878},
  "pnsRotateY": {"name": "PNS  Rotate Y", "cod": 879},
  "pnsSubtractRotateY": {"name": "PNS Subtract Rotate Y", "cod": 880},
  "pnsRotateZ": {"name": "PNS  Rotate Z", "cod": 881},
  "pnsSubtractRotateZ": {"name": "PNS Subtract Rotate Z", "cod": 882},
  "volumeUp": {"name": "Volume Up", "cod": 907},
  "volumeDown": {"name": "Volume Down", "cod": 908},
  "volumeMute": {"name": "Volume Mute", "cod": 909},
  "volumeBoostIncrease": {"name": "Volume Boost Increase", "cod": 970},
  "volumeBoostDecrease": {"name": "Volume Boost Decrease", "cod": 971},
  "volumeBoostMin": {"name": "Volume Boost Min", "cod": 972},
  "volumeBoostMax": {"name": "Volume Boost Max", "cod": 973},
  "toggleRegainVolume": {"name": "Toggle Regain Volume", "cod": 995},
  "brightnessIncrease": {"name": "Brightness Increase", "cod": 984},
  "brightnessDecrease": {"name": "Brightness Decrease", "cod": 985},
  "contrastIncrease": {"name": "Contrast Increase", "cod": 986},
  "contrastDecrease": {"name": "Contrast Decrease", "cod": 987},
  "hueIncrease": {"name": "Hue Increase", "cod": 988},
  "hueDecrease": {"name": "Hue Decrease", "cod": 989},
  "saturationIncrease": {"name": "Saturation Increase", "cod": 990},
  "saturationDecrease": {"name": "Saturation Decrease", "cod": 991},
  "resetColorSettings": {"name": "Reset Color Settings", "cod": 992},
  "nextAudioTrack": {"name": "Next Audio Track", "cod": 952},
  "prevAudioTrack": {"name": "Previous Audio Track", "cod": 953},
  "nextSubtitleTrack": {"name": "Next Subtitle Track", "cod": 954},
  "prevSubtitleTrack": {"name": "Previous Subtitle Track", "cod": 955},
  "toggleSubtitle": {"name": "Toggle Subtitle", "cod": 956},
  "gotoPrevSubtitle": {"name": "Go to Previous Subtitle", "cod": 32780},
  "gotoNextSubtitle": {"name": "Go to Next Subtitle", "cod": 32781},
  "vsync": {"name": "Vsync", "cod": 33243},
  "subtitleSubtractDelay": {"name": "Subtitle Subtract Delay", "cod": 24000},
  "subtitleDelay": {"name": "Subtitle  Delay", "cod": 24001},
  "afterPlaybackDoNothing": {"name": "After Playback Do Nothing", "cod": 948},
  "afterPlaybackPlayNextFileInTheFolder": {"name": "After Playback Play Next File In The Folder", "cod": 947},
  "afterPlaybackTurnOffTheMonitor": {"name": "After Playback Turn Off The Monitor", "cod": 918},
  "afterPlaybackExit": {"name": "After Playback Exit", "cod": 912},
  "afterPlaybackStandBy": {"name": "After Playback Stand By", "cod": 913},
  "afterPlaybackHibernate": {"name": "After Playback Hibernate", "cod": 914},
  "afterPlaybackShutdown": {"name": "After Playback Shutdown", "cod": 915},
  "afterPlaybackLogOff": {"name": "After Playback Logoff", "cod": 916},
  "afterPlaybackLock": {"name": "After Playback Lock", "cod": 917},
};

Command _getCommand(String key) {
  return Command(
    name: _commands[key]?['name'] as String,
    cod: _commands[key]?['cod'] as int,
  );
}

class ControllerCommands {
  static List<Command> get listCommands => _commands.entries
      .map(
        (e) => Command(
          name: e.value['name'] as String,
          cod: e.value['cod'] as int,
        ),
      )
      .toList(growable: false);

  static Command jumpBackward(JumpDistance jumpDistance) {
    switch (jumpDistance) {
      case JumpDistance.small:
        return _getCommand("jumpBackwardSmall");
      case JumpDistance.medium:
        return _getCommand("jumpBackwardMedium");
      case JumpDistance.large:
        return _getCommand("jumpBackwardLarge");
    }
  }

  static Command jumpForward(JumpDistance jumpDistance) {
    switch (jumpDistance) {
      case JumpDistance.small:
        return _getCommand("jumpForwardSmall");
      case JumpDistance.medium:
        return _getCommand("jumpForwardMedium");
      case JumpDistance.large:
        return _getCommand("jumpForwardLarge");
    }
  }

  static const volume = Command(name: "Volume", cod: -2);
  static const seek = Command(name: "Volume", cod: -1);

  static final togglePlayPause = _getCommand("togglePlayAndPause");
  static final play = _getCommand("play");
  static final pause = _getCommand("pause");
  static final stop = _getCommand("stop");
  static final previous = _getCommand("previous");
  static final previousFile = _getCommand("previousFile");
  static final next = _getCommand("next");
  static final nextFile = _getCommand("nextFile");
  static final nextAudioTrack = _getCommand("nextAudioTrack");
  static final nextSubtitleTrack = _getCommand("nextSubtitleTrack");
  static final volumeUp = _getCommand("volumeUp");
  static final volumeDown = _getCommand("volumeDown");
  static final jumpForwardSmall = _getCommand("jumpForwardSmall");
  static final jumpForwardMedium = _getCommand("jumpForwardMedium");
  static final jumpForwardLarge = _getCommand("jumpForwardLarge");
  static final jumpBackwardSmall = _getCommand("jumpBackwardSmall");
  static final jumpBackwardMedium = _getCommand("jumpBackwardMedium");
  static final jumpBackwardLarge = _getCommand("jumpBackwardLarge");
  static final fulllscreen = _getCommand("fullscreen");
  static final toggleSubtitle = _getCommand("toggleSubtitle");
}
