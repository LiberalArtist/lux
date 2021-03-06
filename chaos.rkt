#lang racket/base
(require racket/contract/base
         racket/generic)

(define-generics chaos
  (chaos-start! chaos)
  (chaos-yield chaos evt)
  (chaos-event chaos)
  (chaos-output! chaos output)
  (chaos-label! chaos label)
  (chaos-swap! chaos thunk)
  (chaos-stop! chaos)
  #:fallbacks
  [(define (chaos-start! c)
     (void))
   (define (chaos-yield c e)
     (sync e))
   (define (chaos-event c)
     never-evt)
   (define (chaos-output! c o)
     (void))
   (define (chaos-label! c l)
     (void))
   (define (chaos-swap! chaos thunk)
     (thunk))
   (define (chaos-stop! c)
     (void))])

(provide
 gen:chaos
 (contract-out
  [chaos? (-> any/c boolean?)]
  [chaos-start! (-> chaos? any)]
  [chaos-yield (-> chaos? evt? any)]
  [chaos-event (-> chaos? evt?)]
  [chaos-output! (-> chaos? any/c any)]
  [chaos-label! (-> chaos? string? any)]
  [chaos-swap! (-> chaos? (-> any) any)]
  [chaos-stop! (-> chaos? any)]))
