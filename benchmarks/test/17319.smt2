(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1541 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var1004 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1004 null-String)))
(assert (and true (and (> (str.len var1004) 0) (<= 0 0))))
(define-const var3264 Int (charAt/698050440 var1004 0)) ; Statement: $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var381 Int (cast-from-Int-to-Int var3264)) ; Statement: $i1 = (int) $c0 
 ; Statement: if $i1 != 80 goto $z0 = 0 
(assert (not (= var381 80))) ; Cond: $i1 != 80 
(define-const var1192 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var1004=r0, var1541=null_type, var3264=$c0, var381=$i1, var1192=$z0}
; {r0=var1004, null_type=var1541, $c0=var3264, $i1=var381, $z0=var1192}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i1 = (int) $c0;	if $i1 != 80 goto $z0 = 0;	$z0 = 0;	return $z0
;block_num 3