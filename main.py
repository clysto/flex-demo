from ctypes import *


class Token(Structure):
    _fields_ = [("text", c_char_p), ("type", c_int), ("line", c_int)]


liblex = cdll.LoadLibrary("liblex.so")
libc = cdll.LoadLibrary("libc.dylib")

fopen = libc.fopen
fopen.argtypes = c_char_p, c_char_p
fopen.restype = c_void_p

fclose = libc.fclose
fclose.argtypes = (c_void_p,)
fclose.restype = c_int

lex = liblex.lex
lex.argtypes = c_void_p, POINTER(Token)
lex.restype = c_int

fp = fopen(b"tests/a", b"r")
token = Token()

with open('tests/a.txt', "r") as f:
    lines = f.readlines()
    for index, line in enumerate(lines, start=1):
        print(f"{index:2}: {line[:-1]}")

title = f"{'line':>5}  {'type':>5}    {'token':10}"
print("┌" + len(title) * "─" + "┐")
print("│" + title + "│")
print("├" + len(title) * "─" + "┤")
while lex(fp, byref(token)):
    print(f"│{token.line:>5}  {token.type:>5}    {token.text.decode('ascii'):10}│")
print("└" + len(title) * "─"+ "┘")

fclose(fp)
