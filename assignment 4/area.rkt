;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname area) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 4, Question 4
;; HaoJun Luo, 20528243
;;
;; *************************************************


(define point1 (make-posn 0 1))
(define point2 (make-posn 1 1))
(define point3 (make-posn 1 0))
(define point4 (make-posn 0 0))


;; Contract:
;; copy-first-to-end: listof Posn -> listof Posn
;; Purpose: add the first element to the end.
;; Example:
(check-expect (copy-first-to-end (cons point1
                                       (cons point2 empty)))
             (cons point1
                    (cons point2
                          (cons point1 empty))))

;; Definition:
(define (copy-first-to-end list-of-posn)
  (cond
    [(empty? list-of-posn) empty]
    [else (append list-of-posn (cons (first list-of-posn) empty))]))

;; Test:
(check-expect (copy-first-to-end (cons point1
                                       (cons point2
                                             (cons point3 empty))))
              (cons point1
                    (cons point2
                          (cons point3
                                (cons point1 empty)))))
              
;; Contract: 
;; area-of-polygon: listof Posn -> Num
;; Purpose: calculate the area of polygon.
;; Example:
(check-expect (area-of-polygon (cons point1
                                     (cons point2
                                           (cons point3
                                                 (cons point4 empty))))) -1)

;; Definition:
(define (area-of-polygon list-of-point)
  (cond
    [(empty? (copy-first-to-end list-of-point)) 0]
    [else (+ (* 0.5 
                (- (* (posn-x (first (copy-first-to-end list-of-point)))
                      (posn-y (second (copy-first-to-end list-of-point))))
                   (* (posn-y (first (copy-first-to-end list-of-point)))
                      (posn-x (second (copy-first-to-end list-of-point))))))
             (area-of-polygon (rest list-of-point)))]))

;; Test: 

(check-expect (area-of-polygon (cons point1
                                     (cons point2
                                          (cons point3 empty)))) -1)
             
             



              