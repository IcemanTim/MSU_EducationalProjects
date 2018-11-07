
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

(define-external (palindrome (c-string str)) c-string
	(list->string (reverse1 (string->list str)))
)

(return-to-host)
