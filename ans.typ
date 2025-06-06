= Q1: How much faster?
use `time` to test time \
original code 0.91s user 0.20s system 123% cpu 0.903 total\
modified code 0.66s user 0.28s system 225% cpu 0.413 total\
it is 2.18x faster

= Q2: What's the optimal number of goroutines?
the optimal number of goroutines is 8, as my cpu has 8 cores.

