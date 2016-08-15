;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname alfs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; check list
(define list-1 (list (make-posn 5 6)
                     (make-posn 7 8)
                     (make-posn 9 10)))

(define list-2 '(1
                 'one
                 "one"))

(define list-3 '((5 6)
                 (7 8)
                 (9 10)))

;; a.
;; Contrast:
;; x-coords-of-posns: (listof Any) -> (listof Any)

;; Purpose: Consumes a list of anything, then produce the x-coordinates of the Posns in the list.
;; Example:
(check-expect (x-coords-of-posns empty) empty)
(check-expect (x-coords-of-posns list-1) '(5 7 9))

;; Definition:
(define (x-coords-of-posns loa)
  (map 
   (lambda (x)
     (posn-x x))
   (filter posn? loa)))

;; Test:
(check-expect (x-coords-of-posns 
               (list (make-posn 1 2) 2 (make-posn 3 4))) 
              (list 1 3))

(check-expect (x-coords-of-posns list-2) empty)

;; b.
;; Contrast:
;; alternating-sum: (listof Num) -> Num

;; Purpose: Consumes a list of numbers and produces the alternating sum.
;; Example:
(check-expect (alternating-sum empty) 0)
(check-expect (alternating-sum '(1 2 3)) 2)

;; Definition:
(define (alternating-sum lon)
  (cond
    [(empty? lon) 0]
    [else
     (- (first lon) 
        (foldr - 0 (rest lon)))]))

;; Test:
(check-expect (alternating-sum '(1 2 3 4 5 6)) -3)
(check-expect (alternating-sum '(6 5 4 3 2 1)) 3)



;; c. 
;; Contrast:
;; remove-duplicates: (listof Num) -> (listof Num)

;; Purpose: Consumes a list of numbers, then produces the list with all but
;;          removed the repeated number.
;; Example:
(check-expect (remove-duplicates empty) empty)
(check-expect (remove-duplicates '(1 2 3)) '(1 2 3))

;; Definition:
(define (remove-duplicates lon)
  (foldr
   (lambda (x y)
     (cons x 
           (filter 
            (lambda (a)
              (not (= a x))) y)))
   empty lon))

;; Test:
(check-expect (remove-duplicates '(1 4 2 1 5 2 4)) '(1 4 2 5))
(check-expect (remove-duplicates '(1 6 8 1 2 6 9)) '(1 6 8 2 9))


;; d. 
;; Contrast:
;; first-col: (listof (ne-listof Num)) -> (listof Num)

;; Purpose: Consumes a (listof (ne-listof Num)), denoting a rectangular matrix of numbers, 
;;          and produces the list of first column of the matrix.
;; Example: 
(check-expect (first-col '((1))) '(1))
(check-expect (first-col '((1 2 3))) '(1))

;; Definition:
(define (first-col lolon)
  (map first lolon))

;; Test:
(check-expect (first-col '((1 2 3 4) 
                           (5 6 7 8) 
                           (9 10 11 12))) 
              (list 1 5 9))

(check-expect (first-col '((1) 
                           (4 5 6) 
                           (5 6))) 
              (list 1 4 5))

;; e.
;; Contrast:
;; add1-mat: (listof (listof Num)) -> (listof Num)

;; Purpose: Consumes a (listof (listof Num)), denoting a rectangular matrix of numbers, 
;;          and produces the matrix whcih every elements added 1.
;; Example:
(check-expect (add1-mat empty) empty)
(check-expect (add1-mat '((1 2 3))) '((2 3 4)))

;; Definition:
(define (add1-mat lolon)
  (map 
   (lambda (x) 
     (map add1 x)) 
   lolon))

;; Test:
(check-expect (add1-mat '((1 2 3 4) 
                          (5 6 7 8) 
                          (9 10 11 12)))
              '((2 3 4 5) 
                (6 7 8 9) 
                (10 11 12 13)))

(check-expect (add1-mat list-3) 
              '((6 7)
                (8 9)
                (10 11)))

;; f.
;; Contrast:
;; sum-at-zero: (listof (X -> Y)) -> Num

;; Purpose: consumes a list of functions (f1,...,fn), and produces the value add up all functions.
;; Example:
(check-expect (sum-at-zero empty) 0)
(check-expect (sum-at-zero (list add1)) 1)

;; Definition:
(define (sum-at-zero lof)
  (foldr + 0 
         (map 
          (lambda (x) (x 0)) lof))) 

;; Test:
(check-expect (sum-at-zero (list add1 sqr add1)) 2)
(check-expect (sum-at-zero (list sub1 sqr add1 sqr)) 0)