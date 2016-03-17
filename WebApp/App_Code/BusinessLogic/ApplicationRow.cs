﻿//  Copyright 2016 Applied Geographics, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Serialization;
using GeoAPI.Geometries;

public partial class Configuration
{
  public partial class ApplicationRow
  {
    private Configuration Configuration
    {
      get
      {
        return (Configuration)Table.DataSet;
      }
    }

    public Envelope GetFullExtentEnvelope()
    {
      return IsFullExtentNull() ? AppContext.AppSettings.DefaultFullExtent : EnvelopeExtensions.FromDelimitedString(FullExtent);
    }

    public PrintTemplateRow[] GetPrintTemplates()
    {
      List<PrintTemplateRow> printTemplates = new List<PrintTemplateRow>();

      foreach (PrintTemplateRow template in Configuration.PrintTemplate)
      {
        bool add = template.IsAlwaysAvailableNull() || template.AlwaysAvailable == 1;

        if (!add)
        {
          add = template.GetApplicationPrintTemplateRows().Any(o => o.ApplicationID == ApplicationID);
        }

        if (add)
        {
          printTemplates.Add(template);
        }
      }

      return printTemplates.ToArray();
    }

    public string ToJson()
    {
      Dictionary<String, Object> mapTabs = new Dictionary<String, Object>();
      List<String> layerIDs = new List<String>();
      List<String> searchIDs = new List<String>();
      List<String> tileGroupIDs = new List<String>();

      foreach (MapTabRow mapTab in GetApplicationMapTabRows().Select(o => o.MapTabRow))
      {
        Dictionary<String, Object> mapTabData = mapTab.ToJsonData();
        layerIDs.AddRange((string[])mapTabData["target"]);
        layerIDs.AddRange((string[])mapTabData["selection"]);
        searchIDs.AddRange((string[])mapTabData["search"]);
        tileGroupIDs.AddRange(((Dictionary<string, object>[])mapTabData["tileGroup"]).Select(o => (string)o["group"]).ToArray());

        mapTabs.Add(mapTab.MapTabID, mapTabData);
      }

      layerIDs = layerIDs.Distinct().ToList();
      Dictionary<String, Object> layers = new Dictionary<String, Object>();
      List<String> proximityIDs = Configuration.Proximity.Where(o => !o.IsIsDefaultNull() && o.IsDefault == 1).Select(o => o.ProximityID).ToList();
      List<String> queryIDs = new List<String>();
      List<String> dataTabIDs = new List<String>();

      foreach (LayerRow layer in Configuration.Layer.Where(o => layerIDs.Contains(o.LayerID)))
      {
        Dictionary<String, Object> layerData = layer.ToJsonData();
        proximityIDs.AddRange((string[])layerData["proximity"]);
        queryIDs.AddRange((string[])layerData["query"]);
        dataTabIDs.AddRange((string[])layerData["dataTab"]);

        layers.Add(layer.LayerID, layerData);
      }

      proximityIDs = proximityIDs.Distinct().ToList();
      Dictionary<String, Object> proximities = new Dictionary<String, Object>();

      foreach (ProximityRow proximity in Configuration.Proximity.Where(o => proximityIDs.Contains(o.ProximityID)))
      {
        proximities.Add(proximity.ProximityID, proximity.ToJsonData());
      }

      queryIDs = queryIDs.Distinct().ToList();
      Dictionary<String, Object> queries = new Dictionary<String, Object>();

      foreach (QueryRow query in Configuration.Query.Where(o => queryIDs.Contains(o.QueryID)))
      {
        queries.Add(query.QueryID, query.ToJsonData());
      }

      dataTabIDs = dataTabIDs.Distinct().ToList();
      Dictionary<String, Object> dataTabs = new Dictionary<String, Object>();

      foreach (DataTabRow dataTab in Configuration.DataTab.Where(o => dataTabIDs.Contains(o.DataTabID)))
      {
        dataTabs.Add(dataTab.DataTabID, dataTab.ToJsonData());
      }

      searchIDs = searchIDs.Distinct().ToList();
      Dictionary<String, Object> searches = new Dictionary<String, Object>();

      foreach (SearchRow search in Configuration.Search.Where(o => searchIDs.Contains(o.SearchID)))
      {
        searches.Add(search.SearchID, search.ToJsonData());
      }

      tileGroupIDs = tileGroupIDs.Distinct().ToList();
      Dictionary<String, Object> tileGroups = new Dictionary<String, Object>();
      List<String> tileLayerIDs = new List<String>();

      foreach (TileGroupRow tileGroup in Configuration.TileGroup.Where(o => tileGroupIDs.Contains(o.TileGroupID)))
      {
        Dictionary<String, Object> tileGroupData = tileGroup.ToJsonData();
        tileLayerIDs.AddRange((string[])tileGroupData["tileLayer"]);

        tileGroups.Add(tileGroup.TileGroupID, tileGroupData);
      }

      tileLayerIDs = tileLayerIDs.Distinct().ToList();
      Dictionary<String, Object> tileLayers = new Dictionary<String, Object>();

      foreach (TileLayerRow tileLayer in Configuration.TileLayer.Where(o => tileLayerIDs.Contains(o.TileLayerID)))
      {
        tileLayers.Add(tileLayer.TileLayerID, tileLayer.ToJsonData());
      }

      Dictionary<String, Object> printTemplates = new Dictionary<String, Object>();

      foreach (PrintTemplateRow template in GetPrintTemplates())
      {
        printTemplates.Add(template.TemplateID, template.ToJsonData());
      }

      Dictionary<String, Object> jsonData = new Dictionary<String, Object>();
      jsonData.Add("fullExtent", GetFullExtentEnvelope().ToArray());
      jsonData.Add("mapTab", mapTabs);
      jsonData.Add("layer", layers);
      jsonData.Add("proximity", proximities);
      jsonData.Add("query", queries);
      jsonData.Add("dataTab", dataTabs);
      jsonData.Add("search", searches);
      jsonData.Add("tileGroup", tileGroups);
      jsonData.Add("tileLayer", tileLayers);
      jsonData.Add("printTemplate", printTemplates);

      JavaScriptSerializer serializer = new JavaScriptSerializer();
      return serializer.Serialize(jsonData);
    }
  }
}