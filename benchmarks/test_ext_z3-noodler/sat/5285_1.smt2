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

(declare-sort var1167 0)
(declare-sort var2931 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var2931) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1167 var1167)
(declare-const null-var2931 var2931)
(declare-const var1444 var1167) ; Statement: r3 := @parameter0: java.lang.Object 
(assert (not (= var1444 null-var1167)))
(declare-const var487 var2931) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var487 null-var2931)))
(assert true)
(define-const var2479 String (getName/1227988463 var487)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2163 Bool (startsWith/-1785782452 var2479 "set")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("set") 
 ; Statement: if $z0 == 0 goto $z6 = 0 
(assert (= (ite var2163 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1549 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(assert true) ; Non Conditional
 ; Statement: if $z6 != 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String extractFieldName(java.lang.reflect.Method)>(r0) 
(assert (not (not (= (ite var1549 1 0) 0)))) ; Negate: Cond: $z6 != 0  
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1167=java.lang.Object, var1444=r3, var2931=java.lang.reflect.Method, var487=r0, var2479=$r1, var2163=$z0, var1549=$z6}
; {java.lang.Object=var1167, r3=var1444, java.lang.reflect.Method=var2931, r0=var487, $r1=var2479, $z0=var2163, $z6=var1549}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r3 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("set");	if $z0 == 0 goto $z6 = 0;	$z6 = 0;	if $z6 != 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String extractFieldName(java.lang.reflect.Method)>(r0);	return 0
;block_num 4