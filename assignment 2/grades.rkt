;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 3.
;; a.
;; Contract: Int Int Int -> Int
;; Purpose: determine the participation mark
;; Example:
(check-expect (participation-mark 100 25 25) 50)
(check-expect (participation-mark 32 24 0) 100)
;; Defination:
(define (participation-mark a b c)
  (cond [(>= b (* a 0.75)) 100]
        [else (cond [(< (+ b c) 
                        (* a 0.75)) 
                     (* (/ (+ (* b 2) 
                              (* c 1)) 
                           (* a 2 0.75)) 
                        100)]
                    [else (* (/ (+ (* b 2) 
                                   (* (- (* a 0.75) b) 1)) 
                                (* a 2 0.75)) 
                             100)])]))
;; Test: 
(check-expect (participation-mark 100 0 0) 0)
(check-expect (participation-mark 50 50 0) 100)
(check-expect (participation-mark 100 51 49) 84)

;; b.
;; Contract: Num Num Num Num Num -> Num
;; Purpose: determine the final mark
;; Example:
(check-expect (final-cs135-grade 100 50 50 50 20) 71)
(check-expect (final-cs135-grade 60 50 50 30 20) 46)
;; Defination:
(define (final-cs135-grade final firstmidterm secondmidterm assignment participation) 
  (cond [(and (or (< assignment 50) (< (/ (+ (* 0.45 final) 
                                             (* 0.1 firstmidterm) 
                                             (* 0.2 secondmidterm)) 0.75) 50)) (< (+ (* 0.45 final) 
                                                                                     (* 0.2 assignment) 
                                                                                     (* 0.1 firstmidterm) 
                                                                                     (* 0.2 secondmidterm) 
                                                                                     (* 0.05 participation)) 46))
         (+ (* 0.45 final) 
            (* 0.2 assignment) 
            (* 0.1 firstmidterm) 
            (* 0.2 secondmidterm) 
            (* 0.05 participation))]
        
        [(and (or (< assignment 50) (< (/ (+ (* 0.45 final) 
                                             (* 0.1 firstmidterm) 
                                             (* 0.2 secondmidterm)) 0.75) 50)) (> (+ (* 0.45 final) 
                                                                                     (* 0.2 assignment) 
                                                                                     (* 0.1 firstmidterm) 
                                                                                     (* 0.2 secondmidterm) 
                                                                                     (* 0.05 participation)) 46)) 46]
        [else (+ (* 0.45 final) 
                 (* 0.2 assignment) 
                 (* 0.1 firstmidterm) 
                 (* 0.2 secondmidterm) 
                 (* 0.05 participation))]))
;; Test:
(check-expect (final-cs135-grade 100 80 80 20 100) 46)
(check-expect (final-cs135-grade 50 50 50 50 20) 48.5)
(check-expect (final-cs135-grade 30 30 50 80 100) 46)
