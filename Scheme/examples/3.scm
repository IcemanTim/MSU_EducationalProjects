#!/usr/bin/csi -s

(define (match-wildcard wildcard str)
	(define (helper wildcard str star)
    	(cond 
			((null? wildcard) (or (not (equal? '() star)) (null? str)))
	        ((null? str) 
				(foldr 
					(lambda (x y) (and x y)) 
				    #t
                	(map (lambda (x) (equal? x #\*)) wildcard)
				)
			)
	        ((equal? (car wildcard) #\?) 
     	    	(if star 
     	        	(or 
					  	(helper (cdr wildcard) (cdr str) '()) 
     	        	    (helper wildcard (cdr str) #t)
					)
	                (helper (cdr wildcard) (cdr str) '())
	            )
			)
            ((equal? (car wildcard) #\*) (helper (cdr wildcard) str #t)) 
            (else
				(if (equal? (car wildcard) (car str))
	                (if star
	                    (or 
							(helper (cdr wildcard) (cdr str) '())
	                        (helper wildcard (cdr str) #t)
						)
	                    (helper (cdr wildcard) (cdr str) '())
                 	)
	                (if star (helper wildcard (cdr str) #t)
	                    '()
                 	)
				)
			)
		)
	)
	(if (helper (string->list wildcard)	(string->list str) '()) 
		(print 'YES)
    	(print 'NO)
	)
	(print)
)

(define (main)
	(match-wildcard (cadddr (argv)) (car (cddddr (argv))))
)

(main)
