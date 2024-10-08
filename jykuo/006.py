# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 18:27:59 2021

@author: Hank
"""

a=input()
b=input()
c=input()
d=input()
e=a+b
strSum=len(e)
#if c==' ':
#    e=' '+e+' '
e=e.replace(c, d)
strSum+=len(e)
print(strSum)
print(e[0:3]+e[len(e)-3:len(e)],end=(''))
print(e[0:3]+e[len(e)-3:len(e)],end=(''))
print(e[0:3]+e[len(e)-3:len(e)],end=(''))
