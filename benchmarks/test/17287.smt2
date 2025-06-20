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

(declare-sort var2918 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var3920 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3920 null-String)))
(assert (and true (and (> (str.len var3920) 0) (<= 0 0))))
(define-const var2371 Int (charAt/698050440 var3920 0)) ; Statement: $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var405 Int (cast-from-Int-to-Int var2371)) ; Statement: $i1 = (int) $c0 
 ; Statement: if $i1 != 80 goto $z0 = 0 
(assert (not (not (= var405 80)))) ; Negate: Cond: $i1 != 80  
(define-const var1261 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= return $z0] 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var3920=r0, var2918=null_type, var2371=$c0, var405=$i1, var1261=$z0}
; {r0=var3920, null_type=var2918, $c0=var2371, $i1=var405, $z0=var1261}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i1 = (int) $c0;	if $i1 != 80 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 3