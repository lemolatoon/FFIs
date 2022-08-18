import ctypes


def main():
    lib_all_linked = ctypes.CDLL("lib.so")
    callback = ctypes.CFUNCTYPE(None, ctypes.c_char_p)
    lib_all_linked.start.argtypes = [callback]
    lib_all_linked.start.restype = ctypes.c_int
    status = lib_all_linked.start(callback(callbackFunc))
    print("status: {}".format(status))
    lib_all_linked.exit()


def callbackFunc(msg):
    print("This is a callback function written in python!, got msg: {}".format(msg))


if __name__ == "__main__":
    main()
