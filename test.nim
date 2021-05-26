import macros

#let t = (name:"hola", edad:55)

macro iterateFields*(t: typed): untyped =
  echo "--------------------------------"

  # check type of t
  var tTypeImpl = t.getTypeImpl
  echo tTypeImpl.len       # Number of fields
  echo tTypeImpl.kind      # nnkObjectTy
  echo tTypeImpl.typeKind  # ntyObject
  echo tTypeImpl.treeRepr  #
  #[
ObjectTy
  Empty
  Empty
  RecList
    IdentDefs
      Sym "x"
      Sym "int"
      Empty
    IdentDefs
      Sym "y"
      Sym "int"
      Empty
    IdentDefs
      Sym "name"
      Sym "string"
      Empty      
  ]# 

  case tTypeImpl.typeKind:
  of ntyTuple:
    # For a tuple the IdentDefs are top level, no need to descent
    discard
  of ntyObject:
    # For an object we have to descent to the nnkRecList
    tTypeImpl = tTypeImpl[2]
  else:
    error "Not a tuple or object"

  # iterate over fields
  for child in tTypeImpl.children:
    if child.kind == nnkIdentDefs:
      let field = child[0] # first child of IdentDef is a Sym corresponding to field name
      let ftype = child[1] # second child is type
      echo "Iterating field: " & $field & " -> " & $ftype
    else:
      echo "Unexpected kind: " & child.kind.repr
      # Note that this can happen for an object with a case
      # fields, which would give a child of type nnkRecCase.
      # How to handle them depends on the use case.


macro iterateSeq*(elems: typed): untyped =
  var tmp = elems.getTypeImpl
  #echo tmp[0].getTypeImpl  
  for elem in tmp[1]:
    var t = elem.getTypeImpl  
    echo "--> ", t.treeRepr

  for elem in tmp.children:
    var t = elem.getTypeImpl  
    echo "==> ", t.treeRepr    

  for idx, elem in tmp[1].children:
    var t = elem.getTypeImpl  
    echo ">>> ", idx
    echo t.treeRepr 
  echo "---"
  #echo elems.len
  #for i in 0..<elems.len:
  #  echo i
  #  echo elems[i].treeRepr

  #[
  echo "==="
  var tTypeImpl = elems.getTypeImpl  
  echo tTypeImpl.treeRepr
  echo "------"
  echo tTypeImpl.len       # Number of fields
  echo tTypeImpl.kind      
  echo tTypeImpl.typeKind  # ntySequence
 
  echo "---"
  # check type of t
  #for t in elems:
  #var tTypeImpl = elems.getTypeImpl
  for child in tTypeImpl[1].children:
    echo "..."
    echo child.len       # Number of fields
    echo child.kind      
    echo child.typeKind  
    echo child.treeRepr  
  ]#


# small test
type
  TestObj = object
    x: int
    y: int
    name: string

let t = (x: 0, y: 1, name: "")
let o = TestObj(x: 0, y: 1, name: "")

#iterateFields(t)
#iterateFields(o)   
let elems = @[ ( x: 111, y: 222, name: "aa" ), 
               ( x: 2,   y: 5,   name: "kak" ), 
               ( x: 8,   y: 1,   name: "oo" ), 
               ( x: 11,  y: 8,   name: "jose" ) ]

iterateSeq(elems)
#echo "==="
#[
dumpTree:
  @[ (x: 0, y: 1, name: ""), 
               (x: 0, y: 1, name: ""), 
               (x: 0, y: 1, name: ""), 
               (x: 11, y: 8, name: "jose") ]
]#

#[
--------------------------------
3
nnkTupleTy
ntyTuple
TupleTy
  IdentDefs
    Sym "x"
    Sym "int"
    Empty
  IdentDefs
    Sym "y"
    Sym "int"
    Empty
  IdentDefs
    Sym "name"
    Sym "string"
    Empty
Iterating field: x -> int
Iterating field: y -> int
Iterating field: name -> string
--------------------------------
3
nnkObjectTy
ntyObject
ObjectTy
  Empty
  Empty
  RecList
    IdentDefs
      Sym "x"
      Sym "int"
      Empty
    IdentDefs
      Sym "y"
      Sym "int"
      Empty
    IdentDefs
      Sym "name"
      Sym "string"
      Empty
Iterating field: x -> int
Iterating field: y -> int
Iterating field: name -> string    
]#


#[
# Experimentos...

dumpTree:  # Generar y ver el Arbol AST Crudo de Templates y Macros.
  repetir_echo()


expandMacros:     # Generar y ver el codigo generado por el Macro.
  repetir_echo()  # for indice in 0 .. 9: echo(42)  
]#
