
; Перевод в итоговое представление

(defun final_clear (poly)
	(cond
		( (null poly) '0)
		( T poly)
	))

(defun fin (poly)
	(cond
		( (null poly) NIL)
		( (and (symbolp (car poly)) (eq (cadr poly) '^) (= (caddr poly) '1)) (cons (car poly) (fin (cdddr poly))))
		( T (cons (car poly) (fin (cdr poly))))
	))

(defun clear (poly)
	(cond
		( (null poly) NIL)
		( (eq (car poly) '+) (cond
								( (and (eq (cadr poly) '+) (eq (caddr poly) '-)) (cons (caddr poly) (clear (cdddr poly))))
								( (eq (cadr poly) '-) (cons (cadr poly) (clear (cddr poly))))
								( (eq (cadr poly) '+) (cons (cadr poly) (clear (cddr poly))))
								( (numberp (cadr poly)) (cond
											( (= (cadr poly) '0 ) (clear (cddr poly)))
											( T (cons (car poly) (clear (cdr poly))))))
							 	( T (cons (car poly) (clear (cdr poly))))
							 ))
		( T (cons (car poly) (clear (cdr poly))))
	))

(defun o (poly)
	(cond
		( (null poly) NIL)
		( (not (listp (car poly))) (cond
										( (and (numberp (car poly)) (< (car poly) '0)) (cons '- (list (- '0 (car poly)))))
										( T poly))) 
		( (numberp (caar poly)) (cond
									( (= (caar poly) 0) (o (cddr poly)))
									( (= (caar poly) 1) (o (cdr poly)))
									( (= (caar poly) '-1) (cons '- (o (cdr poly))))
									( (< (caar poly) '-1) (cons '- (cons (- '0 (caar poly)) (o (cdr poly)))))
									( T (cons (flatten (car poly)) (o (cdr poly))))
								))
		( (and (symbolp (caar poly)) (numberp (cdar poly))) (cons (caar poly) (cons '^ (cons (cdar poly) (o (cdr poly))))))
	))

(defun out (poly)
	(cond
		( (null poly) NIL)
		( (not (null (cdr poly))) (cons (flatten (o (car poly))) (cons '+ (out (cdr poly)))))
		( T (flatten (o (car poly))))
	))

;----------------------------------------------------------------------------------------------------------------

; Сложение полиномов

(defun removee (poly elem)
  (cond ((null poly) NIL)
        ((equal elem (car poly)) (removee (cdr poly) elem))
        (t (cons (car poly) (removee (cdr poly) elem)))))

(defun memberr (elem poly) 
	(cond 
		( (null poly) NIL)
        ( (equal elem (car poly)) T)
        ( T (memberr elem (cdr poly)))
    ))

(defun equality (poly1 poly2)
 	(cond 
  		( (and (null poly1) (null poly2)) T)
        ( (memberr (car poly1) poly2) (equality (cdr poly1) (removee poly2 (car poly1))))
        ( T NIL)
    ))

(defun check_num (poly)
	(cond
		( (null poly) T)
		( (numberp (car poly)) (check_num (cdr poly)))
		( T NIL)
	))

(defun addd (poly)
	(cond
		( (atom (car poly)) poly)
		( (symbolp (caadr poly)) NIL)
		( T(cons (list (+ (caar poly) (caadr poly))) (cddr poly)))
	))

(defun uni_poly (elem poly)
	(cond 
		( (and (null poly) (symbolp (caadr elem)) (numberp (cdadr elem))) 
				(cond 
					( (= (caar elem) '0) NIL)
					( T	elem)))
		( (null poly) elem)
		( (equality (cdr elem) (cdadr poly)) (uni_poly (addd (cons (car elem) (cons (car (cadr poly)) (cdr elem)))) (cdr poly)))
		( T (uni_poly elem (cdr poly)))
	))

(defun find_used (elem poly)
	(cond
		( (null poly) NIL)
		( (not (equality (cdr elem) (cdadr poly))) (find_used elem (cdr poly)))
		( T  (cons (cadr poly) (find_used elem (cdr poly))))
	))

(defun minus_lst (poly1 poly2)
	(cond 
		( (null poly1) NIL)
        ( (not (memberr (car poly1) poly2)) (cons (car poly1) (minus_lst (cdr poly1) poly2)))
        ( T (minus_lst (cdr poly1) poly2))
    ))

(defun add_poly (poly)
	(cond 
		( (null poly) NIL)
		( (null (cdr poly)) poly)
		( T (cons (uni_poly (car poly) poly) (add_poly (minus_lst (cdr poly) (find_used (car poly) poly)))))
	))

;---------------------------------------------------------------------------------------------------------------

; Приведение внутри одночленов

(defun unused (elem poly)
	(cond
		( (null poly) NIL)
		( (not (equality (list (car elem)) (list (caar poly)))) (cons (car poly) (unused elem (cdr poly))))
		( T (unused elem (cdr poly)))
	))

(defun twins (elem poly)
	(cond 
		( (null poly) NIL)
        ( (eq (car elem) (caar poly)) T)
        ( T (twins elem (cdr poly)))
    ))

(defun find_twins (poly)
	(cond
		( (null poly) NIL)
		( (twins (car poly) (cdr poly)) T)
		( T (find_twins (cdr poly)))
	))

(defun ad (elem poly)
	(cond
		( (null poly) elem)
		( (eq (car elem) (caar poly)) (ad (cons (caar poly) (+ (cdr elem) (cdar poly))) (cdr poly)))
		( T (ad elem (cdr poly)))
	))

(defun maplistt (F p1 p2)
	(cond
		( (null p2) (cond
						( (null p1) NIL)
						( T (list p1))))
		( T (cons (funcall F p1 p2) (maplistt F (car (unused p1 p2)) (cdr (unused p1 p2)))))
	))

(defun adegr (poly)
	(cond
		( (null poly) NIL)
		( (not (find_twins (cdr poly))) poly)
		( T (cons (list (caar poly)) (maplistt 'ad (cadr poly) (cddr poly))))
	))

(defun add (poly)
	(cond
		( (null poly) 0)
  		( T (+ (caar poly) (add (cdr poly))))))

(defun add_degr (num poly)
	(cond
		( (null poly) (list (list (add num))))
		( (and (numberp (caar poly)) (null (cdar poly))) (add_degr (cons (car poly) num) (cdr poly)))
		( T (cons (adegr (car poly)) (add_degr num (cdr poly))))
	))

(defun add_degree (poly) (add_degr NIL poly))
;----------------------------------------------------------------------------------------------------------------

; Перемножение числел в одночленах

(defun mult (poly) (mapcar #'(lambda (x) (apply '* x)) poly))

(defun ch_place (poly p1 p2)
	(cond 
		( (null poly) (cond
					 	  ( (null p1) p2)
					 	  ( (null p2) p1)
					 	  ( T (cons p1 p2))
					  ))
		( (numberp (car poly)) (ch_place (cdr poly) (cons (car poly) p1) p2))
		( T (ch_place (cdr poly) p1 (cons (car poly) p2)))
	))

(defun mm (poly elem p)
	(cond 
		( (null poly) (cons elem NIL))
		( (and (listp (car poly)) (null (cdr poly))) 
							(cond
								( (and (numberp (caar poly)) (minusp (caar poly))) (cons (* (caar poly) (car elem)) NIL))
								( T (cons (car poly) (mm (cdr poly) elem p)))
							))
		( T (cons (car poly) (mm (cdr poly) elem p)))
	))

(defun mult_min (poly) (mm (cdr poly) (car poly) (cdr poly)))

(defun multiii (poly)
	(cond
		( (null poly) NIL)
		( (listp (car poly)) (cond
								( (numberp (caar poly)) (cons (mult (list (car poly))) (cdr poly)))
								( T (cons (list '1) poly))
							  ))
		( T (mult (list poly)))
	))

(defun multiplate (poly) (ch_place (mult_min (multiii (ch_place poly NIL NIL))) NIL NIL))

(defun m (poly)
	(cond 
		( (null poly) NIL)
		( (listp (car poly)) (cons (multiplate (car poly)) (m (cdr poly))))
		( T (cons (car poly) (m (cdr poly))))
	))

;----------------------------------------------------------------------------------------------------------------

; Перевод из (X ^ 2)  в (X . 2)

(defun degree (poly)
	(cond
		( ( null poly) NIL)
		( (and (symbolp (car poly)) (and (not (eq (car poly) '+)) (not (eq (car poly) '-))))
			(if (symbolp (cadr poly))
				(if (eq (cadr poly) '^) 
					(cons (cons (car poly) (caddr poly)) (degree (cdddr poly)))
					(cons (cons (car poly) 1) (degree (cdr poly)))
				)
				(if (numberp (cadr poly))
					(cons (cons (car poly) 1) (degree (cdr poly)))
					(if (listp (cadr poly))
						(cons (cons (car poly) 1) (cons (degree (cadr poly)) (degree (cddr poly))))
						(cons (cons (car poly) 1) (degree (cdr poly)))
					))
			))
		( (listp (car poly)) (cons (degree (car poly)) (degree (cdr poly))))
		( T (cons (car poly) (degree (cdr poly))))
	))

;----------------------------------------------------------------------------------------------------------------

; Раскрытие скобок и закругление одночленов 

(defun del (poly)
	(cond                                          
		( (null (cdr poly)) NIL)                        
		( T (cons (car poly) (del (cdr poly))))
	))

(defun divi (poly)
	(cond
		( (null poly) NIL)
		( T (cons (takee poly) (divi (dropp poly))))
	))

(defun check_rubbish (poly)
	(cond
		( (null poly) NIL)
		( (eq (car poly) NIL) (check_rubbish (cdr poly)))
		( T (cons (car poly) (check_rubbish (cdr poly))))
	))

(defun surround (poly) (check_rubbish (divi poly)))

(defun flatten (poly)
	(cond 
		( (null poly) NIL)
		( (and (listp poly) (symbolp (car poly)) (eq (cadr poly) '^) (numberp (caddr poly)) (null (cdddr poly))) poly)
        ( (atom poly) (cons poly ()))
        ( T (append (flatten (car poly)) (flatten (cdr poly)) )) 
    ))

;----------------------------------------------------------------------------------------------------------------

; Перемножение скобок !!!

(defun findd (poly)
	(cond
		( (null poly) NIL)
		( (or (eq (car poly) '+) (eq (car poly) '-)) T)
		( T (findd (cdr poly)))
	))

(defun check_for_minus_one (poly)
	(cond
		( (null poly) NIL)
		( (numberp (car poly)) (cond
							( (< (car poly) '0) T)
							( T NIL)))
		( T NIL)
	))

(defun check_for_degree (poly) 
	(cond
		( (null poly) NIL)
		( (eq (cadr poly) '^) T)
		( T NIL)
	))

(defun check_for_atom (poly) 
	(cond
		( (null poly) T)
		( (atom (car poly)) (check_for_atom (cdr poly)))
		( T NIL)
	))

(defun check_lst (poly)
	(cond
		( (null poly) T)
		( (and (listp (car poly)) (not (check_for_minus_one (car poly))) (not (check_for_degree (car poly))) (not (check_for_atom (car poly))))  NIL)
		( T (check_lst (cdr poly)))
	))

(defun make_left (p1 p2)
	;(print (list p1 (takee p2)))
	(cond
		( (null p2) NIL)
		( (null (takee p2))  (make_left p1 (dropp p2)))
		( (null (dropp p2)) (cons (list p1 (takee p2)) NIL))
		( T (append (list (list p1 (takee p2))) (list '+) (make_left p1 (dropp p2))))
	))

(defun make_list (p1 p2)
	(cond
		( (null p1) NIL)
		( T (append (make_left (takee p1) p2) (list '+) (make_list (dropp p1) p2)))
	))

(defun opnbr (mnog poly)
	(cond
		( (null poly) mnog)
		( (and (check_lst (car poly)) (findd mnog)) (opnbr (make_left (car poly) mnog) (cdr poly)))
		( (and (check_lst (car poly)) (not (findd (car poly)))) (opnbr (append (car poly) mnog) (cdr poly)))
		( (null mnog) (opnbr (append (opbr (car poly)) mnog) (cdr poly)))
		( T  (opnbr (make_list mnog (opbr (car poly))) (cdr poly)))
	))

(defun opbr (poly)
	(cond
		( (null poly) NIL)
		( (findd poly) (cond 
							( (not (findd (dropp poly))) (cond
								( (check_lst (car (takee poly))) (append (takee poly) (list '+) (opbr (car (dropp poly)))))
								( T (append (opbr (car (takee poly))) (list '+) (opbr (car (dropp poly)))))))
							( T (cond
								( (check_lst (car (takee poly))) (append (takee poly) (list '+) (opbr (dropp poly))))
								( T (append (opbr (car (takee poly))) (list '+) (opbr (dropp poly))))))))
		( (check_lst poly) poly)
		( (equal (caar poly) '(-1)) (opnbr (list '(-1)) (cdar poly)))
		( T (opnbr NIL poly))
	))								

;----------------------------------------------------------------------------------------------------------------

; Расстановка правильных знаков в выражении 

(defun prepass (poly)
	(cond
		( (null poly) NIL)
		( (eq (car poly) '-) (cons '+ (cons '- (prepass (cdr poly)))))
		( T (cons (car poly) (prepass (cdr poly))))
	))

(defun pass (poly)
	(cond
		( (null poly) NIL)
		( (eq (car poly) '+) (cond
								( (eq (cadr poly) '-) (cons '+ (cons (list '(-1) (pass (prepass (caddr poly)))) (pass (cdddr poly)))))
								( T (cons '+ (pass (cdr poly))))
							))
		( (listp (car poly)) (cons  (pass (prepass (car poly))) (pass (cdr poly))))
		( T (cons (car poly) (pass (prepass (cdr poly)))))
	))

(defun cll (poly)
	(cond
		( (null poly) NIL)
		( (eq (car poly) '+) (cdr poly))
		( T poly)
	))

(defun znak (poly) (cll (pass (prepass poly))))

;----------------------------------------------------------------------------------------------------------------

; Создание правильного представления одночленов

(defun cl (p1 p2)
	(cond
		( (null p1) (append p2))
		( T (cons p2 p1))
	))

(defun make_mnog (poly mnog1 mnog2)
	(cond
		( (null poly) (cl mnog2 mnog1))
		( (atom (car poly)) (make_mnog (cdr poly) (cons (car poly) mnog1) mnog2))
		( (listp (car poly)) (cond
								( (and (symbolp (caar poly)) (eq (cadar poly) '^) (numberp (caddar poly)) (null (cdddar poly))) 
										(make_mnog (cdr poly) mnog1 (cons (car poly) mnog2)))
								( T (make_mnog (cdr poly) mnog1 (cons (car poly) mnog2)))))
	))
						
(defun mmnog (poly)
	(cond 
		( (eq (car (make_mnog poly NIL NIL)) NIL) (cdr (make_mnog poly NIL NIL)))
		( T (make_mnog poly NIL NIL))
	))		

;---------------------------------------------------------------------------------------------------------

; Закругление 

(defun delete_end (poly mnog)
	(cond
		( (null poly) (reverse mnog))
		( (and (or (eq (car poly) '+) (eq (car poly) '-)) (not (findd (cdr poly))) (not (null mnog))) (append (reverse mnog) (list (car poly)) (list (cdr poly))))
  		( T (delete_end (cdr poly) (cons (car poly) mnog)))
    ))

(defun preobr (poly)
	(cond
		( (null poly) NIL)
		( (and (listp poly) (findd poly)) (append (delete_end poly NIL)))
		( T poly)
	))

(defun rub (poly)
	(cond
		( (null poly) NIL)
		( (listp (car poly)) (cons (preobr (car poly)) (rub (cdr poly))))
		( T (cons (car poly) (rub (cdr poly))))
	))

(defun del (poly) (delete_end poly NIL))

;---------------------------------------------------------------------------------------------------------

; Степень в скобки

(defun sur_degree (poly)
	(cond 
		( (null poly) NIL)
		( (and (listp (car poly)) (symbolp (caar poly)) (eq (cadar poly) '^) (numberp (caddar poly)) (null (cdddar poly))) (car poly))
		( (atom (car poly)) (cond
								( (and (symbolp (car poly)) (eq (cadr poly) '^) (numberp (caddr poly))) 
										(cons (list (car poly) (cadr poly) (caddr poly)) (sur_degree (cdddr poly))))
								( T (cons (car poly) (sur_degree (cdr poly))))))
		( T (cons (car poly) (sur_degree (cdr poly))))
	))

;---------------------------------------------------------------------------------------------------------

; Взятие в скобки до и после знака + или -

(defun save (poly)
	(cond
		( (null poly) NIL)
		( (or (eq (car poly) '+) (eq (car poly) '-)) (car poly))
		( T (save (cdr poly)))
	))

(defun takee (poly)
	(cond
		( (null poly) NIL)
		( (or (eq (car poly) '+) (eq (car poly) '-)) NIL)
		( T (cons (car poly) (takee (cdr poly))))
	))
 
(defun dropp (poly)
	(cond
		( (null poly) NIL)
		( (or (eq (car poly) '+) (eq (car poly) '-)) (cdr poly))
		( T (dropp (cdr poly)))
	))

;--------------------------------------------------------------------------------------------------------

; Расстановка скобок в выражении

(defun clear_nil (poly)
	(cond
		( (null poly) NIL)
		( (eq (car poly) NIL) (clear_nil (cdr poly)))
		( (listp (car poly)) (cons (clear_nil (car poly)) (clear_nil (cdr poly))))
		( T (cons (car poly) (clear_nil (cdr poly))))
	))

(defun decide (poly)
	(cond
		( (null poly) NIL)
		( (listp (car poly)) (cons (dividee (car poly)) (decide (cdr poly)) ))
		( T (cons (car poly) (decide (cdr poly))))
	))
							
(defun dividee (poly)
	(cond
		( (null poly) NIL)
		( (not (eq (save poly) NIL)) (cons (dividee (takee poly)) (cons (save poly) (dividee (dropp poly)))))
		( (listp poly) (mmnog (rub (sur_degree (decide poly)))))
	))

(defun rema (poly num)
	(cond
		( (= num '0) NIL)
		( T (cons poly (rema poly (- num 1))))
	))

(defun remake (poly)
	(cond
		( (null poly) NIL)
		( (and (listp (car poly)) (eq (cadr poly) '^) (numberp (caddr poly))) (cons (rema (car poly) (caddr poly)) (remake (cdddr poly))))
		( T (cons (car poly) (remake (cdr poly))))
	))

;--------------------------------------------------------------------------------------------------------

(defun main(poly) 
	(final_clear (clear (fin (clear (flatten (out (add_poly (add_degree (m (surround (degree (flatten (opbr (znak (del (clear_nil (dividee (remake poly))))))))))))))))))
	;(clear (fin (clear (flatten (out (add_poly (add_degree (m (surround (degree (flatten (opbr (znak (del (clear_nil (dividee poly))))))))))))))))
	;(opbr (znak (del (clear_nil (dividee poly)))))
)

(print "")
(print "")
;(print "")
;(print (main '(1 - x ^ 2 (x - 1) (x + 1) - 1) ))				 ; (- X ^ 4 + X ^ 2)
;(print "")
;(print (main '(((x + 1) + 2) + 3)))							 ; (X + 6)
;(print "")
;(print (main '(x + 1 (x + 1) + 2 x)))							 ; (4 X + 1)
;(print "")
;(print (main '(x - y + x)))										; (2 X - Y)
;(print "")
;(print (main '(2((x + y + z + w)))))							; (2 X + 2 Y + 2 Z + 2 W) 
;(print "")
;(print (main '(x y z ^ 2 - x y z ^ 2 - 4 (x y) x)))				; (- 4 X ^ 2 Y) 
;(print "")
;(print (main '(x y x 2 z ^ 2 - x ^ 2 x y z 1 1 - 1)))			; (2 X ^ 2 Y Z ^ 2 - Z Y X ^ 3 - 1) 
;(print "")
;(print (main '(( 3 4 5 a ^ 2  - b ^ 2)( a ^ 2 + b ^ 2))))		; (60 A ^ 4 + 59 A ^ 2 B ^ 2 - B ^ 4)
;(print "")
;(print (main '(1 - x ^ 2 (x - 1) (x + 1) - (1 - 2 + (10 - 8)))) )	; (- X ^ 4 + X ^ 2) 
;(print "")
;(print (main '(2 x (x - (2 x + y) 7) 3 - 11 (x + 1) + (x - 2) 3 y))) 	; (- 78 X ^ 2 - 39 X Y - 11 X - 11 - 6 Y)
;(print "")
;(print (main '(- (x - 1))))							; (- X + 1)
;(print "")
;(print (main '(((((((x)))))) ^ 2)))			; (X ^ 2)
;(print "")
;(print (main '((x - 1) ^ 2)))				; (X ^ 2 - 2 x + 1)
;(print "")
;(print (main '( (10 x y + a (5 b - 4 b) 3 a) ( 2 z ( 3 y - 7 y - 6 + 2 y - 2 - 2 y + (5 - 2) 3 (8 + y)) - 3 a ^ 2 b) ) ))
;(print (main '( (10 x y + a (5 b - 4 b) 3 a)(2 x (3 y - 7 y + (5 - 2) 3 (8 + y - 6 + 2 y - 2 - 2 y)) - 3 a ^ 2 b))  ))
;(print (main '( (x ^ 2 - 2 x + 2) (x ^ 2 + 2 x + 2))))
;(print "")
;(print (main '((a - b)(a ^ 2 + a b + b ^ 2))))
;(print (main '((x ^ 2 - y ^ 2)(x ^ 2 + y ^ 2))))
;(print (main '((x - 2 (3 y - 2 y + 5 z - 4 z - z) + y ( 7 + 24 - 6 - 24)) (x + y)) ))
(print (main '( (2 x y x - x ^ 2 y - y x x) (a ^ 2 + b ^ 2))))
(print "")
(print "")






