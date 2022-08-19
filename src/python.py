import ctypes
from math import sqrt


def main():
    lib_all_linked = ctypes.CDLL("lib.so")
    callback = ctypes.CFUNCTYPE(None, ctypes.c_char_p)
    lib_all_linked.start.argtypes = [callback]
    lib_all_linked.start.restype = ctypes.c_int
    status = lib_all_linked.start(callback(callbackFunc))
    print("got status from asm: {}".format(status))

    callback = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int)
    lib_all_linked.check_elapsed_time.argtypes = [callback, ctypes.c_char_p]
    lib_all_linked.check_elapsed_time.restype = None
    lib_all_linked.check_elapsed_time(
        callback(n_th_prime), ctypes.create_string_buffer(b"python"))

    lib_all_linked.exit()


def callbackFunc(msg):
    print("This is a callback function written in python!, got msg: {}".format(msg))


def n_th_prime(n):
    count = 1
    current_n = 2
    while True:
        if is_prime(current_n):
            if count == n:
                return current_n
            count += 1
        current_n += 1


def is_prime(p):
    if p == 2:
        return True
    if p % 2 == 0:
        return False
    i = 3
    while i * i <= p:
        if p % i == 0:
            return False
        i += 2
    return True


if __name__ == "__main__":
    main()
