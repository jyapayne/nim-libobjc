import objc

type
  Method* = distinct pointer
  Ivar* = distinct pointer
  Category* = distinct pointer
  ObjcPropertyT* = distinct pointer
  Protocol* = ObjcObject
  ObjcMethodDescription* {.bycopy.} = object
    name*: Sel
    types*: cstring
  ObjcPropertyAttributeT* {.bycopy.} = object
    name*: cstring
    value*: cstring
  ObjcAssociationPolicy* = ptr uint
  ObjcHookGetImageName* = proc (cls: Class; outImageName: cstringArray): Bool {.cdecl.}
  ObjcHookGetClass* = proc (name: cstring; outClass: ptr Class): Bool {.cdecl.}
  MachHeader* = object
  ObjcFuncLoadImage* = proc (header: ptr MachHeader) {.cdecl.}
  ObjcHookLazyClassNamer* = proc (cls: Class): cstring {.cdecl.}
  ObjcSwiftMetadataInitializer* = proc (cls: Class; arg: pointer): Class {.cdecl.}

const
  OBJC_REALIZECLASSFROMSWIFT_DEFINED* = 1
  OBJC_SETHOOK_LAZYCLASSNAMER_DEFINED* = 1
  OBJC_ADDLOADIMAGEFUNC_DEFINED* = 1
  OBJC_GETCLASSHOOK_DEFINED* = 1
  OBJC_ASSOCIATION_ASSIGN* = 0
  OBJC_ASSOCIATION_RETAIN_NONATOMIC* = 1
  OBJC_ASSOCIATION_COPY_NONATOMIC* = 3
  OBJC_ASSOCIATION_RETAIN* = 0o1401
  OBJC_ASSOCIATION_COPY* = 0o1403

  C_ID* = '@'
  C_CLASS* = '#'
  C_SEL* = ':'
  C_CHR* = 'c'
  C_UCHR* = 'C'
  C_SHT* = 's'
  C_USHT* = 'S'
  C_INT* = 'i'
  C_UINT* = 'I'
  C_LNG* = 'l'
  C_ULNG* = 'L'
  C_LNG_LNG* = 'q'
  C_ULNG_LNG* = 'Q'
  C_INT128* = 't'
  C_UINT128* = 'T'
  C_FLT* = 'f'
  C_DBL* = 'd'
  C_LNG_DBL* = 'D'
  C_BFLD* = 'b'
  C_BOOL* = 'B'
  C_VOID* = 'v'
  C_UNDEF* = '?'
  C_PTR* = '^'
  C_CHARPTR* = '*'
  C_ATOM* = '%'
  C_ARY_B* = '['
  C_ARY_E* = ']'
  C_UNION_B* = '('
  C_UNION_E* = ')'
  C_STRUCT_B* = '{'
  C_STRUCT_E* = '}'
  C_VECTOR* = '!'
  C_COMPLEX* = 'j'
  C_ATOMIC* = 'A'
  C_CONST* = 'r'
  C_IN* = 'n'
  C_INOUT* = 'N'
  C_OUT* = 'o'
  C_BYCOPY* = 'O'
  C_BYREF* = 'R'
  C_ONEWAY* = 'V'
  C_GNUREGISTER* = '+'


proc objectCopy*(obj: Id; size: csize_t): Id {.cdecl, importc: "object_copy",
    dynlib: libobjc.}

proc objectDispose*(obj: Id): Id {.cdecl, importc: "object_dispose", dynlib: libobjc.}

proc objectGetClass*(obj: Id): Class {.cdecl, importc: "object_getClass",
                                   dynlib: libobjc.}

proc objectSetClass*(obj: Id; cls: Class): Class {.cdecl, importc: "object_setClass",
    dynlib: libobjc.}

proc objectIsClass*(obj: Id): Bool {.cdecl, importc: "object_isClass", dynlib: libobjc.}

proc objectGetIvar*(obj: Id; ivar: Ivar): Id {.cdecl, importc: "object_getIvar",
    dynlib: libobjc.}

proc objectSetIvar*(obj: Id; ivar: Ivar; value: Id) {.cdecl, importc: "object_setIvar",
    dynlib: libobjc.}

proc objectSetIvarWithStrongDefault*(obj: Id; ivar: Ivar; value: Id) {.cdecl,
    importc: "object_setIvarWithStrongDefault", dynlib: libobjc.}

proc objectSetInstanceVariable*(obj: Id; name: cstring; value: pointer): Ivar {.cdecl,
    importc: "object_setInstanceVariable", dynlib: libobjc.}

