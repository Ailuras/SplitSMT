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

(declare-sort var671 0)
(declare-sort var242 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var242_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var922 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var922 null-String)))
(declare-const var3215 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3215 null-String)))
(define-const var2977 Bool (var242_isEmpty/-813097145 var922)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = "*" 
(assert (not (= (ite var2977 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: if r2 != null goto $z3 = 0 
(assert (not (not (= var3215 null-String)))) ; Negate: Cond: r2 != null  
(define-const var3308 Bool (ite (= 1 1) true false)) ; Statement: $z3 = 1 
 ; Statement: goto [?= return $z3] 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {var242_isEmpty/-813097145=([java.lang.String], boolean)}
; {var922=r0, var671=null_type, var3215=r2, var242=org.apache.dubbo.common.utils.StringUtils, var2977=$z0, var3308=$z3}
; {r0=var922, null_type=var671, r2=var3215, org.apache.dubbo.common.utils.StringUtils=var242, $z0=var2977, $z3=var3308}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = "*";	if r2 != null goto $z3 = 0;	$z3 = 1;	goto [?= return $z3];	return $z3
;block_num 4