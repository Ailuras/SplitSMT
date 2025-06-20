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

(declare-sort var1483 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var1483) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1483 var1483)
(declare-const var2084 var1483) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2084 null-var1483)))
(assert true)
(define-const var3218 String (getName/1227988463 var2084)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2023 Bool (startsWith/-1785782452 var3218 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 != 0 goto $r2 = "get" 
(assert (not (not (= (ite var2023 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var1045 Bool (startsWith/-1785782452 var3218 "is")) ; Statement: $z5 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("is") 
 ; Statement: if $z5 != 0 goto $r2 = "get" 
(assert (not (not (= (ite var1045 1 0) 0)))) ; Negate: Cond: $z5 != 0  
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1483=java.lang.reflect.Method, var2084=r0, var3218=r1, var2023=$z0, var1045=$z5}
; {java.lang.reflect.Method=var1483, r0=var2084, r1=var3218, $z0=var2023, $z5=var1045}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 != 0 goto $r2 = "get";	$z5 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("is");	if $z5 != 0 goto $r2 = "get";	return 0
;block_num 3