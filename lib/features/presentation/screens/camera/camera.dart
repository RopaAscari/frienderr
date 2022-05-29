import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frienderr/core/enums/enums.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:frienderr/core/injection/injection.dart';
import 'package:frienderr/features/presentation/navigation/app_router.dart';
import 'package:frienderr/features/presentation/screens/camera/widgets/deep_ar/deep_ar_camera.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frienderr/core/constants/constants.dart';
import 'package:frienderr/features/domain/entities/bloc_group.dart';
import 'package:frienderr/features/presentation/widgets/gallery.dart';
import 'package:frienderr/features/presentation/blocs/user/user_bloc.dart';
import 'package:frienderr/features/presentation/blocs/theme/theme_bloc.dart';
import 'package:frienderr/features/presentation/blocs/camera/camera_bloc.dart';
import 'package:frienderr/features/presentation/widgets/asset_image_fullscreen.dart';
import 'package:frienderr/features/presentation/widgets/asset_video_fullscreen.dart';
import 'package:frienderr/features/presentation/widgets/conditional_render_delegate.dart';
import 'package:frienderr/features/presentation/screens/camera/widgets/camera_list_item.dart';

const mediaOptions = ['Posts', 'Stories', 'Quicks'];

class CameraScreen extends StatefulWidget {
  final BlocGroup blocGroup;
  final CameraSelectionMode mode;

  const CameraScreen({Key? key, required this.mode, required this.blocGroup})
      : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  double progress = 0;
  late File thumbnail;
  bool isRecording = false;
  late Timer recordingTimer;

  int currentTimelineIndex = 0;
  late AnimationController _animation;
  bool _isThumbnailInitialzed = false;
  late CameraSelectionMode _cameraMode;
  List<CameraFeatureMode> selectedFeatures = [];
  AssetType _thumbnailType = AssetType.image;
  late Future<File?> _initializeImageThumbnailFuture;
  late Future<Uint8List?> _initializeVideoThumbnailFuture;
  CameraBloc get _cameraBloc => widget.blocGroup.cameraBloc;
  late final CameraFeatures _cameraFeatures = CameraFeatures.idle;

  bool get isStory {
    return _cameraMode == CameraSelectionMode.story;
  }

  bool get isPost {
    return _cameraMode == CameraSelectionMode.post;
  }

  bool get isQuick {
    return _cameraMode == CameraSelectionMode.snap;
  }

  bool get isMultiSelect {
    return _cameraFeatures == CameraFeatures.mutliselect;
  }

  dynamic resultIcon = SvgPicture.asset(
    Constants.postIcon,
    width: 35,
    height: 35,
    color: Colors.grey[600],
  );

