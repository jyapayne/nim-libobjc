const libobjc* = "libobjc.dylib"

type
  Class* = distinct pointer
  ObjcObject* {.bycopy.} = object
    isa*: Class
  Id* = ptr ObjcObject
  Sel* = distinct pointer
  Imp* = proc (a1: Id; a2: Sel): Id {.cdecl, varargs.}
  Bool* = bool

const
  OBJC_BOOL_IS_BOOL* = 1
  Nil* = nil
  `nil`* = nil
  strong* = true
  unsafeUnretained* = true
  autoreleasing* = true

proc selGetName*(sel: Sel): cstring {.cdecl, importc: "sel_getName", dynlib: libobjc.}

proc selRegisterName*(str: cstring): Sel {.cdecl, importc: "sel_registerName",
                                       dynlib: libobjc.}

proc objectGetClassName*(obj: Id): cstring {.cdecl, importc: "object_getClassName",
    dynlib: libobjc.}

proc objectGetIndexedIvars*(obj: Id): pointer {.cdecl,
    importc: "object_getIndexedIvars", dynlib: libobjc.}

proc selIsMapped*(sel: Sel): Bool {.cdecl, importc: "sel_isMapped", dynlib: libobjc.}

proc selGetUid*(str: cstring): Sel {.cdecl, importc: "sel_getUid", dynlib: libobjc.}

type
  ObjcObjectPtrT* = distinct pointer


proc objcRetainedObject*(obj: ObjcObjectPtrT): Id {.cdecl,
    importc: "objc_retainedObject", dynlib: libobjc.}
proc objcUnRetainedObject*(obj: ObjcObjectPtrT): Id {.cdecl,
    importc: "objc_unretainedObject", dynlib: libobjc.}
proc objcUnRetainedPointer*(obj: Id): ObjcObjectPtrT {.cdecl,
    importc: "objc_unretainedPointer", dynlib: libobjc.}

type
  ArithT* = clong
  UarithT* = culong

const
  ARITH_SHIFT* = 32

type
  Str* = cstring

template isselector*(sel: untyped): untyped =
  selIsMapped(sel)

template selname*(sel: untyped): untyped =
  selGetName(sel)

template seluid*(str: untyped): untyped =
  selGetUid(str)

template nameof*(obj: untyped): untyped =
  objectGetClassName(obj)

template iv*(obj: untyped): untyped =
  objectGetIndexedIvars(obj)
