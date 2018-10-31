(defun match-wildcard (wildcard str)
	(defun helper (wildcard str star)
    	(cond 
			((null wildcard) (or star (null str)))
	        ((null str) 
				(reduce 
					(lambda (x y) (and x y)) 
					(map 'list #'(lambda (x) (equal x #\*)) wildcard)
					:initial-value t
				)
			)
	        ((equal (car wildcard) #\?) 
     	    	(if star 
     	        	(or 
					  	(helper (cdr wildcard) (cdr str) '()) 
     	        	    (helper wildcard (cdr str) t)
					)
	                (helper (cdr wildcard) (cdr str) '())
	            )
			)
            ((equal (car wildcard) #\*) (helper (cdr wildcard) str t)) 
            (t 
				(if (equal (car wildcard) (car str))
	                (if star
	                    (or 
							(helper (cdr wildcard) (cdr str) '())
	                        (helper wildcard (cdr str) t)
						)
	                    (helper (cdr wildcard) (cdr str) '())
                 	)
	                (if star (helper wildcard (cdr str) t)
	                    '()
                 	)
				)
			)
		)
	)
	(if (helper (coerce wildcard 'list)	(coerce str 'list) '()) 
		(print 'YES)
	   	(print 'NO)
	)
	(terpri)
)

(defun main ()
	(match-wildcard (second *posix-argv*) (third *posix-argv*))
)

(main)


    
