include karax / prelude, tables, jsffi,tabulator#, tables  # json, 





#[
var tabledata = @[
   js{ id:1, name:"Oli Bob".cstring, age:"12".cstring, col:"red".cstring, dob:"".cstring },
   js{ id:2, name:"Mary May".cstring, age:"1".cstring, col:"blue".cstring, dob:"14/05/1982".cstring },
   js{ id:3, name:"Christine Lobowski".cstring, age:"42".cstring, col:"green".cstring, dob:"22/05/1982".cstring },
   js{ id:4, name:"Brendon Philips".cstring, age:"125".cstring, col:"orange".cstring, dob:"01/08/1980".cstring },
   js{ id:5, name:"Margret Marmajuke".cstring, age:"16".cstring, col:"yellow".cstring, dob:"31/01/1999".cstring },
 ]
]#
var columns = @[ 
      js{ title:"Name".cstring, field:"name".cstring, sorter:"string".cstring, width:150 },
      js{ title:"Age".cstring, field:"age".cstring, sorter:"number".cstring, hozAlign:"left".cstring, formatter:"progress".cstring },
      js{ title:"Favourite Color".cstring, field:"col".cstring, sorter:"string".cstring, sortable:false },
      js{ title:"Date Of Birth".cstring, field:"dob".cstring, sorter:"date".cstring, hozAlign:"center".cstring },
    ]

#var opts     = newJsObject()
var opts = newOptions()
opts.setHeight( 200 )   # opts.height  = 205
opts.setLayout( lFitColumns)  # opts.layout  = "fitColumns".cstring
opts.columns = columns
opts.setMovableColumns()

var table = tabulator("#example-table", opts )

proc createDom(): VNode =
  result = buildHtml(tdiv):
    h1(text "Tabulator Example", class="title")
    button(class="button is-primary"):
      text "Load file..."
      proc onclick(ev: Event; n: VNode) =
        table.setDataFromLocalFile("*.json")
        #lines.add "Hello simulated universe"

setRenderer createDom
