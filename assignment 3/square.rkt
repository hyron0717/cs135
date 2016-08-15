;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname square) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 3, Question 4
;; HaoJun Luo, 20528243
;;
;; *************************************************


;; 4.
(define-struct line (slope intercept))
;; A line = (make-line Num Num)
;; my-Line-fn: line -> Any
(define (my-line-fn info)
  (... (line-slope info)...
   ... (line-intercpet info)...))

;; Contract: four-square?: Line Line Line Line -> Boolean
;; Purpose: determine whether four lines can make a square.
;; Exapmle:

(check-expect (four-square? (make-line 1 0) (make-line -1 0) (make-line 1 1) (make-line -1 1)) true)
;; Defination:
(define a 0) ;; When a slope of line is undefined, the slope line perpendicular to it is 0.
(define k -1) ;; Multiplying the slope of two lines is equal -1, two lines are perpendicular.

(define (four-square? Line1 Line2 Line3 Line4)
  (cond 
    [(or (and (equal? (line-slope Line1) 'undefined)
              (equal? (line-slope Line2) 'undefined)
              (= (line-slope Line3) a)
              (= (line-slope Line4) a))
           
         (and (equal? (line-slope Line1) 'undefined)
              (equal? (line-slope Line3) 'undefined)
              (= (line-slope Line2) a)
              (= (line-slope Line4) a))
           
         (and (equal? (line-slope Line1) 'undefined)
              (equal? (line-slope Line4) 'undefined)
              (= (line-slope Line2) a)
              (= (line-slope Line3) a))
           
         (and (equal? (line-slope Line2) 'undefined)
              (equal? (line-slope Line3) 'undefined)
              (= (line-slope Line1) a)
              (= (line-slope Line4) a))
           
         (and (equal? (line-slope Line2) 'undefined)
              (equal? (line-slope Line4) 'undefined)
              (= (line-slope Line1) a)
              (= (line-slope Line3) a))
           
         (and (equal? (line-slope Line3) 'undefined)
              (equal? (line-slope Line4) 'undefined)
              (= (line-slope Line1) a)
              (= (line-slope Line2) a)))
     true]
    
    [(or (and (equal? (line-slope Line1) (line-slope Line2)) 
              (equal? (line-slope Line3) (line-slope Line4))
              (equal? (* (line-slope Line1) (line-slope Line3)) k))
         
         (and (equal? (line-slope Line1) (line-slope Line3)) 
              (equal? (line-slope Line2) (line-slope Line4))
              (equal? (* (line-slope Line1) (line-slope Line2)) k))
         
         (and (equal? (line-slope Line1) (line-slope Line4)) 
              (equal? (line-slope Line2) (line-slope Line3))
              (equal? (* (line-slope Line1) (line-slope Line2)) k)))
         true]
    
    [else false]))

;; Test:
(check-expect (four-square? (make-line 1 1) (make-line 1 0) (make-line -1 0) (make-line -1 1)) true)
(check-expect (four-square? (make-line -1 0) (make-line 1 1) (make-line 1 0) (make-line -1 1)) true)
(check-expect (four-square? (make-line 1 0) (make-line 1 1) (make-line -1 0) (make-line -1 1)) true)
(check-expect (four-square? (make-line 'undefined 1) (make-line 'undefined 0) (make-line 0 0) (make-line 0 1)) true)
(check-expect (four-square? (make-line 'undefined 1) (make-line 0 0) (make-line 'undefined 0) (make-line 0 1)) true)
(check-expect (four-square? (make-line 'undefined 1) (make-line 0 0) (make-line 0 0) (make-line 'undefined 1)) true)
(check-expect (four-square? (make-line 0 1) (make-line 'undefined 0) (make-line 'undefined 0) (make-line 0 1)) true)
(check-expect (four-square? (make-line 0 1) (make-line 'undefined 0) (make-line 0 0) (make-line 'undefined 1)) true)
(check-expect (four-square? (make-line 0 1) (make-line 0 0) (make-line 'undefined 0) (make-line 'undefined 1)) true)
(check-expect (four-square? (make-line 'undefined 1) (make-line 'undefined 0) (make-line 1 0) (make-line 0 1)) false)