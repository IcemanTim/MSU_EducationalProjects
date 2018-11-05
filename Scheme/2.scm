#!/usr/bin/csi -s

(define (my_reverse lst)
	(define (helper tail res)
		(if (null? tail) res
			(helper (cdr tail) (cons (car tail) res))
		)
	)
	(if (null? lst) lst
		(helper lst '())
	)
)

(define (is-polindrom str)
	(if (equal? str (my_reverse str)) 'YES 
		'NO
	)
)

(print (is-polindrom (string->list (cadddr (argv)))))
