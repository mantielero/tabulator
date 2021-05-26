import jsffi

when not defined(js):
  {.error: "This module only works on the JavaScript platform".}

type
  Tabulator* = JsObject#ref object
  Options*   = JsObject
  Column*    = JsObject

proc tabulator*(element:cstring, options:JsObject): Tabulator {. importcpp: "new Tabulator(@)" .}

proc setData*(this:Tabulator, a:openArray[JsObject]):Tabulator {.importcpp:"#.setData(@)", discardable.}

proc setData*(this:Tabulator, a:JsObject):Tabulator {.importcpp:"#.setData(@)", discardable.}


# Columns definitions
type
  HorizontalAlignment* = enum
    haLeft, haCenter, haRight
  VerticalAlignment* = enum
    vaTop, vaMiddle, vaBottom

  
proc genColumn*(title:string, field:string, visible:bool = true):Column =
  result = newJsObject()
  result.title   = title.cstring
  result.field   = field.cstring
  #result.visible = visible


# Options
type
  Layout = enum
    ## Columns Layout Modes: You can choose how your table should layout its columns by setting the layout mode
    lFitData, lFitDataAndFill, lFitDataStretch, lFitDataTable, lFitColumns

proc newOptions*():Options =
  newJsObject()#.Options

proc setMovableColumns*(opts:var Options) =
  opts.movableColumns = true

# General Table Configuration
# http://tabulator.info/docs/4.9/options#table
proc setHeight*(opts:var Options, height:int) =
  opts.height = height


# Columns
# http://tabulator.info/docs/4.9/options#columns
proc setLayout*(opts:var Options, layout:Layout) =
  opts.layout = case layout:
                of lFitData: "fitData".cstring
                of lFitDataAndFill: "fitDataAndFill".cstring                
                of lFitDataStretch: "fitDataStretch".cstring
                of lFitDataTable: "fitDataTable".cstring
                of lFitColumns: "fitColumns".cstring

proc setMovableColumns*(opts:var Options, movable:bool) =
  opts.movableColumns = movable


