/*
  Copyright 2016 Applied Geographics, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  GPV50_SQLServer_Create.sql

  Creates the GPV v5.0 configuration tables.  You can set the prefix for the table names by changing 
  the value in the "set @prefix" line below.  Make sure to run the follow scripts after this
  one using the same prefix:

    GPV50_SQLServer_AddConstraints.sql - to create the necessary constraints
    GPV50_SQLServer_LoadMailingLabels.sql - to load the mailing labels table

*/

declare @prefix nvarchar(50)
set @prefix = 'GPV50'

declare @sql nvarchar(2000)


set @sql = 'CREATE TABLE ' + @prefix + 'Application (
  ApplicationID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  AuthorizedRoles nvarchar(200),
  FunctionTabs nvarchar(50),
  DefaultFunctionTab nvarchar(50),
  DefaultMapTab nvarchar(50),
  DefaultSearch nvarchar(50),
  DefaultAction nvarchar(50),
  DefaultTargetLayer nvarchar(50),
  DefaultProximity nvarchar(50),
  DefaultSelectionLayer nvarchar(50),
  DefaultLevel nvarchar(50),
  DefaultTool nvarchar(50),
  FullExtent nvarchar(50),
  OverviewMapID nvarchar(50),
  CoordinateModes nvarchar(50),
  ZoneLevelID nvarchar(50) COLLATE Latin1_General_CS_AS,
  TrackUse smallint,
  MetaDescription nvarchar(200),
  MetaKeywords nvarchar(200),
  About ntext,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'ApplicationMapTab (
  ApplicationID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  MapTabID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  SequenceNo smallint NOT NULL
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'ApplicationMarkupCategory (
  ApplicationID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  CategoryID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  SequenceNo smallint NOT NULL
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'ApplicationPrintTemplate (
  ApplicationID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  TemplateID nvarchar(50) COLLATE Latin1_General_CS_AS  NOT NULL
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Connection (
  ConnectionID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  ConnectionString nvarchar(1000) NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'DataTab (
  DataTabID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  ConnectionID nvarchar(50) COLLATE Latin1_General_CS_AS,
  StoredProc nvarchar(100) NOT NULL,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'ExternalMap (
  DisplayName nvarchar(50) NOT NULL,
  URL nvarchar(400) NOT NULL,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Layer (
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LayerName nvarchar(50) NOT NULL,
  DisplayName nvarchar(50),
  MetaDataURL nvarchar(200),
  KeyField nvarchar(50),
  ZoneField nvarchar(50),
  LevelField nvarchar(50),
  MaxNumberSelected int,
  MaxSelectionArea float,
  MinNearestDistance float,
  MaxNearestDistance float,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'LayerFunction (
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  FunctionName nvarchar(20) NOT NULL,
  ConnectionID nvarchar(50) COLLATE Latin1_General_CS_AS,
  StoredProc nvarchar(100) NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'LayerProximity (
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  ProximityID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Level (
  ZoneLevelID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LevelID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50),
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MailingLabel (
  ID int NOT NULL,
  Manufacturer nvarchar(50) NOT NULL,
  ModelNo nvarchar(100) NOT NULL,
  LabelSize nvarchar(100) NOT NULL,
  IsAvailable smallint NOT NULL,
  LabelsAcross smallint NOT NULL,
  dxLabel real NOT NULL,
  dyLabel real NOT NULL,
  dxSpace real NOT NULL,
  dySpace real NOT NULL,
  xLeft real NOT NULL,
  xRight real NOT NULL,
  yTop real NOT NULL,
  xOrg real NOT NULL,
  yOrg real NOT NULL,
  IsDotMatrix smallint NOT NULL,
  IsPortrait smallint NOT NULL,
  IsMetric smallint NOT NULL 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MapTab (
  MapTabID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  MapHost nvarchar(50) NOT NULL,
  MapService nvarchar(50) NOT NULL,
  DataFrame nvarchar(50),
  UserName nvarchar(50),
  Password nvarchar(50),
  InteractiveLegend smallint,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MapTabLayer (
  MapTabID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  AllowTarget smallint,
  AllowSelection smallint,
  ShowInLegend smallint,
  CheckInLegend smallint,
  IsExclusive smallint,
  ShowInPrintLegend smallint
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MapTabTileGroup (
  MapTabID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  TileGroupID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  CheckInLegend smallint,
  Opacity float DEFAULT 1,
  SequenceNo smallint NOT NULL
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Markup (
  MarkupID int NOT NULL,
  GroupID int NOT NULL,
  Shape ntext NOT NULL,
  Color nvarchar(25) NOT NULL,
  Glow nvarchar(25),
  Text nvarchar(1000),
  Measured smallint,
  DateCreated datetime NOT NULL,
  Deleted smallint NOT NULL 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MarkupCategory (
  CategoryID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  AuthorizedRoles nvarchar(200),
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MarkupGroup (
  GroupID int NOT NULL,
  CategoryID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(100) NOT NULL,
  CreatedBy nvarchar(50) NOT NULL,
  CreatedByUser nvarchar(200),
  Locked smallint NOT NULL,
  DateCreated datetime NOT NULL,
  DateLastAccessed datetime NOT NULL,
  Deleted smallint NOT NULL 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'MarkupSequence (
  NextGroupID int NOT NULL,
  NextMarkupID int NOT NULL 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'PrintTemplate (
  TemplateID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  SequenceNo smallint NOT NULL,
  TemplateTitle nvarchar(50) NOT NULL,
  PageWidth float NOT NULL,
  PageHeight float NOT NULL,
  AlwaysAvailable smallint NULL,
  Active smallint DEFAULT 1 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'PrintTemplateContent (
  TemplateID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  SequenceNo smallint NOT NULL,
  ContentType nvarchar(20) NOT NULL,
  DisplayName nvarchar(50),
  OriginX float NOT NULL,
  OriginY float NOT NULL,
  Width float NOT NULL,
  Height float NOT NULL,
  FillColor nvarchar(25),
  OutlineColor nvarchar(25),
  OutlineWidth int,
  LegendColumnWidth float,
  Text ntext,
  TextAlign nvarchar(6),
  TextWrap int,
  FontFamily nvarchar(16),
  FontSize int,
  FontBold int,
  FileName nvarchar(25),
  Active smallint DEFAULT 1 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Proximity (
  ProximityID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(150) NOT NULL,
  SequenceNo smallint NOT NULL,
  Distance float NOT NULL,
  IsDefault smallint NULL,
  Active smallint DEFAULT 1 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Query (
  QueryID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  ConnectionID nvarchar(50) COLLATE Latin1_General_CS_AS,
  StoredProc nvarchar(100) NOT NULL,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1 
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'SavedState (
  StateID nvarchar(12) NOT NULL,
  DateCreated datetime NOT NULL,
  DateLastAccessed datetime NOT NULL,
  State ntext NOT NULL
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Search (
  SearchID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  ConnectionID nvarchar(50) COLLATE Latin1_General_CS_AS,
  StoredProc nvarchar(100) NOT NULL,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'SearchInputField (
  FieldID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  SearchID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  ColumnName nvarchar(50) NOT NULL,
  FieldType nvarchar(50) NOT NULL,
  ConnectionID nvarchar(50) COLLATE Latin1_General_CS_AS,
  StoredProc nvarchar(100),
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Setting (
  Setting nvarchar(50) NOT NULL,
  Value nvarchar(400),
  Required nvarchar(5) DEFAULT ''no'',
  Note nvarchar(100)
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'TileGroup (
  TileGroupID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'TileLayer (
  TileLayerID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  TileGroupID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  URL nvarchar(400) NOT NULL,
  MaxZoomLevel smallint,
  Attribution nvarchar(400),
  Overlay smallint DEFAULT 1,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'UsageTracking (
  ApplicationID nvarchar(50) NOT NULL,
  UrlQuery nvarchar(1024) NOT NULL,
  DateStarted datetime NOT NULL,
  UserAgent nvarchar(400) NOT NULL,
  UserHostAddress nvarchar(15) NOT NULL,
  UserHostName nvarchar(50) NOT NULL
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'User (
  UserName nvarchar(200) NOT NULL,
  Password nvarchar(40),
  Role nvarchar(25),
  DisplayName nvarchar(50),
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'Zone (
  ZoneLevelID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  ZoneID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  DisplayName nvarchar(50),
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'ZoneLevel (
  ZoneLevelID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  ZoneTypeDisplayName nvarchar(50),
  LevelTypeDisplayName nvarchar(50),
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'CREATE TABLE ' + @prefix + 'ZoneLevelCombo (
  ZoneLevelID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  ZoneID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  LevelID nvarchar(50) COLLATE Latin1_General_CS_AS NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)


/* GPVExternalMap content */

set @sql = 'INSERT into ' + @prefix + 'ExternalMap (DisplayName, URL, SequenceNo, Active) values (''Google Maps'', ''http://www.google.com/maps/@{lat},{lon},{lev}z'', 1, 1)'; exec(@sql)
set @sql = 'INSERT into ' + @prefix + 'ExternalMap (DisplayName, URL, SequenceNo, Active) values (''Bing Maps'', ''http://www.bing.com/maps/?cp={lat}~{lon}&lvl={lev}'', 2, 1)'; exec(@sql)
set @sql = 'INSERT into ' + @prefix + 'ExternalMap (DisplayName, URL, SequenceNo, Active) values (''OpenStreetMap'', ''https://www.openstreetmap.org/#map={lev}/{lat}/{lon}'', 3, 1)'; exec(@sql)


/*  GPVMarkupSequence content */

set @sql = 'INSERT into ' + @prefix + 'MarkupSequence (NextGroupID, NextMarkupID) values (1, 1)'; exec(@sql)


/*  GPVSetting content */

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Required, Note) values (''AdminEmail'', null, ''YES'', ''email address'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''AllowShowApps'', ''no'', ''yes or no'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''DefaultApplication'', null, ''ApplicationID'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Required, Note) values (''FullExtent'', null, ''YES'', ''min X, minY, max X, max Y in MeasureProjection coordinates'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ZoomLevels'', ''19'', ''number > 0'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ShowScaleBar'', ''no'', ''yes or no'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''MapProjection'', null, ''Proj4 string, defaults to Web Mercator'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''MeasureProjection'', null, ''Proj4 string, defaults to MapProjection'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''MeasureUnits'', ''both'', ''feet, meters or both'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ActiveColor'', ''Yellow'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ActiveOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ActivePolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ActivePenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ActiveDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''TargetColor'', ''Orange'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''TargetOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''TargetPolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''TargetPenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''TargetDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SelectionColor'', ''Blue'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SelectionOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SelectionPolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SelectionPenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SelectionDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''FilteredColor'', ''#A0A0A0'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''FilteredOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''FilteredPolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''FilteredPenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''FilteredDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''BufferColor'', ''#A0A0FF'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''BufferOpacity'', ''0.2'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''BufferOutlineColor'', ''#8080DD'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''BufferOutlineOpacity'', ''0'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''BufferOutlinePenWidth'', ''0'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SwatchTileWidth'', ''20'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SwatchTileHeight'', ''20'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''LegendExpanded'', ''yes'', ''yes or no'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''SearchAutoSelect'', ''no'', ''yes or no'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''PreserveOnActionChange'', ''selection'', ''target or selection'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''CustomStyleSheet'', null, ''URL'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ExportFormat'', ''xls'', ''csv (comma-separated value) or xls (Excel)'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''MarkupTimeout'', ''14'', ''days'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''ServerImageCacheTimeout'', ''60'', ''seconds'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix + 'Setting (Setting, Value, Note) values (''BrowserImageCacheTimeout'', ''60'', ''seconds'')'; exec(@sql)
