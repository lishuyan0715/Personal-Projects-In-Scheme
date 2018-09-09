;; Lab 3: Heuristic Search
;; CSC 261 
;;
;; File
;;   heuristic.scm
;;
;; Summary
;;   Heuristics for the A* algorithm
;;
;; Provides
;;   jump-heuristic
;;   max-jumps-heuristic

(require "problem.scm")
(require "jump.scm")
(require "node.scm")

;; Procedure
;;  jump-heuristic
;;
;; Purpose
;;   count the steps assuming the agent takes maximum number of steps
;;   till step x_0 where decreasing the step size by 1 every subsequent
;;   step leads to the N-1 position.
;;
;; Parameters
;;   state, a value
;;
;; Produces
;;   heur-val, a numeric
;;
;; Preconditions
;;   state is of the form (list course-length position momentum)
;;
;; Postconditions
;;   See a-star-heuristic.pdf for derivation of the heuristic
(define jump-heuristic
  (lambda (state)
    (let* ([m (caddr state)]
           [length (- (car state) 1 (cadr state))] 
           [a 3]
           [b (+ 6 (* 3 m))]
           [c (+ -1 (* -1 length) (/ (expt m 2) 2) (/ m 2))]
           [root (/ (+ (* -1 b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a))])
      (floor (+ m 1 (* 2 root))))))

;; Procedure
;;  max-jumps-heuristic
;;
;; Purpose
;;   count the number of steps assuming that each subsequent step is the
;;   smallest jump size possible till N-1
;;
;; Parameters
;;   state, a value
;;
;; Produces
;;   heur-val, a numeric
;;
;; Preconditions
;;   state is of the form (list course-length position momentum)
;;
;; Postconditions
;;   heur-val = max(m-1,1) + length-(m*(m+1))/2
(define max-jumps-heuristic
  (lambda (state)
    (let
        ([length (- (car state) 2 (cadr state))]
         [m (caddr state)])
      ;; remaining steps from p
      (+ (max (- m 1) 1) ;; smallest number of steps to get to momentum 1
         ;; number of steps left
         (- length (/ (- (expt m 2) m) 2))))))
