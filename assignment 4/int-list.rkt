;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname int-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 4, Question 2
;; HaoJun Luo, 20528243
;;
;; *************************************************

;; 2.
;; a. 

;;a list-of-int is one of :
;; empty
;; (cons Int (list-of-int))

;; my-loi-fn: listof Int -> Any
(define (my-loi-fn loi)
  (cond
    [(empty? loi) ...]
    [else (... (first loi) ...
               (my-loi-fn (rest loi))...)]))

;; Contract:
;; sum-fav: (listof Int) Int -> Int

;; Purpose: find the sum of the elements which greater than or equal to favourite
;; Example:
(check-expect (sum-fav (cons 4 (cons -5 (cons 6 empty))) 4) 10)
(check-expect (sum-fav (cons -7 (cons 8 (cons -9 empty))) 9) 0)
(check-expect (sum-fav empty 2) 0)

;; Definition:
(define (sum-fav list-of-int favourite)
  (cond 
    [(empty? list-of-int) 0]
    
    [else 
     (cond
       [(>= (first list-of-int) favourite) 
        (+ (first list-of-int) 
           (sum-fav (rest list-of-int) favourite))]
       
       [else 
        (sum-fav (rest list-of-int) favourite)])]))

;; Test:
(check-expect (sum-fav (cons 4 (cons 5 (cons 10 empty))) 9) 10)
(check-expect (sum-fav (cons 2 (cons 3 (cons 1 empty))) -1) 6)
(check-expect (sum-fav (cons 15 (cons 2 (cons 3 empty))) 0) 20)


;; b.

;; Contract:
;; reciprocate: (listof Int) -> (listof (Union Num Symbol))

;; Purpose: determine the reciprocals of each integer in the list.
;; Example: 
(check-expect (reciprocate (cons 1 (cons 2 empty))) (cons 1 (cons 0.5 empty)))
(check-expect (reciprocate (cons 0 (cons 1 (cons 2 empty)))) (cons 'undefined (cons 1 (cons 0.5 empty))))
(check-expect (reciprocate empty) empty)

;; Definition:
(define reciprocal-constant 1)

(define (reciprocate list-of-int)
  (cond
    [(empty? list-of-int) empty]
    
    [else 
     (cond
       [(equal? (first list-of-int) 0) 
        (cons 'undefined (reciprocate (rest list-of-int)))]
       
       [else 
        (cons (/ reciprocal-constant 
                 (first list-of-int)) 
              (reciprocate (rest list-of-int)))])]))

;; Test
(check-expect (reciprocate (cons 5 (cons 10 (cons 0 empty)))) (cons 0.2 (cons 0.1 (cons 'undefined empty))))
(check-expect (reciprocate (cons 4 (cons 1 empty))) (cons 0.25 (cons 1 empty)))
(check-expect (reciprocate (cons 1 empty)) (cons 1 empty))

;; c.

;; Contract: 
;; ascending-or-descending?: (listof Int) Symbol -> Boolean

;; Purpose: determine whether the list of integer is ascending or descending.
;; Example:
(check-expect (ascending-or-descending? (cons 1 (cons 2 (cons 3 empty))) 'ascending) true)
(check-expect (ascending-or-descending? (cons -7 (cons -8 (cons -9 empty))) 'descending) true)
(check-expect (ascending-or-descending? empty 'ascending) true)
(check-expect (ascending-or-descending? empty 'descending) true)

;; Definition:
(define constant 1)
(define (ascending-or-descending? list-of-int a-or-d)
  (cond 
    [(empty? list-of-int) true]
    
    [(empty? (rest list-of-int)) true]
    
    [else 
     (cond 
       [(equal? a-or-d 'ascending) 
        (and (= (first list-of-int) 
                (- (first (rest list-of-int)) 
                   constant))
             (ascending-or-descending? (rest list-of-int) a-or-d))]
       
       [(equal? a-or-d 'descending) 
        (and (= (first list-of-int) 
                (+ (first (rest list-of-int)) 
                   constant))
             (ascending-or-descending? (rest list-of-int) a-or-d))])]))
;; Test: 
(check-expect (ascending-or-descending? (cons 1 (cons 2 (cons 5 empty))) 'ascending) false)
(check-expect (ascending-or-descending? (cons 1 empty) 'ascending) true)
(check-expect (ascending-or-descending? (cons 4 (cons 2 (cons 3 empty))) 'descending) false)
(check-expect (ascending-or-descending? (cons 6 (cons 7 (cons 8 empty))) 'ascending) true)
(check-expect (ascending-or-descending? (cons -2 (cons -3 (cons -4 empty))) 'descending) true)
(check-expect (ascending-or-descending? empty 'ascending) true)
