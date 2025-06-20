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

(declare-sort var1528 0)
(declare-sort var663 0)
(declare-sort var2526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2526_hasText/2115555376 (String) Bool)
(declare-const null-var1528 var1528)
(declare-const null-String String)
(declare-const var3165 var1528) ; Statement: r2 := @parameter0: org.springframework.core.AliasRegistry 
(assert (not (= var3165 null-var1528)))
(declare-const var2084 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2084 null-String)))
(declare-const var2573 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var2573 null-String)))
(define-const var3238 Bool (var2526_hasText/2115555376 var2084)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z3 = 0 
(assert (= (ite var3238 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3756 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {var2526_hasText/2115555376=([java.lang.String], boolean)}
; {var1528=org.springframework.core.AliasRegistry, var3165=r2, var2084=r0, var663=null_type, var2573=r1, var2526=org.springframework.util.StringUtils, var3238=$z0, var3756=$z3}
; {org.springframework.core.AliasRegistry=var1528, r2=var3165, r0=var2084, null_type=var663, r1=var2573, org.springframework.util.StringUtils=var2526, $z0=var3238, $z3=var3756}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r2 := @parameter0: org.springframework.core.AliasRegistry;	r0 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r0);	if $z0 == 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 3