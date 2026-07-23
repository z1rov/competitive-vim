" Author: z1rov

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal cindent
setlocal cinoptions=l1,g0,N-s,t0
setlocal path+=.,,
compiler gcc
setlocal makeprg=g++\ -std=c++17\ -O2\ -Wall\ -Wshadow\ -o\ %:r\ %
setlocal errorformat=%f:%l:%c:\ %t%*[^:]:\ %m
