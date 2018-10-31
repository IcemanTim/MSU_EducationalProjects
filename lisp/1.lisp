(defun my_reverse (lst)
	(defun helper (tail res)
		(if (null tail) res
			(helper (cdr tail) (cons (car tail) res))
		)
	)
	(if (null lst) lst
		(helper lst '())
	)
)

(defun is-polindrom (str)
	(if (equal str (my_reverse str)) 'YES 
		'NO
	)
)

(print (is-polindrom (coerce (second *posix-argv*) 'list)))
