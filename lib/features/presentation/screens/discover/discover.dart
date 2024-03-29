import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frienderr/core/services/helpers.dart';
import 'package:frienderr/core/services/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:frienderr/core/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frienderr/features/domain/entities/bloc_group.dart';
import 'package:frienderr/features/data/models/user/user_model.dart';
import 'package:frienderr/features/presentation/widgets/loading.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:frienderr/features/presentation/blocs/user/user_bloc.dart';
import 'package:frienderr/features/presentation/blocs/theme/theme_bloc.dart';
import 'package:frienderr/features/presentation/widgets/conditional_render_delegate.dart';
import 'package:frienderr/features/presentation/screens/account/profile/profile_account.dart';

class DiscoverScreen extends StatefulWidget {
  final BlocGroup blocGroup;
  const DiscoverScreen({Key? key, required this.blocGroup}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with AutomaticKeepAliveClientMixin<DiscoverScreen> {
  //late Marker marker;
  bool showMap = true;
  bool _lights = false;
  int currentIndex = 0;
  dynamic searched = [];
  bool isSearching = false;
  bool areUsersLoaded = false;
  late final UserModel user;
  //Location location = Location();
  List<dynamic> globalMapUsers = [];
  final FocusNode _focus = FocusNode();
  //late LocationData _currentPosition;
  //late GoogleMapController _mapController;
  // final LatLng _initialcameraposition = const LatLng(0.5937, 0.9629);
  final TextEditingController searchController = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  //ate StreamSubscription<LocationData> locationSubscription;
  /*static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/

  @override
  void initState() {
    //_askPermissions();
    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    // _mapController.dispose();
    searchController.dispose();
    // locationSubscription.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void toggleMapVisibility() {
    setState(() {
      showMap = !showMap;
    });
  }

  /* void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _loadMapStyles();
    // locationSubscription = location.onLocationChanged.listen((l) {
    //  animateToPosition(l.latitude ?? 0, l.longitude ?? 0);
    //});
  }*/

  Future<void> animateToPosition(double latitude, double longitude) async {
    /* mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
      ),
    );*/
  }

  void _askPermissions() async {
    Map<permission.Permission, permission.PermissionStatus> statuses = await [
      permission.Permission.location,
    ].request();
  }

  Future _loadMapStyles() async {
    final theme = context.read<ThemeBloc>().state.theme;

    if (theme == Constants.darkTheme) {
      final _darkMapStyle =
          await rootBundle.loadString('assets/map_styles/dark.json');

      //  _mapController.setMapStyle(_darkMapStyle);
    } else {
      final _lightMapStyle =
          await rootBundle.loadString('assets/map_styles/light.json');

      //_mapController.setMapStyle(_lightMapStyle);
    }
  }

  Future<void> _fetchUsers(String term) async {
    setState(() {
      isSearching = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final searchedUsers = await users
        .where('username', isGreaterThanOrEqualTo: term)
        .where('username',
            isNotEqualTo: widget.blocGroup.userBloc.state.user.username)
        .get();

    setState(() {
      isSearching = false;
      searched = searchedUsers.docs;
    });
  }

  /*Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    // print('CURRENT $_currentPosition');

    _initialcameraposition = LatLng(
        _currentPosition.latitude ?? 0.0, _currentPosition.longitude ?? 0.0);
    animateToPosition(
        _currentPosition.latitude ?? 0.0, _currentPosition.longitude ?? 0.0);
    location.onLocationChanged.listen((LocationData currentLocation) {
      //   print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition.latitude ?? 0.0,
            _currentPosition.longitude ?? 0.0);

        DateTime now = DateTime.now();
        //   _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        /*_getAddress(_currentPosition.latitude ?? 0.0,
                _currentPosition.longitude ?? 0.0)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });*/
      });
    });
    /* final UserModel user =
        BlocProvider.of<UserBloc>(context, listen: false).state.user;
   / await appUserToMarkers(user);
    //await appUsersToMarkers(user);*/
  }*/

  Future<void> _showMapActionSheet() async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Stack(children: [
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                heightFactor: 0.98,
                widthFactor: 2.5,
                child: Stack(children: [
                  //  mapWidget(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: areUsersLoaded
                          ? mapUserList()
                          : const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: CircularProgressIndicator())),
                ]),
              ),
            ),
          ),
        ]);
      },
    );
  }

  Future<void> showSettingsActionSheet() async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: MediaQuery.of(context).size.height - 150,
              child: SwitchListTile(
                title: const Text('Enable Location'),
                value: _lights,
                onChanged: (bool value) {
                  toggleLocationStatus(value, setState);
                },
                secondary: const Icon(Icons.location_on),
              ));
        });
      },
    );
  }

  Future<QuerySnapshot<Object?>> fetchMapUsers() async {
    return await users.where('isLocationEnabled', isEqualTo: true).get();
  }

  void toggleLocationStatus(bool value, Function setState) {
    final UserModel user =
        BlocProvider.of<UserBloc>(context, listen: false).state.user;
    users.doc(user.id).update({
      'isLocationEnabled': value,
      'location': {
        //'latitude': _initialcameraposition.latitude,
        //  'longitude': _initialcameraposition.longitude
      }
    });
    setState(() {
      _lights = value;
    });
  }

  /* Future<List<Address>> getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }*/

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            // floatingActionButton: _mapButton(),
            body: Container(
              margin: const EdgeInsets.only(top: 15),
              height: MediaQuery.of(context).size.height,
              child: Flex(direction: Axis.vertical, children: [
                Row(children: [
                  _backIcon(),
                  _searchBar(),
                  _microPhoneButton(),
                ]),
                ConditionalRenderDelegate(
                    condition: isSearching,
                    renderWidget: Container(
                        margin: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.height * .30)),
                        child: const Center(
                            child: LoadingIndicator(size: Size(40, 40)))),
                    fallbackWidget: searchResults())
              ]),
            )));
  }

  Widget _discoverMap() {
    return ClipRRect(
      child:
          Center() /*GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: false,
        initialCameraPosition: _kGooglePlex,
      )*/
      ,
      borderRadius: BorderRadius.circular(25),
    );
  }

  Widget _searchBar() {
    return Container(
        height: 40,
        width: MediaQuery.of(context).size.width * .75,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.only(top: 0),
        child: TextField(
            focusNode: _focus,
            //autofocus: true,
            obscureText: false,
            controller: searchController,
            //   style: TextStyle(color: Colors.white),
            onChanged: (term) => _fetchUsers(term),
            decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 13.5),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  // borderSide: new BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                suffixIcon: searchController.text != ''
                    ? IconButton(
                        color: Colors.white,
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        color: Colors.grey,
                        onPressed: () {},
                        icon: const Icon(Icons.search)),
                // fillColor: HexColor('#C4C4C4').withOpacity(0.5),
                filled: true,
                //fillColor: Colors.white,
                labelText: 'Search',
                contentPadding: const EdgeInsets.only(
                  top: 30.0,
                  left: 20.0,
                ))));
  }

  Widget _microPhoneButton() {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
                iconSize: 25,
                icon: const Icon(Icons.mic, color: Colors.grey),
                onPressed: () => Navigator.pop(context))));
  }

  Widget _backIcon() {
    return IconButton(
        iconSize: 25,
        color: Colors.grey,
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back));
  }

  Widget _mapButton() {
    return ConditionalRenderDelegate(
        condition: false,
        renderWidget: Container(
            margin: const EdgeInsets.only(bottom: 15, right: 15),
            child: SizedBox(
                height: 45.0,
                width: 45.0,
                child: FittedBox(
                    child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: HexColor('#EE6115'),
                        child: const Icon(CupertinoIcons.location,
                            color: Colors.white),
                        onPressed: () => _showMapActionSheet())))),
        fallbackWidget: const Center());
  }

  Widget mapUserList() {
    return SizedBox(
        height: 160,
        child: PageView.builder(
            itemCount: globalMapUsers.length,
            onPageChanged: (i) {
              final latitude = globalMapUsers[i]['location']['latitude'];
              final longitutde = globalMapUsers[i]['location']['longitude'];
              animateToPosition(latitude, longitutde);
            },
            itemBuilder: (BuildContext context, int itemIndex) {
              final maxWidth = MediaQuery.of(context).size.width;

              final username = globalMapUsers[itemIndex]['username'];

              final latitude =
                  globalMapUsers[itemIndex]['location']['latitude'];
              final longitutde =
                  globalMapUsers[itemIndex]['location']['longitude'];
              final bitmapImage = globalMapUsers[itemIndex]['bitmapImage'];
              /*final distance = (Geolocator.distanceBetween(
                        latitude,
                        longitutde,
                    //    _initialcameraposition.latitude,
                      //  _initialcameraposition.longitude,
                      ) /
                      1000)
               //   .toStringAsFixed(0);*/

              return Container(
                  width: maxWidth - 20,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).canvasColor),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            CachedNetworkImageProvider(bitmapImage),
                      ),
                      title: Text(username),
                      subtitle: Text('km'),
                      trailing: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.transparent),
                          child: IconButton(
                              icon: const Icon(
                                Icons.messenger_outline,
                                color: Colors.grey,
                              ),
                              onPressed: () => null))));
            }));
  }

  Widget headerWidget() {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [settingsButton(), searchButton()]));
  }

  Widget searchButton() {
    return GestureDetector(
        // onTap: () => showSearchActionSheet(),
        child: Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
      child: const Icon(
        Icons.search,
        color: Colors.white,
        size: 23,
      ),
    ));
  }

  Widget settingsButton() {
    return GestureDetector(
        onTap: () => showSettingsActionSheet(),
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
          child: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 23,
          ),
        ));
  }

  Widget searchResults() {
    if (searched.length == 0 && searchController.text != '') {
      return Container(
          margin: const EdgeInsets.only(top: 250),
          child: Center(
              child: Column(children: [
            Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/search_icon.png',
                    height: 200, width: 200)),
            Text(
              'No results',
              style: TextStyle(
                fontSize:
                    const AdaptiveTextSize().getAdaptiveTextSize(context, 10),
              ),
            )
          ])));
    }

    if (searched.length == 0) {
      return Container(
          margin: const EdgeInsets.only(top: 250),
          child: Center(
              child: Column(children: [
            Opacity(
                opacity: 0.35,
                child: Image.asset('assets/images/search_icon.png',
                    height: 250, width: 250, scale: 0.7)),
          ])));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: searched.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // Style the cards with the to-be-selected theme colors
          color: Theme.of(context).canvasColor,
          child: ListTile(
            leading: CircleAvatar(
                radius: 20,
                backgroundImage:
                    CachedNetworkImageProvider(searched[index]['profilePic'])),
            title: Text('${searched[index]['username']}',
                style: TextStyle(
                  fontSize:
                      const AdaptiveTextSize().getAdaptiveTextSize(context, 10),
                )
                // To show light text with the dark variants...
                ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileAccountScreen(
                            blocGroup: widget.blocGroup,
                            isProfileOwnerViewing: false,
                            profileUserId: searched[index]['id'],
                          )));
            },
          ),
        );
      },
    );
  }
}
