# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 18:52:23 2021

@author: Hank
"""

a=input()
b=input()
print(len(a))
a='[\''+a.replace(b, '\', \'')+'\']'
print(a)
