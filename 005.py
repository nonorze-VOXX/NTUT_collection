# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 19:05:25 2021

@author: Hank
"""
a=input()
b=input()
c=input()
d=a.split()
for i in range(len(d)):
    if d[i]==b:
        d[i]=c
    print(d[i],end=' ')
print('\n')

d=a.split()
"""
for i in range(len(d)):
    if d[i]==b:
        d[i]=c+' '+b
    print(d[i],end=' ')
print('\n')
"""
d=a.split()
for i in range(len(d)):
    if d[i]==b:
        d[i]=' '
for i in range(len(d)):
    if d[i]!=' ':
        print(d[i],end=' ')
print('\n')