  @override
  void initState() {
    _cameraMode = widget.mode;

    _cameraBloc.add(const CameraEvent.initializeCamera());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAssetThumbnail();
    });

    _animation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _cameraBloc.add(const CameraEvent.disposeCamera());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _fetchAssetThumbnail() async {
    const offset = 0;
    final albums = await PhotoManager.getAssetPathList(type: RequestType.all);
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1, // end at a very big index (to get all the assets)
    );

    if (recentAssets[offset].type == AssetType.image) {
      _initializeImageThumbnailFuture = recentAssets[offset].file;
      _initializeVideoThumbnailFuture = Future.value(Uint8List(1));
    } else {
      _initializeVideoThumbnailFuture = recentAssets[offset].thumbnailData;
      _initializeImageThumbnailFuture = Future.value(File(''));
    }

    setState(() {
      _isThumbnailInitialzed = true;
      _thumbnailType = recentAssets[offset].type;
    });
  }

  void _initializeDuration() async {
    final _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (Timer _timer) => setState(
        () {
          progress = _timer.tick / 1000;
        },
      ),
    );

    setState(() {
      recordingTimer = _timer;
    });
  }

  Future<void> _displayPhotoMediaTaken(Future<File?> file) async {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AssetImageFullscreen(file: file);
        });
  }

  Future<void> _displayVideoMediaTaken(Future<File?> file) async {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AssetVideoFullscreen(file: file);
        });
  }

  void _startVideoRecording(CameraController controller) async {
    setState(() {
      isRecording = true;
    });
    _initializeDuration();
    controller.startVideoRecording();
  }

  void _stopVideoRecording(CameraController controller) async {
    setState(() {
      isRecording = false;
    });
    recordingTimer.cancel();
    final XFile file = await controller.stopVideoRecording();

    final futureFile = Future(() => File(file.path));
    _displayVideoMediaTaken(futureFile);
  }

  void _takePicture(CameraController controller) async {
    try {
      final image = await controller.takePicture();

      final futureFile = Future(() => File(image.path));
      _displayPhotoMediaTaken(futureFile);
      return;
    } catch (e) {}
  }

  void _openGallery() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => Gallery(
                cameraMode: _cameraMode, blocGroup: widget.blocGroup))));
  }

  Future<void> _determineFeatureAction(CameraFeatureMode mode) async {
    if (!selectedFeatures.contains(mode)) {
      setState(() {
        selectedFeatures = [...selectedFeatures, mode];
      });
    } else {
      setState(() {
        selectedFeatures = List.from(selectedFeatures)
          ..removeAt(selectedFeatures.indexWhere((element) => element == mode));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<CameraBloc, CameraState>(
        listenWhen: (CameraState prevState, CameraState currentState) {
          return true;
        },
        listener: (BuildContext context, CameraState state) {
          if (state.action == CameraListenableAction.flashToggledOn ||
              state.action == CameraListenableAction.flashToggledOff) {
            setState(() {});
          }
        },
        builder: (BuildContext context, CameraState state) {
          switch (state.currentState) {
            case CameraStatus.initializing:
              return _cameraInitializing();
            case CameraStatus.error:
              return _cameraError();
            case CameraStatus.initialized:
              return _cameraInitialized(state);

            default:
              return const Center();
          }
        },
        bloc: _cameraBloc,
      ),
    ));
  }

  Widget _cameraInitialized(CameraState state) {
    final CameraController _controller = state.controller as CameraController;

    return Column(children: [
      Stack(children: <Widget>[
        _cameraWidget(state),
        _cameraFeatureList(state),
        _cameraModes(state),
        _cameraSubModes(state),
        _recordingDuration(),
        _captureButton(_controller),
        _headerWidget(_controller),
        _cameraOptions(_controller),
      ]),
    ]);
  }

  Widget _cameraInitializing() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _cameraError() {
    return const Center(child: Text('Could not initialize camera!'));
  }

  Widget _cameraModes(CameraState state) {
    return Positioned(
      child: SizedBox(
          width: 200,
          height: 400,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.cameraSelectionModes.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    child: CameraListItem(
                      icon: state.cameraSelectionModes[index].icon,
                      title: state.cameraSelectionModes[index].title,
                      isSelected:
                          _cameraMode == state.cameraSelectionModes[index].mode,
                    ),
                    onTap: () {
                      setState(() {
                        _cameraMode = state.cameraSelectionModes[index].mode;
                      });
                    });
              })),
      left: 10,
      top: MediaQuery.of(context).size.height * .20,
    );
  }

  Widget _cameraFeatureList(CameraState state) {
    return Positioned(
      child: SizedBox(
          width: 200,
          height: 400, //_determineFeatureAction
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.cameraFeatureList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    child: CameraListItem(
                      icon: state.cameraFeatureList[index].icon,
                      title: state.cameraFeatureList[index].title,
                      isSelected: selectedFeatures
                          .contains(state.cameraFeatureList[index].mode),
                    ),
                    onTap: () {
                      setState(() {
                        _determineFeatureAction(
                            state.cameraFeatureList[index].mode);
                      });
                    });
                ;
              })),
      right: 0,
      top: MediaQuery.of(context).size.height * .20,
    );
  }

  Widget _cameraSubModes(CameraState state) {
    return Positioned(
      child: ConditionalRenderDelegate(
          condition: isStory || isPost,
          renderWidget: SizedBox(
              width: 200,
              height: 400,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cameraSubFeatureList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: CameraListItem(
                          icon: state.cameraSubFeatureList[index].icon,
                          title: state.cameraSubFeatureList[index].title,
                        ),
                        onTap: () {
                          getIt<AppRouter>().push(const ArtboardRoute());
                        });
                  })),
          fallbackWidget: const Center()),
      bottom: 10,
      right: 10,
    );
  }

  Widget _captureButton(CameraController controller) {
    return Positioned(
      bottom: 10,
      child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Center(),
                  ConditionalRenderDelegate(
                      condition:
                          selectedFeatures.contains(CameraFeatureMode.filter),
                      renderWidget: const Center(),
                      fallbackWidget: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 500),
                        firstCurve: Curves.easeInOut,
                        secondCurve: Curves.easeInOut,
                        sizeCurve: Curves.easeInOut,
                        firstChild: _recordingAnimation(),
                        secondChild: _captureVector(controller),
                        crossFadeState: isRecording
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      )),
                  const Center()
                ]),
            margin: const EdgeInsets.fromLTRB(1, 5, 1, 40),
          )),
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _captureVector(CameraController controller) {
    return GestureDetector(
      child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.4)),
          child: SvgPicture.asset(
            Constants.recordingIcon,
            height: 70,
            width: 70,
          )),
      onTap: () {
        _takePicture(controller);
      },
      onTapDown: (TapDownDetails details) {
        _startVideoRecording(controller);
      },
      onTapUp: (TapUpDetails details) {
        _stopVideoRecording(controller);
      },
    );
  }

  Widget _recordingAnimation() {
    return SizedBox(
        height: 150.0,
        width: 150.0,
        child: FlareActor(Constants.recordingAnimation,
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "record"));
  }

  Widget _recordingDuration() {
    return Positioned(
        top: 100,
        width: MediaQuery.of(context).size.width,
        child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 500),
            firstCurve: Curves.easeInOut,
            secondCurve: Curves.easeInOut,
            sizeCurve: Curves.easeInOut,
            firstChild: Center(
                child: Align(
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width * .70,
                      child: LinearProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.amber[600]!),
                          value: progress))),
            )),
            secondChild: const Center(),
            crossFadeState: isRecording
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond));
  }

  Widget _cameraOptions(CameraController controller) {
    return Positioned(
        bottom: 15,
        child: SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _galleryPreviewDisplay(),
                    _changeLensButton(controller)
                  ],
                )))); //;
  }

  Widget _galleryPreviewDisplay() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: GestureDetector(
            onTap: () {
              _openGallery();
            },
            child: ClipRRect(
              child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ConditionalRenderDelegate(
                      condition: _thumbnailType == AssetType.image,
                      renderWidget: FutureBuilder<File?>(
                          future: _isThumbnailInitialzed
                              ? _initializeImageThumbnailFuture
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == null) {
                                return const Center();
                              } else {
                                return Image.file(snapshot.data as File);
                              }
                            } else if (snapshot.hasError) {
                              return const Center(); // error
                            } else {
                              return const Center(); // loading
                            }
                          }),
                      fallbackWidget: FutureBuilder<Uint8List?>(
                          future: _isThumbnailInitialzed
                              ? _initializeVideoThumbnailFuture
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == null) {
                                return const Center();
                              } else {
                                return Image.memory(snapshot.data as Uint8List);
                              }
                            } else if (snapshot.hasError) {
                              return const Center(); // error
                            } else {
                              return const Center(); // loading
                            }
                          }))),
              borderRadius: BorderRadius.circular(15),
            )));
  }

  Widget _changeLensButton(CameraController controller) {
    return Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .75),
        child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                iconSize: 30,
                icon: const Icon(CupertinoIcons.camera_rotate),
                onPressed: () {
                  if (controller.description.lensDirection ==
                      CameraLensDirection.front) {
                    _cameraBloc.add(const CameraEvent.changeLens(
                        direction: CameraLensDirection.back));
                  } else if (controller.description.lensDirection ==
                      CameraLensDirection.back) {
                    _cameraBloc.add(const CameraEvent.changeLens(
                        direction: CameraLensDirection.front));
                  }
                })));
  }

  Widget _cameraWidget(CameraState state) {
    return SizedBox(
        //margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 50,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: AspectRatio(
                aspectRatio: 1,
                child: CameraPreview(state.controller
                    as CameraController) /*ConditionalRenderDelegate(
                    condition:
                        selectedFeatures.contains(CameraFeatureMode.filter),
                    renderWidget: DeepArCamera(
                        controller:
                            state.deepArController as CameraDeepArController),
                    fallbackWidget:
                        CameraPreview(state.controller as CameraController))))*/
                )));
  }

  Widget _headerWidget(CameraController controller) {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    iconSize: 25,
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                      icon: const Icon(Icons.more_horiz),
                      iconSize: 30,
                      // ignore: avoid_returning_null_for_void
                      onPressed: () => null),
                ])));
  }
}
