#!/usr/bin/csi -s

(define (out-args lst)
    (if (null? lst) 
        (print)
        (begin 
            (print (car lst))
            (out-args (cdr lst))
        )
    )
)

(out-args (argv))
