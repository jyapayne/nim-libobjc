import objc
import runtime

type
  ComplexLD* {.importc: "_Complex long double", nodecl.} = clongdouble
  ObjcSuper* {.bycopy.} = object
    ## Specifies the superclass of an instance.
    receiver*: Id ## Specifies an instance of a class.
    superClass*: Class ## Specifies the particular superclass of the instance to message.


proc objcMsgSend*(self: Id; op: Sel): Id {.varargs, cdecl, importc: "objc_msgSend",
                                     dynlib: libobjc.}
  ## Sends a message with a simple return value to an instance of a class.
  ##
  ## @param self A pointer to the instance of the class that is to receive the message.
  ## @param op The selector of the method that handles the message.
  ## @param ...
  ##   A variable argument list containing the arguments to the method.
  ##
  ## @return The return value of the method.
  ##
  ## @note When it encounters a method call, the compiler generates a call to one of the
  ##  functions \c objc_msgSend, \c objc_msgSend_stret, \c objc_msgSendSuper, or \c objc_msgSendSuper_stret.
  ##  Messages sent to an object’s superclass (using the \c super keyword) are sent using \c objc_msgSendSuper;
  ##  other messages are sent using \c objc_msgSend. Methods that have data structures as return values
  ##  are sent using \c objc_msgSendSuper_stret and \c objc_msgSend_stret.


proc objcMsgSendSuper*(super: ptr ObjcSuper; op: Sel): Id {.varargs, cdecl,
    importc: "objc_msgSendSuper", dynlib: libobjc.}
  ## Sends a message with a simple return value to the superclass of an instance of a class.
  ##
  ## @param super A pointer to an \c objc_super data structure. Pass values identifying the
  ##  context the message was sent to, including the instance of the class that is to receive the
  ##  message and the superclass at which to start searching for the method implementation.
  ## @param op A pointer of type SEL. Pass the selector of the method that will handle the message.
  ## @param ...
  ##   A variable argument list containing the arguments to the method.
  ##
  ## @return The return value of the method identified by \e op.
  ##
  ## @see objc_msgSend

proc objcMsgSendStret*(self: Id; op: Sel) {.varargs, cdecl,
                                       importc: "objc_msgSend_stret",
                                       dynlib: libobjc.}
  ## Sends a message with a data-structure return value to an instance of a class.
  ##
  ## @see objc_msgSend

proc objcMsgSendSuperStret*(super: ptr ObjcSuper; op: Sel) {.varargs, cdecl,
    importc: "objc_msgSendSuper_stret", dynlib: libobjc.}
  ## Sends a message with a data-structure return value to the superclass of an instance of a class.
  ##
  ## @see objc_msgSendSuper


## Floating-point-returning Messaging Primitives
##
## Use these functions to call methods that return floating-point values
## on the stack.
## Consult your local function call ABI documentation for details.
##
## arm:    objc_msgSend_fpret not used
## i386:   objc_msgSend_fpret used for `float`, `double`, `long double`.
## x86-64: objc_msgSend_fpret used for `long double`.
##
## arm:    objc_msgSend_fp2ret not used
## i386:   objc_msgSend_fp2ret not used
## x86-64: objc_msgSend_fp2ret used for `_Complex long double`.
##
## These functions must be cast to an appropriate function pointer type
## before being called.
##

when defined(amd64):
  proc objcMsgSendFpret*(self: Id; op: Sel): clongdouble {.varargs, cdecl,
      importc: "objc_msgSend_fpret", dynlib: libobjc.}
    ## Sends a message with a floating-point return value to an instance of a class.
    ##
    ## @see objc_msgSend

  proc objcMsgSendFp2ret*(self: Id; op: Sel): ComplexLD {.varargs, cdecl,
                                          importc: "objc_msgSend_fp2ret",
                                          dynlib: libobjc.}
elif defined(i386):
  proc objcMsgSendFpret*(self: Id; op: Sel): cdouble {.varargs, cdecl,
      importc: "objc_msgSend_fpret", dynlib: libobjc.}
    ## Sends a message with a floating-point return value to an instance of a class.
    ##
    ## @see objc_msgSend
    ## @note On the i386 platform, the ABI for functions returning a floating-point value is
    ##  incompatible with that for functions returning an integral type. On the i386 platform, therefore,
    ##  you must use \c objc_msgSend_fpret for functions returning non-integral type. For \c float or
    ##  \c long \c double return types, cast the function to an appropriate function pointer type first.

## Direct Method Invocation Primitives
## Use these functions to call the implementation of a given Method.
## This is faster than calling method_getImplementation() and method_getName().
##
## The receiver must not be nil.
##
## These functions must be cast to an appropriate function pointer type
## before being called.

proc methodInvoke*(receiver: Id; m: Method): Id {.varargs, cdecl,
    importc: "method_invoke", dynlib: libobjc.}
proc methodInvokeStret*(receiver: Id; m: Method) {.varargs, cdecl,
    importc: "method_invoke_stret", dynlib: libobjc.}

## Message Forwarding Primitives
## Use these functions to forward a message as if the receiver did not
## respond to it.
##
## The receiver must not be nil.
##
## class_getMethodImplementation() may return (IMP)_objc_msgForward.
## class_getMethodImplementation_stret() may return (IMP)_objc_msgForward_stret
##
## These functions must be cast to an appropriate function pointer type
## before being called.
##
## Before Mac OS X 10.6, _objc_msgForward must not be called directly
## but may be compared to other IMP values.

proc objcMsgForward*(receiver: Id; sel: Sel): Id {.varargs, cdecl,
    importc: "_objc_msgForward", dynlib: libobjc.}
proc objcMsgForwardStret*(receiver: Id; sel: Sel) {.varargs, cdecl,
    importc: "_objc_msgForward_stret", dynlib: libobjc.}
