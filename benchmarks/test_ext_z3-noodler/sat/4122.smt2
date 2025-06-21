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

(declare-sort var1848 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var1848) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1848 var1848)
(declare-const var1179 var1848) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1179 null-var1848)))
(assert true)
(define-const var660 String (getName/1227988463 var1179)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var3049 Bool (startsWith/-1785782452 var660 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 != 0 goto $r2 = "get" 
(assert (not (= (ite var3049 1 0) 0))) ; Cond: $z0 != 0 
(define-const var114 String "get") ; Statement: $r2 = "get" 
(assert true)
(define-const var2516 Bool (= var114 var660)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z1 == 0 goto $r3 = "getClass" 
(assert (not (= (ite var2516 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1848=java.lang.reflect.Method, var1179=r0, var660=r1, var3049=$z0, var114=$r2, var2516=$z1}
; {java.lang.reflect.Method=var1848, r0=var1179, r1=var660, $z0=var3049, $r2=var114, $z1=var2516}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 != 0 goto $r2 = "get";	$r2 = "get";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z1 == 0 goto $r3 = "getClass";	return 0
;block_num 3