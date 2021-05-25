include karax / prelude, tables


var data:seq[tuple[name:string, country:string, age:int]] = @[("jose", "spa", 45), #{"name":"jose", "cty":"spa", "age":44,
              ("john", "eng", 42) #{"name":"john", "cty":"eng", "age":44}.toTable,
             ]

proc createDom(): VNode =
  result = buildHtml(tdiv):
    h1(text "Hello Karax", class="title")
    

    #p(class="subtitle"):
    #  text "This is a paragraph."
    #a(class="button is-primary"):
    #  text "Button"

    table(class="table"):
      thead:
        th:
          text "Name"
        th:
          text "Country"
        th:
          text "Age"

      tbody:
        for (name, country, age) in data:
          tr:
            td:
              text name

            td:
              text country

            td:
              text $age




    
setRenderer createDom

#[
<table class="table">
  <thead>
    <tr>
      <th><abbr title="Position">Pos</abbr></th>
      <th>Team</th>
      <th><abbr title="Played">Pld</abbr></th>
      <th><abbr title="Won">W</abbr></th>
      <th><abbr title="Drawn">D</abbr></th>
      <th><abbr title="Lost">L</abbr></th>
      <th><abbr title="Goals for">GF</abbr></th>
      <th><abbr title="Goals against">GA</abbr></th>
      <th><abbr title="Goal difference">GD</abbr></th>
      <th><abbr title="Points">Pts</abbr></th>
      <th>Qualification or relegation</th>    
]#