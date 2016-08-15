;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname speed) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 3.
;; a.
(define mile->meter 1609.344)
(define hour->second 3600)
(define (mph->m/s speed) 
  (/ (* speed mile->meter) hour->second))
;; b.
(define meter->smoot (/ 1 1.7018))
(define second->nanocentury (/ 1 3.15576))
(define (mph->S/nc speed) 
  (/ (* (mph->m/s speed) meter->smoot) second->nanocentury))