proc objectSetInstanceVariableWithStrongDefault*(obj: Id; name: cstring;
    value: pointer): Ivar {.cdecl, importc: "object_setInstanceVariableWithStrongDefault",
                         dynlib: libobjc.}

proc objectGetInstanceVariable*(obj: Id; name: cstring; outValue: ptr pointer): Ivar {.
    cdecl, importc: "object_getInstanceVariable", dynlib: libobjc.}

proc objcGetClass*(name: cstring): Class {.cdecl, importc: "objc_getClass",
                                       dynlib: libobjc.}

proc objcGetMetaClass*(name: cstring): Class {.cdecl, importc: "objc_getMetaClass",
    dynlib: libobjc.}

proc objcLookUpClass*(name: cstring): Class {.cdecl, importc: "objc_lookUpClass",
    dynlib: libobjc.}

proc objcGetRequiredClass*(name: cstring): Class {.cdecl,
    importc: "objc_getRequiredClass", dynlib: libobjc.}

proc objcGetClassList*(buffer: ptr Class; bufferCount: cint): cint {.cdecl,
    importc: "objc_getClassList", dynlib: libobjc.}

proc objcCopyClassList*(outCount: ptr cuint): ptr Class {.cdecl,
    importc: "objc_copyClassList", dynlib: libobjc.}

proc classGetName*(cls: Class): cstring {.cdecl, importc: "class_getName",
                                      dynlib: libobjc.}

proc classIsMetaClass*(cls: Class): Bool {.cdecl, importc: "class_isMetaClass",
                                       dynlib: libobjc.}

proc classGetSuperclass*(cls: Class): Class {.cdecl, importc: "class_getSuperclass",
    dynlib: libobjc.}

proc classSetSuperclass*(cls: Class; newSuper: Class): Class {.cdecl,
    importc: "class_setSuperclass", dynlib: libobjc.}

proc classGetVersion*(cls: Class): cint {.cdecl, importc: "class_getVersion",
                                      dynlib: libobjc.}

proc classSetVersion*(cls: Class; version: cint) {.cdecl, importc: "class_setVersion",
    dynlib: libobjc.}

proc classGetInstanceSize*(cls: Class): csize_t {.cdecl,
    importc: "class_getInstanceSize", dynlib: libobjc.}

proc classGetInstanceVariable*(cls: Class; name: cstring): Ivar {.cdecl,
    importc: "class_getInstanceVariable", dynlib: libobjc.}

proc classGetClassVariable*(cls: Class; name: cstring): Ivar {.cdecl,
    importc: "class_getClassVariable", dynlib: libobjc.}

proc classCopyIvarList*(cls: Class; outCount: ptr cuint): ptr Ivar {.cdecl,
    importc: "class_copyIvarList", dynlib: libobjc.}

proc classGetInstanceMethod*(cls: Class; name: Sel): Method {.cdecl,
    importc: "class_getInstanceMethod", dynlib: libobjc.}

proc classGetClassMethod*(cls: Class; name: Sel): Method {.cdecl,
    importc: "class_getClassMethod", dynlib: libobjc.}

proc classGetMethodImplementation*(cls: Class; name: Sel): Imp {.cdecl,
    importc: "class_getMethodImplementation", dynlib: libobjc.}

proc classGetMethodImplementationStret*(cls: Class; name: Sel): Imp {.cdecl,
    importc: "class_getMethodImplementation_stret", dynlib: libobjc.}

proc classRespondsToSelector*(cls: Class; sel: Sel): Bool {.cdecl,
    importc: "class_respondsToSelector", dynlib: libobjc.}

proc classCopyMethodList*(cls: Class; outCount: ptr cuint): ptr Method {.cdecl,
    importc: "class_copyMethodList", dynlib: libobjc.}

proc classConformsToProtocol*(cls: Class; protocol: ptr Protocol): Bool {.cdecl,
    importc: "class_conformsToProtocol", dynlib: libobjc.}

proc classCopyProtocolList*(cls: Class; outCount: ptr cuint): ptr ptr Protocol {.cdecl,
    importc: "class_copyProtocolList", dynlib: libobjc.}

proc classGetProperty*(cls: Class; name: cstring): ObjcPropertyT {.cdecl,
    importc: "class_getProperty", dynlib: libobjc.}

proc classCopyPropertyList*(cls: Class; outCount: ptr cuint): ptr ObjcPropertyT {.cdecl,
    importc: "class_copyPropertyList", dynlib: libobjc.}

proc classGetIvarLayout*(cls: Class): ptr uint8 {.cdecl,
    importc: "class_getIvarLayout", dynlib: libobjc.}

