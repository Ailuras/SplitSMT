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

(declare-sort var3323 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var3323) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var3323 var3323)
(declare-const var3684 var3323) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3684 null-var3323)))
(assert true)
(define-const var266 String (getName/1227988463 var3684)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var3742 Bool (startsWith/-1785782452 var266 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 != 0 goto $r2 = "get" 
(assert (not (not (= (ite var3742 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var1416 Bool (startsWith/-1785782452 var266 "is")) ; Statement: $z7 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("is") 
 ; Statement: if $z7 == 0 goto $z8 = 0 
(assert (= (ite var1416 1 0) 0)) ; Cond: $z7 == 0 
(define-const var1176 Bool (ite (= 1 0) true false)) ; Statement: $z8 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z8 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3323=java.lang.reflect.Method, var3684=r0, var266=r1, var3742=$z0, var1416=$z7, var1176=$z8}
; {java.lang.reflect.Method=var3323, r0=var3684, r1=var266, $z0=var3742, $z7=var1416, $z8=var1176}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 != 0 goto $r2 = "get";	$z7 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("is");	if $z7 == 0 goto $z8 = 0;	$z8 = 0;	return $z8
;block_num 4