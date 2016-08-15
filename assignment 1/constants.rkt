;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname constants) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 1.
;; a)
(define distance 
  (+ (abs(- 9 5)) 
     (abs(- 3 6))))
;; b)
(define a 
  (sqrt (- (+ (* 52 52) 
              (* 16 16)) 
           (* 2 52 16 (cos 115)))))
;; c)
(define c 299792458)
(define E (sqrt 
           (+ (* 1 1 c c c c) 
                   (* 0 0 c c))))