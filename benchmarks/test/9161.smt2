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

(declare-sort var528 0)
(declare-sort var301 0)
(declare-sort var2581 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2581_hasText/2115555376 (String) Bool)
(declare-const null-var528 var528)
(declare-const null-String String)
(declare-const var3217 var528) ; Statement: r2 := @parameter0: org.springframework.core.AliasRegistry 
(assert (not (= var3217 null-var528)))
(declare-const var1801 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1801 null-String)))
(declare-const var3441 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3441 null-String)))
(define-const var459 Bool (var2581_hasText/2115555376 var1801)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z3 = 0 
(assert (not (= (ite var459 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3749 Bool (var2581_hasText/2115555376 var3441)) ; Statement: $z1 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r1) 
 ; Statement: if $z1 == 0 goto $z3 = 0 
(assert (= (ite var3749 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1061 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {var2581_hasText/2115555376=([java.lang.String], boolean)}
; {var528=org.springframework.core.AliasRegistry, var3217=r2, var1801=r0, var301=null_type, var3441=r1, var2581=org.springframework.util.StringUtils, var459=$z0, var3749=$z1, var1061=$z3}
; {org.springframework.core.AliasRegistry=var528, r2=var3217, r0=var1801, null_type=var301, r1=var3441, org.springframework.util.StringUtils=var2581, $z0=var459, $z1=var3749, $z3=var1061}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>;	<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 2}
;stmts r2 := @parameter0: org.springframework.core.AliasRegistry;	r0 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r0);	if $z0 == 0 goto $z3 = 0;	$z1 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r1);	if $z1 == 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 4