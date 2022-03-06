#!/usr/bin/env python3

"""
:c_str_literal():
produces `"<ascii with special C escapes and oct escapes else>"` from a python `bytes` object.

The whole file converts a binary file into a file
containing the string produced by c_str_literal().

#Test
python -c 'with open("/tmp/test_bin2c_py.dat","bw") as f: f.write(bytes(range(256)))'
python ./bin2c.py /tmp/test_bin2c_py.dat
cat << EOF > /tmp/test_bin2c_py.cpp
#include <cassert>
unsigned char data[] = 
#include "test_bin2c_py.dat.inc"
;
// sizeof(data) includes a terminating 0
int main() {assert(data[0]==0 && data[sizeof(data)-2]==255);}
EOF
g++ /tmp/test_bin2c_py.cpp -std=c++17 -o /tmp/test_bin2c_py && /tmp/test_bin2c_py
rm /tmp/test_bin2c_py.dat.inc
rm /tmp/test_bin2c_py.cpp
cat /tmp/test_bin2c_py.dat | python ./bin2c.py
rm /tmp/test_bin2c_py.dat
"""

import sys

c_str_literal = lambda d: '"{}"'.format(''.join(bytes_to_c_ascii_oct(d)))
def bytes_to_c_ascii_oct(d):
   """Convert binary data to C/C++ ASCII encoding.
   >>> d=bytes([0,ord('0'),3,ord('9'),ord(' '),ord('\t'),13])
   >>> c_str_literal(d)
   '"\\0000\\39 \\t\\r"'
   >>> d=bytes(range(256))
   >>> c_str_literal(d)[:9]
   '"\\0\\1\\2\\3'
   >>> c_str_literal(d)[-9:]
   '\\376\\377"'
   >>> d=bytes([92,56])
   >>> c_str_literal(d)
   '"\\\\8"'
   >>> d=b'\a\b\f\r\t\v\'\"\n'
   >>> c_str_literal(d)
   '"\\7\\b\\f\\r\\t\\v\'\\"\\n"'
   >>> d=bytes([63,63,ord('<')])
   >>> c_str_literal(d)
   '"\\?\\?<"'
   >>> from base64 import b64decode as b64d
   >>> d=b64d("2y1+2oAR6w8dzIYARovDfz/PD7JA8NW/fEteMTPNmpK7oswK8wWwR1ZMgH8//9Q74xRdcIWfPk8nr/9Pq9xQGDFv")
   >>> c_str_literal(d)[-8:]
   'P\\0301o"'

   """
   b2enc = ['\\0', '\\1', '\\2', '\\3', '\\4', '\\5', '\\6', '\\7', '\\b', '\\t', '\\n',
      '\\v', '\\f', '\\r', '\\16', '\\17', '\\20', '\\21', '\\22', '\\23', '\\24',
      '\\25', '\\26', '\\27', '\\30', '\\31', '\\32', '\\33', '\\34', '\\35', '\\36',
      '\\37', ' ', '!', '\\"', '#', '$', '%', '&', "'", '(', ')', '*', '+',
      ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':',
      ';', '<', '=', '>', '\\?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
      'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
      'Z', '[', '\\\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
      'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
      'y', 'z', '{', '|', '}', '~', '\\177', '\\200', '\\201', '\\202', '\\203', '\\204',
      '\\205', '\\206', '\\207', '\\210', '\\211', '\\212', '\\213', '\\214', '\\215', '\\216',
      '\\217', '\\220', '\\221', '\\222', '\\223', '\\224', '\\225', '\\226', '\\227', '\\230',
      '\\231', '\\232', '\\233', '\\234', '\\235', '\\236', '\\237', '\\240', '\\241', '\\242',
      '\\243', '\\244', '\\245', '\\246', '\\247', '\\250', '\\251', '\\252', '\\253', '\\254',
      '\\255', '\\256', '\\257', '\\260', '\\261', '\\262', '\\263', '\\264', '\\265', '\\266',
      '\\267', '\\270', '\\271', '\\272', '\\273', '\\274', '\\275', '\\276', '\\277', '\\300',
      '\\301', '\\302', '\\303', '\\304', '\\305', '\\306', '\\307', '\\310', '\\311', '\\312',
      '\\313', '\\314', '\\315', '\\316', '\\317', '\\320', '\\321', '\\322', '\\323', '\\324',
      '\\325', '\\326', '\\327', '\\330', '\\331', '\\332', '\\333', '\\334', '\\335', '\\336',
      '\\337', '\\340', '\\341', '\\342', '\\343', '\\344', '\\345', '\\346', '\\347', '\\350',
      '\\351', '\\352', '\\353', '\\354', '\\355', '\\356', '\\357', '\\360', '\\361', '\\362',
      '\\363', '\\364', '\\365', '\\366', '\\367', '\\370', '\\371', '\\372', '\\373', '\\374',
      '\\375', '\\376', '\\377']
   ord0,ord7,o16 = ord('0'),ord('7'),14
   lend = len(d)
   i,j = 0,1
   while j <= lend:
       di = d[i]
       bi = b2enc[di]
       if j == lend:
           yield bi
           break
       dj = d[j]
       if ((di<=7 or (di>=o16 and di<32))
           and dj>=ord0 and dj<=ord7):
           yield '\\'+"{:0>3o}".format(di)
       else:
           yield bi
       i,j = i+1,j+1

if __name__ == '__main__':
   a = sys.argv
   if len(a) > 2 or len(a)==2 and (a[1]=='--help' or a[1]=='-h'):
       print("{} [<filename>|--help|-h]".format(a[0]))
       print("stdin/stdout if no file name is given, else '.inc' is appended")
       exit(0)
   fi = len(a)==2 and open(a[1],'br') or sys.stdin.buffer
   fo = len(a)==2 and open(a[1]+'.inc','w') or sys.stdout
   d = fi.read()
   fo.write(c_str_literal(d))

