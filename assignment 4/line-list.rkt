;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname line-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 4, Question 3
;; HaoJun Luo, 20528243
;;
;; *************************************************

;; 3.
;; a.
(define-struct line (slope intercept))
;; A line = (make-line (Union Num Symbol) Num)
;; my-Line-fn: Line -> Any
(define (my-line-fn info)
  (... (line-slope info)...
       (line-intercept info)...))

;; a list-of-line is one of :
;; empty
;; (cons Line (list-of-line))

;; Template:
;; my-lol-fn: listof Line -> Any
(define (my-lol-fn lol)
  (cond
    [(empty? lol) ...]
    [else (...(first lol) ...
              (my-lol-fn (rest lol)) ...)]))

;; b.
;; Contract: 
;; negate-slope: (listof Line) -> (listof Line)

;; Purpose: negate the slope of lines in the list.
;; Example: 
(check-expect (negate-slope (cons (make-line 1 0) 
                                  (cons (make-line -1 0) empty)))
              (cons (make-line -1 0) 
                    (cons (make-line 1 0) empty)))
(check-expect (negate-slope empty) empty)

;; Definition: 
(define (negate-slope lines)
  (cond
    [(empty? lines) empty]
    
    [else 
     (cond
       [(equal? (line-slope (first lines)) 'undefined)
        (cons (first lines)
              (negate-slope (rest lines)))]
       
       [else 
        (cons 
         (make-line (- (line-slope (first lines))) 
                    (line-intercept (first lines)))
         (negate-slope (rest lines)))])]))

;; Test:
(check-expect (negate-slope (cons (make-line 'undefined 0) 
                                  (cons (make-line -1 0) empty)))
              (cons (make-line 'undefined 0) 
                    (cons (make-line 1 0) empty)))
(check-expect (negate-slope (cons (make-line 'undefined 0) 
                                  (cons (make-line -1 0) 
                                        (cons (make-line 0 1) empty))))
              (cons (make-line 'undefined 0) 
                    (cons (make-line 1 0) 
                          (cons (make-line 0 1) empty))))

;; c.
;; Contract: 
;; positive-line : (listof Line) -> (listof Line)

;; Purpose: list the lines with positive slope or positive intercept.
;; Example: 
(check-expect (positive-line (cons (make-line 2 1)
                                   (cons (make-line -1 -2) empty)))
              (cons (make-line 2 1)  empty))
(check-expect (positive-line empty) empty)

;; Definition: 
(define (positive-line lines)
  (cond
    [(empty? lines) empty]
    
    [else
     (cond
       [(equal? (line-slope (first lines))
                'undefined)
        (cond
          [(> (line-intercept (first lines)) 0)
           (cons (first lines) (positive-line (rest lines)))]
          [else (positive-line (rest lines))])]
       
       [(or (> (line-intercept (first lines)) 0)
            (> (line-slope (first lines)) 0))
        (cons (first lines) (positive-line (rest lines)))]
       
       [else (positive-line (rest lines))])]))

;; Test: 
(check-expect (positive-line (cons (make-line -1 0)
                                   (cons (make-line -1 -2) empty)))
              empty)
(check-expect (positive-line (cons (make-line 'undefined -1)
                                   (cons (make-line 0 -2) empty)))
              empty)
(check-expect (positive-line (cons (make-line 'undefined 2)
                                   (cons (make-line 0 -2) empty)))
              (cons (make-line 'undefined 2) empty))

;; d.
;; Contract:
;; through-point: (listof Line) Posn -> (listof Line)

;; Purpose: determine which lines are through the given point.
;; Example: 
(check-expect (through-point (cons (make-line 0 3) 
                                   (cons (make-line 'undefined -4) empty))
                             (make-posn -4 3))
              (cons (make-line 0 3) 
                    (cons (make-line 'undefined -4) empty)))
(check-expect (through-point empty (make-posn 1 1)) empty)

;; Definition:
(define (through-point lines point)
  (cond
    [(empty? lines) empty]
    
    [else 
     
     (cond
       [(and (equal? (line-slope (first lines)) 
                     'undefined)
             (= (posn-x point) 
                (line-intercept (first lines))))
        (cons (first lines) (through-point (rest lines) point))]
       
       [(= (+ (* (posn-x point) 
                 (line-slope (first lines))) 
              (line-intercept (first lines)))
           (posn-y point))
        (cons (first lines) (through-point (rest lines) point))]
       
       [else (through-point (rest lines) point)])]))

;; Test
(check-expect (through-point (cons (make-line 2 3) 
                                   (cons (make-line 'undefined -4) empty))
                             (make-posn -4 3)) 
              (cons (make-line 'undefined -4) empty))

(check-expect (through-point (cons (make-line 2 3) 
                                   (cons (make-line 2 -4) empty))
                             (make-posn -4 3)) 
              empty)

;; e.
;; Contract: 
;; parallel-non-intersect-lines: (listof Line) -> (listof Boolean)

;; Purpose: determine whether the consecutive pair of lines is parallel.
;; Example:
(check-expect (parallel-non-intersect-lines (cons (make-line 2 3) 
                                                  (cons (make-line 2 -4) 
                                                        (cons (make-line 3 -4) empty))))
              (cons true (cons false empty)))
(check-expect (parallel-non-intersect-lines (cons (make-line 2 3) empty)) empty)

;; Definition: 
(define (parallel-non-intersect-lines list-of-line)
  (cond
    
    [(empty? (rest list-of-line)) empty]
    
    [else (cons
           (cond
             
             [(equal? (line-slope (first list-of-line)) 
                      (line-slope (first (rest list-of-line))))
              
              (not (= (line-intercept (first list-of-line)) 
                      (line-intercept (first (rest list-of-line)))))]
             
             [else false])
           
           (parallel-non-intersect-lines (rest list-of-line)))]))
;; Test:
(check-expect (parallel-non-intersect-lines (cons (make-line 2 3) 
                                                  (cons (make-line 2 3) 
                                                        (cons (make-line 3 -4) empty))))
              (cons false (cons false empty)))
(check-expect (parallel-non-intersect-lines (cons (make-line 2 5) 
                                                  (cons (make-line 2 3) 
                                                        (cons (make-line 2 4) empty))))
                                            (cons true (cons true empty)))