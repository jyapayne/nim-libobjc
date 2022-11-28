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
  ## Returns the name of the method specified by a given selector.
  ##
  ## @param sel A pointer of type \c SEL. Pass the selector whose name you wish to determine.
  ##
  ## @return A C string indicating the name of the selector.

proc selRegisterName*(str: cstring): Sel {.cdecl, importc: "sel_registerName",
                                       dynlib: libobjc.}
  ## Registers a method with the Objective-C runtime system, maps the method
  ## name to a selector, and returns the selector value.
  ##
  ## @param str A pointer to a C string. Pass the name of the method you wish to register.
  ##
  ## @return A pointer of type SEL specifying the selector for the named method.
  ##
  ## @note You must register a method name with the Objective-C runtime system to obtain the
  ##  method’s selector before you can add the method to a class definition. If the method name
  ##  has already been registered, this function simply returns the selector.

proc objectGetClassName*(obj: Id): cstring {.cdecl, importc: "object_getClassName",
    dynlib: libobjc.}
  ## Returns the class name of a given object.
  ##
  ## @param obj An Objective-C object.
  ##
  ## @return The name of the class of which \e obj is an instance.

proc objectGetIndexedIvars*(obj: Id): pointer {.cdecl,
    importc: "object_getIndexedIvars", dynlib: libobjc.}
  ## Returns a pointer to any extra bytes allocated with an instance given object.
  ##
  ## @param obj An Objective-C object.
  ##
  ## @return A pointer to any extra bytes allocated with \e obj. If \e obj was
  ##   not allocated with any extra bytes, then dereferencing the returned pointer is undefined.
  ##
  ## @note This function returns a pointer to any extra bytes allocated with the instance
  ##  (as specified by \c class_createInstance with extraBytes>0). This memory follows the
  ##  object's ordinary ivars, but may not be adjacent to the last ivar.
  ## @note The returned pointer is guaranteed to be pointer-size aligned, even if the area following
  ##  the object's last ivar is less aligned than that. Alignment greater than pointer-size is never
  ##  guaranteed, even if the area following the object's last ivar is more aligned than that.
  ## @note In a garbage-collected environment, the memory is scanned conservatively.

proc selIsMapped*(sel: Sel): Bool {.cdecl, importc: "sel_isMapped", dynlib: libobjc.}
  ## Identifies a selector as being valid or invalid.
  ##
  ## @param sel The selector you want to identify.
  ##
  ## @return YES if selector is valid and has a function implementation, NO otherwise.
  ##
  ## @warning On some platforms, an invalid reference (to invalid memory addresses) can cause
  ##  a crash.

proc selGetUid*(str: cstring): Sel {.cdecl, importc: "sel_getUid", dynlib: libobjc.}
  ## Registers a method name with the Objective-C runtime system.
  ##
  ## @param str A pointer to a C string. Pass the name of the method you wish to register.
  ##
  ## @return A pointer of type SEL specifying the selector for the named method.
  ##
  ## @note The implementation of this method is identical to the implementation of \c sel_registerName.
  ## @note Prior to OS X version 10.0, this method tried to find the selector mapped to the given name
  ##  and returned \c NULL if the selector was not found. This was changed for safety, because it was
  ##  observed that many of the callers of this function did not check the return value for \c NULL.


## OBSOLETE ###############################
type
  ObjcObjectPtrT* = distinct pointer

proc objcRetainedObject*(obj: ObjcObjectPtrT): Id {.cdecl,
    importc: "objc_retainedObject", dynlib: libobjc.}
proc objcUnRetainedObject*(obj: ObjcObjectPtrT): Id {.cdecl,
    importc: "objc_unretainedObject", dynlib: libobjc.}
proc objcUnRetainedPointer*(obj: Id): ObjcObjectPtrT {.cdecl,
    importc: "objc_unretainedPointer", dynlib: libobjc.}
###########################################

## The following declarations are provided here for source compatibility.

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
