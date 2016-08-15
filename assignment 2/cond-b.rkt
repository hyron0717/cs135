;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cond-b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 1.
;; b.
(define (q1b x)
  (cond [(and (number? x) 
              (or (p2? x) 
                  (p3? x))) 'alfa]
        [(and (number? x) 
              (not (or (p2? x) 
                       (p3? x))) 
              (p3? x)) 'bravo]
        [(and (number? x) 
              (not (or (p2? x) 
                       (p3? x))) 
              (not (p3? x))) 'charlie]
        [(and (symbol? x) 
              (symbol=? x 'delta)) 'echo]
        [(and (symbol? x) 
              (not (symbol=? x 'delta))) 'delta]
        [(not (or (number? x) 
                  (symbol? x))) 'foxtrot]))