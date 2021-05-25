import jsffi

when not defined(js):
  {.error: "This module only works on the JavaScript platform".}

type
  Tabulator* = JsObject#ref object

proc tabulator*(element:cstring, options:JsObject): Tabulator {. importcpp: "new Tabulator(@)" .}

proc setData*(this:Tabulator, a:openArray[JsObject]):Tabulator {.importcpp:"#.setData(@)", discardable.}



# Columns definitions
type
  HorizontalAlignment* = enum
    haLeft, haCenter, haRight
  VerticalAlignment* = enum
    vaTop, vaMiddle, vaBottom

  
proc genColumn*(title:string, field:string, visible:bool = true):JsObject =
  var col = newJsObject()
  col.title   = title.cstring
  col.field   = field.cstring
  #col.visible = visible


#[
type
  Crossfilter* = ref object

proc crossfilter*(a:openArray[JsObject]): Crossfilter {.importc:"crossfilter".}

proc groupAll*(this:Crossfilter):Crossfilter {.importcpp.}

proc group*(this:Crossfilter):Crossfilter {.importcpp.}

proc reduceCount*(this:Crossfilter):Crossfilter {.importcpp.}



proc value*(this:Crossfilter):int {.importcpp.}

proc all*(this:Crossfilter):JsObject {.importcpp.}

#---
proc dimension*(this:Crossfilter,a: proc(b:JsObject):JsObject ):Crossfilter {.importcpp.}

proc reduceSum*(this:Crossfilter, a: proc(b:JsObject):JsObject ):Crossfilter {.importcpp.}
]#