proc classGetWeakIvarLayout*(cls: Class): ptr uint8 {.cdecl,
    importc: "class_getWeakIvarLayout", dynlib: libobjc.}

proc classAddMethod*(cls: Class; name: Sel; imp: Imp; types: cstring): Bool {.cdecl,
    importc: "class_addMethod", dynlib: libobjc.}

proc classReplaceMethod*(cls: Class; name: Sel; imp: Imp; types: cstring): Imp {.cdecl,
    importc: "class_replaceMethod", dynlib: libobjc.}

proc classAddIvar*(cls: Class; name: cstring; size: csize_t; alignment: uint8;
                  types: cstring): Bool {.cdecl, importc: "class_addIvar",
                                       dynlib: libobjc.}

proc classAddProtocol*(cls: Class; protocol: ptr Protocol): Bool {.cdecl,
    importc: "class_addProtocol", dynlib: libobjc.}

proc classAddProperty*(cls: Class; name: cstring;
                      attributes: ptr ObjcPropertyAttributeT; attributeCount: cuint): Bool {.
    cdecl, importc: "class_addProperty", dynlib: libobjc.}

proc classReplaceProperty*(cls: Class; name: cstring;
                          attributes: ptr ObjcPropertyAttributeT;
                          attributeCount: cuint) {.cdecl,
    importc: "class_replaceProperty", dynlib: libobjc.}

proc classSetIvarLayout*(cls: Class; layout: ptr uint8) {.cdecl,
    importc: "class_setIvarLayout", dynlib: libobjc.}

proc classSetWeakIvarLayout*(cls: Class; layout: ptr uint8) {.cdecl,
    importc: "class_setWeakIvarLayout", dynlib: libobjc.}

proc objcGetFutureClass*(name: cstring): Class {.cdecl,
    importc: "objc_getFutureClass", dynlib: libobjc.}

proc classCreateInstance*(cls: Class; extraBytes: csize_t): Id {.cdecl,
    importc: "class_createInstance", dynlib: libobjc.}

proc objcConstructInstance*(cls: Class; bytes: pointer): Id {.cdecl,
    importc: "objc_constructInstance", dynlib: libobjc.}

proc objcDestructInstance*(obj: Id): pointer {.cdecl,
    importc: "objc_destructInstance", dynlib: libobjc.}

proc objcAllocateClassPair*(superclass: Class; name: cstring; extraBytes: csize_t): Class {.
    cdecl, importc: "objc_allocateClassPair", dynlib: libobjc.}

proc objcRegisterClassPair*(cls: Class) {.cdecl, importc: "objc_registerClassPair",
                                       dynlib: libobjc.}

proc objcDuplicateClass*(original: Class; name: cstring; extraBytes: csize_t): Class {.
    cdecl, importc: "objc_duplicateClass", dynlib: libobjc.}

proc objcDisposeClassPair*(cls: Class) {.cdecl, importc: "objc_disposeClassPair",
                                      dynlib: libobjc.}

proc methodGetName*(m: Method): Sel {.cdecl, importc: "method_getName", dynlib: libobjc.}

proc methodGetImplementation*(m: Method): Imp {.cdecl,
    importc: "method_getImplementation", dynlib: libobjc.}

proc methodGetTypeEncoding*(m: Method): cstring {.cdecl,
    importc: "method_getTypeEncoding", dynlib: libobjc.}

proc methodGetNumberOfArguments*(m: Method): cuint {.cdecl,
    importc: "method_getNumberOfArguments", dynlib: libobjc.}

proc methodCopyReturnType*(m: Method): cstring {.cdecl,
    importc: "method_copyReturnType", dynlib: libobjc.}

proc methodCopyArgumentType*(m: Method; index: cuint): cstring {.cdecl,
    importc: "method_copyArgumentType", dynlib: libobjc.}

proc methodGetReturnType*(m: Method; dst: cstring; dstLen: csize_t) {.cdecl,
    importc: "method_getReturnType", dynlib: libobjc.}

proc methodGetArgumentType*(m: Method; index: cuint; dst: cstring; dstLen: csize_t) {.
    cdecl, importc: "method_getArgumentType", dynlib: libobjc.}
proc methodGetDescription*(m: Method): ptr ObjcMethodDescription {.cdecl,
    importc: "method_getDescription", dynlib: libobjc.}

proc methodSetImplementation*(m: Method; imp: Imp): Imp {.cdecl,
    importc: "method_setImplementation", dynlib: libobjc.}

proc methodExchangeImplementations*(m1: Method; m2: Method) {.cdecl,
    importc: "method_exchangeImplementations", dynlib: libobjc.}

