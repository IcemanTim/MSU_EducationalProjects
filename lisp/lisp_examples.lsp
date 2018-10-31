(defun removelast (l)
    (cond ((null l)l)
          ((null (cdr l)) ())
          ((cons (car l) (removelast (cdr l))))))


(defun p() '(((5)A)()))
(RemoveLast '(()))

---------------------------------------------------

(defun onelevel (l)
    (cond ((null l)T)
          ((and (atom (car l)) (onelevel (cdr l))))))


(defun p() '(a (b) c))
(onelevel (p))

---------------------------------------------------

(defun bubl (n a)
    (cond ((= n 0)a)
          ((list (bubl (- n 1) a)))))


(defun p() '(a (b) c))
(bubl 1 5)

---------------------------------------------------

(defun lastatom (l)
    (cond ((atom l)l)
          ((null (cdr l)) (lastatom(car l)))
          ((lastatom (cdr l)))))


(defun p() '(((5)A)()))

(lastatom (p))

---------------------------------------------------

(defun elem (n l)
    (cond ((null l)nil)
          ((= n 1)(car l))
          ((elem (- n 1)(cdr l)))))

(defun p() '(a (a b) (a (b b b))))

(elem 4 (p))

---------------------------------------------------

(defun pos (x l n)
    (cond ((null l)0)
          ((equal (car l) x)(+ n 1))
          (T(pos x (cdr l) (+ n 1)))))

(defun posit (x l) (pos x l 0))

(defun s() '(a))
(defun p() '(a (a b)))

(posit (s) (p))

---------------------------------------------------

(defun rightbr (l)
    (cond ((null l) ())
          ((null (cdr l)) (list (car l)))
          (T(list (car l) (rightbr (cdr l))))))
(defun p() '(a b c))

(rightbr (p))

---------------------------------------------------

(defun leftbr (l)
    (cond ((null (cdr l))l)
          ((leftbr (cons (list (car l) (cadr l)) (cddr l))))))


(defun p() '(a b c))

(leftbr (p))

---------------------------------------------------

(defun revbr (l) (leftbr (reverse l)))

(defun leftbr (l)
    (cond ((null (cdr l))l)
          ((leftbr (cons (list (car l) (cadr l)) (cddr l))))))


(defun p() '(a b c))

(revbr (p))

---------------------------------------------------

(defun fact (n)
    (cond ((= n 0)())
          ((= n 1)(cons n (fact (- n 1))))
          ((cons n (cons '* (fact (- n 1)))))))


(defun p() '2)

(fact (p))

---------------------------------------------------

(defun makeset (l) (mkset l ()))
(defun mkset (l x)
    (cond ((null l)x)
          ((member (car l) x)(mkset (cdr l) x))
          ((mkset (cdr l)(cons (car l) x)))))


(defun p() '(a b c b c d))

(makeset (p))

---------------------------------------------------

(defun mix1 (l x)
    (cond ((null l)x)
          ((null x)l)
          ((append (list (car l) (car x)) (mix1 (cdr l) (cdr x))))))


(defun p() '())
(defun q() '())

(mix1 (p) (q))

---------------------------------------------------

(defun mix2(l1 l2) (
  cond((< (length l1) (length l2))(mix2 l2 l1))
      (T (mix l1 l2 ()))))

(defun mix(l1 l2 l3) (
  cond((null l2) l3)
      (T(mix (cdr l1)(cdr l2)(cons l3 (cons l1 l2))))))

---------------------------------------------------

(defun substt (a l e)
    (cond ((atom l)(cond ((equal l a)e)
                         (l)))
          ((cons (substt a (car l) e)(substt a (cdr l) e)))))


(defun p() '(((A (5) 8) B (K))(G (C))))
(defun q() '())

(substt 'Q '(Q (B (Q)) C ((Q) 8)) '(A Z))

---------------------------------------------------

(defun onlyz (l)
    (cond ((atom l)(cond ((eql l 'z)T)
                         ((null l)T)
                         (nil)))
          ((and (onlyz (car l))(onlyz (cdr l))))))


(defun p() '(((Z (Z) z) z (z))(z ())))
(defun q() '())

(onlyz (p))

---------------------------------------------------

(defun transs (n S)
    (cond ((null S) S)
          ((= n 0)(cond ((atom S)S)
                        (1)))
          ((cons (transs (- n 1)(car S))(transs n (cdr S))))))


(defun p() '(((Z (Z) z) z (z))(z ())))
(defun q() '())

(transs 2 '(((A(5)8)B(K))(G(C))))

---------------------------------------------------

(defun level (n S)
    (cond ((null S) S)
          ((= n 0)S)
          ((atom (car S))(level n (cdr S)))
          ((cons (level (- n 1)(car S))(level n (cdr S))))))


(defun p() '(((Z (Z) z) z (z))(z ())))
(defun q() '())

(Level 2 '(((A (5) 8) B) 7 (G (()))))

---------------------------------------------------

(defun mix2(l1 l2) (
  cond((< (length l1) (length l2))(mix2 l2 l1))
      (T (mix l1 l2 ()))))

(defun mix(l1 l2 l3) (
  cond((null l2) l3)
      (T(mix (cdr l1)(cdr l2)(cons l3 (cons l1 l2))))))

---------------------------------------------------

(defun eeq(l) (eeeq (cdr l) (car l)))

(defun eeeq(l x)
    (cond ((null x)nil)
          ((null l)T)
          ((eq (car l) x)(eeeq (cdr l) x))))

(eeq '(a a a))

---------------------------------------------------

(defun vstavka(l) (vst l ()))
(defun vst(l x)
    (cond ((null l)x)
          (T(vst (cdr l) (vs (car l) x)))))

(defun vs(a x)
    (cond ((null x)(list a))
          ((> a (car x))(cons (car x) (vs a (cdr x))))
          (T(append (list a (car x)) (cdr x)))))

(vstavka '(9  5 6 1 4 5 2 3 7 ))

---------------------------------------------------

(defun znch(l)
    (cond ((null l)nil)
          ((> (car l) 0) (znnch (cdr l) 1))
          ((< (car l) 0) (znnch (cdr l) -1))))

(defun znnch(l z)
    (cond ((null l)T)
          ((and (>= z 0) (>= (car l) 0))nil)
          ((and (<= z 0) (<= (car l) 0))nil)
          (T(znnch (cdr l) (- 0 z)))))
(znch '(-1 -1 -1))

---------------------------------------------------

(defun copyatom(a x)
    (cond ((<= x 0)())
          (T(cons a (copyatom a (- x 1))))))

(copyatom '() 4)

---------------------------------------------------

(defun ch(l) (chet (length l)))

(defun chet(x)
    (cond ((= x 0)T)
          ((= x 1)nil)
          (T(chet (- x 2)))))

(ch '(a a a a) )

---------------------------------------------------

(defun newlist (l)
    (cond ((null l)())
          ((null (cadr l))(list (car l)))
          ((null (caddr l))(list (+ (car l)(cadr l))))
          (T(cons (+ (+ (caddr l) (cadr l)) (car l)) (newlist (cdddr l))))))
(newlist '(1 2 3 4 5 6 7 8 9) )

---------------------------------------------------

(defun newlist(l)
    (cond ((null l)())
          ((null (cadr l))l)
          (T(cons (max (car l)(cadr l)) (newlist (cddr l))))))

(newlist '(1 2 3 4 5 6 7 8 9) )

---------------------------------------------------

(defun allsumm(S)
    (cond ((numberp S)S)
          ((atom S)0)
          (T(+ (allsumm (car S)) (allsumm (cdr S))))))

(allsumm '((1 . ( 1 . ( 1 . a ))) . (1 . ( 1 . ( 1 . a )))) )

---------------------------------------------------

(defun insatom(a l)
    (cond ((null l)())
          (T(cons (cons a (car l))(insatom a (cdr l))))))

(insAtom '7 '(()()()))

---------------------------------------------------

(defun repdep(l) (repd l 0))
(defun repd(l x)
    (cond ((null l)())
          ((atom l)x)
          (T(cons (repd (car l)(+ x 1)) (repd (cdr l)x)))))

(repDep '(((A (5) 8) B (K)) H (G (C))))

---------------------------------------------------

(defun check(x) (
    cond((atom x) nil)
        ((and (atom (cdr x)) (atom (car x))) (null (cdr x)))
        ((atom (car x)) (check (cdr x)))
        ((atom (cdr x)) (and (null (cdr x)) (check (car x))))
        (T (and (check (car x)) (check (cdr x))))))

(defun t() 'a)

(check (t))


