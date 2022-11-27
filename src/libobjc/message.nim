import objc
import runtime

type
  ObjcSuper* {.bycopy.} = object
    receiver*: Id
    superClass*: Class



proc objcMsgSend*(self: Id; op: Sel): Id {.varargs, cdecl, importc: "objc_msgSend",
                                     dynlib: libobjc.}

proc objcMsgSendSuper*(super: ptr ObjcSuper; op: Sel): Id {.varargs, cdecl,
    importc: "objc_msgSendSuper", dynlib: libobjc.}

proc objcMsgSendStret*(self: Id; op: Sel) {.varargs, cdecl,
                                       importc: "objc_msgSend_stret",
                                       dynlib: libobjc.}

proc objcMsgSendSuperStret*(super: ptr ObjcSuper; op: Sel) {.varargs, cdecl,
    importc: "objc_msgSendSuper_stret", dynlib: libobjc.}

proc objcMsgSendFpret*(self: Id; op: Sel): clongdouble {.varargs, cdecl,
    importc: "objc_msgSend_fpret", dynlib: libobjc.}
proc objcMsgSendFp2ret*(self: Id; op: Sel) {.varargs, cdecl,
                                        importc: "objc_msgSend_fp2ret",
                                        dynlib: libobjc.}

proc methodInvoke*(receiver: Id; m: Method): Id {.varargs, cdecl,
    importc: "method_invoke", dynlib: libobjc.}
proc methodInvokeStret*(receiver: Id; m: Method) {.varargs, cdecl,
    importc: "method_invoke_stret", dynlib: libobjc.}

proc objcMsgForward*(receiver: Id; sel: Sel): Id {.varargs, cdecl,
    importc: "_objc_msgForward", dynlib: libobjc.}
proc objcMsgForwardStret*(receiver: Id; sel: Sel) {.varargs, cdecl,
    importc: "_objc_msgForward_stret", dynlib: libobjc.}
