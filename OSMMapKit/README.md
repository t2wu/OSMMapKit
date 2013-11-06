#OSMMapKit

OSMMapKit (MapKit for [OpenStreetMap]) is a tiny set of classes (just with a big name, lol) which takes tiles formatted in [MBTiles] SQLite3 database from MapBox and display it on iOS 7 MapKit. In other words, it presents offline map within a pre-defined region on iOS devices.

##Usage

###With MBTiles
~~~
NSURL *tilesURL = [[NSBundle mainBundle] URLForResource:@"SanFrancisco" withExtension:@"mbtiles"];

MBTilesDB *tilesDB = [[MBTilesDB alloc] initWithDBURL:tilesURL];

self.mapView = [[OSMMapView alloc] initWithFrame:self.view.bounds andMBTiles:tilesDB];

[self.view addSubview:self.mapView];
~~~

###Without MBTiles
When used without MBTiles, iOS 7 MapKit already provides the necessary MKTileOverlay to for external map such as Stamen's. The kit only provides additional facilities such as zoom level and map constraint.

##Installation
Drag the project into your directory. In your Build Phases add **libOSMMapKit.a** to "Link binary with libraries".

## Required external dependnecy
[FMDB][FMDB] and Apple's own MapKit

##How to obtain the data source
OpenStreetMap is a mapping project collecting geographical data from collaborators worldwide (For more information, please refer to [OpenStreetMap Wiki]). The data are available as XML files from OpenStreetMap ([OSM data download]). 

To make [MBTiles], a SQLite3 database with a specific schema storing the tile images which OSMMapKit uses, import the data into [PostGis] with either [osm2pqsql] or [Imposm]. The desktop tile-making tool [TileMill] from MapBox can then generate the map tile images from the PostGis database according to [Carto] stylesheet (for starter, try [OSM Bright]) and package them into [MBTiles].

Tutorial is available from MapBox. ([OSM Bright Mac OS X quickstart])

##Known problem (to be fixed)
Tiles around overlay seems to disappear when zoom-in.

##License

###MIT

Code heavily influenced by sources from [MapBox iOS SDK] and [MBXMapKit], as well as various sources, notably [the discussion thread on ZoomLevel] from Troy Brant and input on [constraining the map region] from Anna Karenina.


##Disclaimer
The project is not in any way associated with MapBox.



[OpenStreetMap]: http://www.openstreetmap.org/
[OpenStreetMap Wiki]: http://wiki.openstreetmap.org/wiki/Main_Page
[OSM data download]: http://wiki.openstreetmap.org/wiki/Downloading_data
[PostGis]: http://postgis.net/
[TileMill]: https://www.mapbox.com/tilemill/
[osm2pqsql]: http://wiki.openstreetmap.org/wiki/Osm2pgsql
[Imposm]: http://imposm.org/
[Carto]: http://wiki.openstreetmap.org/wiki/Carto
[OSM Bright]: https://github.com/mapbox/osm-bright
[OSM Bright Mac OS X quickstart]: https://www.mapbox.com/tilemill/docs/guides/osm-bright-mac-quickstart/
[MBTiles]: https://www.mapbox.com/developers/mbtiles/
[FMDB]: https://github.com/ccgus/fmdb
[the discussion thread on ZoomLevel]: http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/
[MapBox iOS SDK]: https://www.mapbox.com/mapbox-ios-sdk/
[MBXMapKit]: https://www.mapbox.com/mbxmapkit/
[constraining the map region]: http://stackoverflow.com/questions/4119117/restrict-mkmapview-scrolling
