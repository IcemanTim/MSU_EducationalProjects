(defun is-contain (substr str)
	(cond 
		((null substr) T)
		((> (length substr) (length str)) nil)
		((equal (car substr) (car str)) (is-contain (cdr substr) (cdr str)))
		(T nil)
	)
)

(defun num-contain (substr str count)
	(cond 
		((null substr) count)
		((> (length substr) (length str)) count)
		(T 
			(if (is-contain substr str)
				(num-contain substr (cdr str) (+ count 1))
				(num-contain substr (cdr str) count)
			)
		)
	)
)	

(defun readloop (arg count)
	(let ((text (read-line nil nil)))
		(if (null text) count
			(readloop arg (+ count (num-contain arg (coerce text 'list) 0)))
		)
	)
)

(print (readloop (coerce (second *posix-argv*) 'list) 0))
									