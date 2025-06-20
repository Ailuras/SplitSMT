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

(declare-sort var2815 0)
(declare-sort var3900 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var3900) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2815 var2815)
(declare-const null-var3900 var3900)
(declare-const var3524 var2815) ; Statement: r4 := @parameter0: java.lang.Object 
(assert (not (= var3524 null-var2815)))
(declare-const var3157 var3900) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var3157 null-var3900)))
(assert true)
(define-const var2593 String (getName/1227988463 var3157)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2014 Bool (startsWith/-1785782452 var2593 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 != 0 goto $r2 = "get" 
(assert (not (not (= (ite var2014 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var933 Bool (startsWith/-1785782452 var2593 "is")) ; Statement: $z9 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("is") 
 ; Statement: if $z9 == 0 goto $z10 = 0 
(assert (= (ite var933 1 0) 0)) ; Cond: $z9 == 0 
(define-const var531 Bool (ite (= 1 0) true false)) ; Statement: $z10 = 0 
(assert true) ; Non Conditional
 ; Statement: if $z10 != 0 goto r3 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String extractFieldName(java.lang.reflect.Method)>(r0) 
(assert (not (not (= (ite var531 1 0) 0)))) ; Negate: Cond: $z10 != 0  
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2815=java.lang.Object, var3524=r4, var3900=java.lang.reflect.Method, var3157=r0, var2593=r1, var2014=$z0, var933=$z9, var531=$z10}
; {java.lang.Object=var2815, r4=var3524, java.lang.reflect.Method=var3900, r0=var3157, r1=var2593, $z0=var2014, $z9=var933, $z10=var531}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 2}
;stmts r4 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 != 0 goto $r2 = "get";	$z9 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("is");	if $z9 == 0 goto $z10 = 0;	$z10 = 0;	if $z10 != 0 goto r3 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String extractFieldName(java.lang.reflect.Method)>(r0);	return 0
;block_num 5