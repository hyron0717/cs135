;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname composite) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; a.
;; Contrast:
;; composite: (Num -> Num) (Num -> Num) -> Num

;; Purpose: Consumes two functions f and g and produces a composite function.
;; Example:
(check-expect ((composite add1 abs) 1) 2)
(check-expect ((composite add1 abs) -1) 2)

;; Definition:
(define (composite f g)
  (lambda (x) (f (g x))))

;; Test:
(check-expect ((composite sub1 add1) 1) 1)
(check-expect ((composite add1 add1) 1) 3)

;; b.
;; Contrast:
;; inverse-of-square-list: (listof Num) -> (listof Num)

;; Purpose: Consumes a list of positive number then produce the list of the inverse of the square.
;; Example:
(check-expect (inverse-of-square-list empty) empty)
(check-expect (inverse-of-square-list '(1)) '(1))

;; Definition:
(define (inverse-of-square-list lon)
  (map (composite / sqr)
       lon))

;; Test:
(check-expect (inverse-of-square-list '(1 2 5))  '(1 0.25 0.04))
(check-expect (inverse-of-square-list '(1 2 10))  '(1 0.25 0.01))

;; c.
;; Contrast:
;; composite-list: (listof (Num -> Num)) -> (Num -> Num)

;; Purpose: Consumes list of functions and produces a composite function.
;; Example:
(check-expect ((composite-list empty) 1) 1)
(check-expect ((composite-list (list / sqr abs)) 2) 0.25)
;; Definition:
(define (composite-list lof)
  (lambda (a) 
    (foldr 
     (lambda (x y) 
       (cond 
         [(empty? lof) empty]
         [else ((first lof) ((second lof) a))]))
     a
     lof)))

;; Test:
(check-expect ((composite-list (list add1 abs)) 1) 2)
(check-expect ((composite-list (list add1 add1 abs)) 1) 3)