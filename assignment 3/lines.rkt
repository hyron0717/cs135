;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lines) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 3, Question 2
;; HaoJun Luo, 20528243
;;
;; *************************************************


;; 2.
;; a.
(define-struct line (slope intercept))
;; A line = (make-line Num Num)
;; my-Line-fn: Line -> Any
(define (my-line-fn info)
  (... (line-slope info)...
   ... (line-intercpet info)...))



;; b.
;; Contract: two-point->Line: Posn Posn -> Line
;; Purpose: Determine a line by two points.

;; Example:
(check-expect (two-points->Line (make-posn 1 1) (make-posn 0 0)) (make-line 1 0))
(check-expect (two-points->Line (make-posn 1 3) (make-posn 2 5)) (make-line 2 1))

;; Defination:
(define (two-points->Line firstpoint secondpoint)
  (cond [(= (- (posn-x secondpoint) 
               (posn-x firstpoint)) 0) 
         (make-line 'undefined (posn-x firstpoint))]
        
        [else (make-line 
               (/ (- (posn-y secondpoint) 
                     (posn-y firstpoint)) 
                  (- (posn-x secondpoint) 
                     (posn-x firstpoint)))
               
               (- (posn-y firstpoint) 
                  (* (/ (- (posn-y secondpoint) 
                           (posn-y firstpoint)) 
                        (- (posn-x secondpoint) 
                           (posn-x firstpoint)))
                     (posn-x firstpoint))))]))

;;Test:
(check-expect (two-points->Line (make-posn 2 2) (make-posn 0 0)) (make-line 1 0))
(check-expect (two-points->Line (make-posn 2 5) (make-posn 1 2)) (make-line 3 -1))
(check-expect (two-points->Line (make-posn 2 1) (make-posn 2 5)) (make-line 'undefined 2))


;; c.
;; Contract: perp-Line: Posn line -> line
;; Purpose: Determine a line is perpendicular to the given line and go thought the given point.
;; Example:
(check-expect (perp-Line (make-posn 0 2) (make-line 1 0)) (make-line -1 2))

;; Defination:
(define (perp-Line GivenPoint GivenLine)
  (cond [(= (line-slope GivenLine) 0) 
         (make-line 'undefined (posn-y GivenPoint))]
        
        [else (make-line
               (/ -1 (line-slope GivenLine))
               
               (- (posn-y GivenPoint) 
                  (* (/ -1 (line-slope GivenLine))
                     (posn-x GivenPoint))))]))

;; Test:
(check-expect (perp-Line (make-posn 0 2) (make-line 0 2)) (make-line 'undefined 2))
(check-expect (perp-Line (make-posn 1 3) (make-line 1 0)) (make-line -1 4))
