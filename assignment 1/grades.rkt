;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 4.
(define (final-cs135-grade final firstmidterm secondmidterm assignment) 
  (+ (* 0.45 final) 
     (* 0.2 assignment) 
     (* 0.1 firstmidterm) 
     (* 0.2 secondmidterm)
     5))
(define (final-cs135-exam-grade-needed firstmidterm secondmidterm assignment) 
  (/ (- 60 
        (+ (* 0.2 assignment) 
              (* 0.1 firstmidterm) 
              (* 0.2 secondmidterm) 
              5)) 
     0.45))