proc ivarGetName*(v: Ivar): cstring {.cdecl, importc: "ivar_getName", dynlib: libobjc.}

proc ivarGetTypeEncoding*(v: Ivar): cstring {.cdecl, importc: "ivar_getTypeEncoding",
    dynlib: libobjc.}

proc ivarGetOffset*(v: Ivar): int {.cdecl, importc: "ivar_getOffset",
                                     dynlib: libobjc.}

proc propertyGetName*(property: ObjcPropertyT): cstring {.cdecl,
    importc: "property_getName", dynlib: libobjc.}

proc propertyGetAttributes*(property: ObjcPropertyT): cstring {.cdecl,
    importc: "property_getAttributes", dynlib: libobjc.}

proc propertyCopyAttributeList*(property: ObjcPropertyT; outCount: ptr cuint): ptr ObjcPropertyAttributeT {.
    cdecl, importc: "property_copyAttributeList", dynlib: libobjc.}

proc propertyCopyAttributeValue*(property: ObjcPropertyT; attributeName: cstring): cstring {.
    cdecl, importc: "property_copyAttributeValue", dynlib: libobjc.}

proc objcGetProtocol*(name: cstring): ptr Protocol {.cdecl,
    importc: "objc_getProtocol", dynlib: libobjc.}

proc objcCopyProtocolList*(outCount: ptr cuint): ptr ptr Protocol {.cdecl,
    importc: "objc_copyProtocolList", dynlib: libobjc.}

proc protocolConformsToProtocol*(proto: ptr Protocol; other: ptr Protocol): Bool {.
    cdecl, importc: "protocol_conformsToProtocol", dynlib: libobjc.}

proc protocolIsEqual*(proto: ptr Protocol; other: ptr Protocol): Bool {.cdecl,
    importc: "protocol_isEqual", dynlib: libobjc.}

proc protocolGetName*(proto: ptr Protocol): cstring {.cdecl,
    importc: "protocol_getName", dynlib: libobjc.}

proc protocolGetMethodDescription*(proto: ptr Protocol; aSel: Sel;
                                  isRequiredMethod: Bool; isInstanceMethod: Bool): ObjcMethodDescription {.
    cdecl, importc: "protocol_getMethodDescription", dynlib: libobjc.}

proc protocolCopyMethodDescriptionList*(proto: ptr Protocol; isRequiredMethod: Bool;
                                       isInstanceMethod: Bool; outCount: ptr cuint): ptr ObjcMethodDescription {.
    cdecl, importc: "protocol_copyMethodDescriptionList", dynlib: libobjc.}

proc protocolGetProperty*(proto: ptr Protocol; name: cstring;
                         isRequiredProperty: Bool; isInstanceProperty: Bool): ObjcPropertyT {.
    cdecl, importc: "protocol_getProperty", dynlib: libobjc.}

proc protocolCopyPropertyList*(proto: ptr Protocol; outCount: ptr cuint): ptr ObjcPropertyT {.
    cdecl, importc: "protocol_copyPropertyList", dynlib: libobjc.}

proc protocolCopyPropertyList2*(proto: ptr Protocol; outCount: ptr cuint;
                               isRequiredProperty: Bool; isInstanceProperty: Bool): ptr ObjcPropertyT {.
    cdecl, importc: "protocol_copyPropertyList2", dynlib: libobjc.}

proc protocolCopyProtocolList*(proto: ptr Protocol; outCount: ptr cuint): ptr ptr Protocol {.
    cdecl, importc: "protocol_copyProtocolList", dynlib: libobjc.}

proc objcAllocateProtocol*(name: cstring): ptr Protocol {.cdecl,
    importc: "objc_allocateProtocol", dynlib: libobjc.}

proc objcRegisterProtocol*(proto: ptr Protocol) {.cdecl,
    importc: "objc_registerProtocol", dynlib: libobjc.}

proc protocolAddMethodDescription*(proto: ptr Protocol; name: Sel; types: cstring;
                                  isRequiredMethod: Bool; isInstanceMethod: Bool) {.
    cdecl, importc: "protocol_addMethodDescription", dynlib: libobjc.}

proc protocolAddProtocol*(proto: ptr Protocol; addition: ptr Protocol) {.cdecl,
    importc: "protocol_addProtocol", dynlib: libobjc.}

proc protocolAddProperty*(proto: ptr Protocol; name: cstring;
                         attributes: ptr ObjcPropertyAttributeT;
                         attributeCount: cuint; isRequiredProperty: Bool;
                         isInstanceProperty: Bool) {.cdecl,
    importc: "protocol_addProperty", dynlib: libobjc.}

