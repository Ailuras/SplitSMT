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

(declare-sort var3098 0)
(declare-sort var3061 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var3061) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var3098 var3098)
(declare-const null-var3061 var3061)
(declare-const var3470 var3098) ; Statement: r4 := @parameter0: java.lang.Object 
(assert (not (= var3470 null-var3098)))
(declare-const var3040 var3061) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var3040 null-var3061)))
(assert true)
(define-const var614 String (getName/1227988463 var3040)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1792 Bool (startsWith/-1785782452 var614 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 != 0 goto $r2 = "get" 
(assert (not (= (ite var1792 1 0) 0))) ; Cond: $z0 != 0 
(define-const var322 String "get") ; Statement: $r2 = "get" 
(assert true)
(define-const var2324 Bool (= var322 var614)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z1 != 0 goto $z10 = 0 
(assert (not (= (ite var2324 1 0) 0))) ; Cond: $z1 != 0 
(define-const var3797 Bool (ite (= 1 0) true false)) ; Statement: $z10 = 0 
(assert true) ; Non Conditional
 ; Statement: if $z10 != 0 goto r3 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String extractFieldName(java.lang.reflect.Method)>(r0) 
(assert (not (not (= (ite var3797 1 0) 0)))) ; Negate: Cond: $z10 != 0  
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3098=java.lang.Object, var3470=r4, var3061=java.lang.reflect.Method, var3040=r0, var614=r1, var1792=$z0, var322=$r2, var2324=$z1, var3797=$z10}
; {java.lang.Object=var3098, r4=var3470, java.lang.reflect.Method=var3061, r0=var3040, r1=var614, $z0=var1792, $r2=var322, $z1=var2324, $z10=var3797}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 != 0 goto $r2 = "get";	$r2 = "get";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z1 != 0 goto $z10 = 0;	$z10 = 0;	if $z10 != 0 goto r3 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String extractFieldName(java.lang.reflect.Method)>(r0);	return 0
;block_num 5