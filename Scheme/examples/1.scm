(define (reverse_word tail lst)
	(if (null? tail) 
		lst
		(reverse_word (cdr tail) (cons (car tail) lst))
	)
)

(define (reverse1 lst)
	(if (null? lst) 
		lst
		(reverse_word lst '())
	)
)

(define (print_args lst)
    (if (null? lst) 
        lst
    	(begin 
        	(print (list->string (reverse1 (string->list (car lst)))))
        	(print_args args (cdr lst))
    	)
    )
)

; argv -> ("/usr/local/bin/csi" "-s" "1.scm" "./1.scm" "abc")

(print_args (cdr (argv)))
(print)