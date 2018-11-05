#--------------------------------------------------------------------

;;Определить reverse через свертки можно таким образом:

(define (reverse sequence) 
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define (reverse sequence) 
  (fold-left (lambda (x y) (cons y x)) nil sequence))

#--------------------------------------------------------------------

;; Продолжение может быть использовано для эмуляции поведения return выражений 
;; в императивных языках программирования. Функция find-first, данная функция 
;; func и список lst, возвращает элемент x в lst так же как (func x) возвращает 
;; true.

(define (find-first func lst)
  (call-with-current-continuation
   (lambda (return-immediately)
     (for-each (lambda (x)
		 (if (func x)
		     (return-immediately x)))
	       lst)
     #f)))

(find-first integer? '(1/2 3/4 5.6 7 8/9 10 11)) === > 7

(find-first zero? '(1 2 3 4)) === > #f

#--------------------------------------------------------------------

;;Общее пространство имен для процедур и переменных
;; Variable bound to a number:
(define f 10)
f
=== > 10
;; Mutation (altering the bound value)
(set! f (+ f f 6))
f
=== > 26
;; Assigning a procedure to the same variable:
(set! f (lambda (n) (+ n 12)))
(f 6)
=== > 18
;; Assigning the result of an expression to the same variable:
(set! f (f 1))
f
=== > 13
;; functional programming:
(apply + '(1 2 3 4 5 6))
=== > 21
(set! f (lambda (n) (+ n 100)))
(map f '(1 2 3))
=== > (101 102 103)

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------

#--------------------------------------------------------------------
v