proc objcCopyImageNames*(outCount: ptr cuint): cstringArray {.cdecl,
    importc: "objc_copyImageNames", dynlib: libobjc.}

proc classGetImageName*(cls: Class): cstring {.cdecl, importc: "class_getImageName",
    dynlib: libobjc.}

proc objcCopyClassNamesForImage*(image: cstring; outCount: ptr cuint): cstringArray {.
    cdecl, importc: "objc_copyClassNamesForImage", dynlib: libobjc.}

proc selGetName*(sel: Sel): cstring {.cdecl, importc: "sel_getName", dynlib: libobjc.}

proc selRegisterName*(str: cstring): Sel {.cdecl, importc: "sel_registerName",
                                       dynlib: libobjc.}

proc selIsEqual*(lhs: Sel; rhs: Sel): Bool {.cdecl, importc: "sel_isEqual",
                                       dynlib: libobjc.}

proc objcEnumerationMutation*(obj: Id) {.cdecl, importc: "objc_enumerationMutation",
                                      dynlib: libobjc.}

proc objcSetEnumerationMutationHandler*(handler: proc (a1: Id) {.cdecl.}) {.cdecl,
    importc: "objc_setEnumerationMutationHandler", dynlib: libobjc.}

proc objcSetForwardHandler*(fwd: pointer; fwdStret: pointer) {.cdecl,
    importc: "objc_setForwardHandler", dynlib: libobjc.}

proc impImplementationWithBlock*(`block`: Id): Imp {.cdecl,
    importc: "imp_implementationWithBlock", dynlib: libobjc.}

proc impGetBlock*(anImp: Imp): Id {.cdecl, importc: "imp_getBlock", dynlib: libobjc.}

proc impRemoveBlock*(anImp: Imp): Bool {.cdecl, importc: "imp_removeBlock",
                                     dynlib: libobjc.}

proc objcLoadWeak*(location: ptr Id): Id {.cdecl, importc: "objc_loadWeak",
                                      dynlib: libobjc.}

proc objcStoreWeak*(location: ptr Id; obj: Id): Id {.cdecl, importc: "objc_storeWeak",
    dynlib: libobjc.}

proc objcSetAssociatedObject*(`object`: Id; key: pointer; value: Id;
                             policy: ObjcAssociationPolicy) {.cdecl,
    importc: "objc_setAssociatedObject", dynlib: libobjc.}

proc objcGetAssociatedObject*(`object`: Id; key: pointer): Id {.cdecl,
    importc: "objc_getAssociatedObject", dynlib: libobjc.}

proc objcRemoveAssociatedObjects*(`object`: Id) {.cdecl,
    importc: "objc_removeAssociatedObjects", dynlib: libobjc.}

proc objcSetHookGetImageName*(newValue: ObjcHookGetImageName;
                             outOldValue: ptr ObjcHookGetImageName) {.cdecl,
    importc: "objc_setHook_getImageName", dynlib: libobjc.}

proc objcSetHookGetClass*(newValue: ObjcHookGetClass;
                         outOldValue: ptr ObjcHookGetClass) {.cdecl,
    importc: "objc_setHook_getClass", dynlib: libobjc.}

proc objcAddLoadImageFunc*(`func`: ObjcFuncLoadImage) {.cdecl,
    importc: "objc_addLoadImageFunc", dynlib: libobjc.}

proc objcSetHookLazyClassNamer*(newValue: ObjcHookLazyClassNamer;
                               oldOutValue: ptr ObjcHookLazyClassNamer) {.cdecl,
    importc: "objc_setHook_lazyClassNamer", dynlib: libobjc.}

proc objcRealizeClassFromSwift*(cls: Class; previously: pointer): Class {.cdecl,
    importc: "_objc_realizeClassFromSwift", dynlib: libobjc.}


proc classLookupMethod*(cls: Class; sel: Sel): Imp {.cdecl,
    importc: "class_lookupMethod", dynlib: libobjc.}
proc classRespondsToMethod*(cls: Class; sel: Sel): Bool {.cdecl,
    importc: "class_respondsToMethod", dynlib: libobjc.}
proc objcFlushCaches*(cls: Class) {.cdecl, importc: "_objc_flush_caches",
                                 dynlib: libobjc.}
proc objectCopyFromZone*(anObject: Id; nBytes: csize_t; z: pointer): Id {.cdecl,
    importc: "object_copyFromZone", dynlib: libobjc.}
proc classCreateInstanceFromZone*(a1: Class; idxIvars: csize_t; z: pointer): Id {.cdecl,
    importc: "class_createInstanceFromZone", dynlib: libobjc.}
