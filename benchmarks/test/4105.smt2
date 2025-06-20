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

(declare-sort var728 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var728) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var728 var728)
(declare-const var5 var728) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var5 null-var728)))
(assert true)
(define-const var625 String (getName/1227988463 var5)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var236 Bool (startsWith/-1785782452 var625 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 != 0 goto $r2 = "get" 
(assert (not (= (ite var236 1 0) 0))) ; Cond: $z0 != 0 
(define-const var111 String "get") ; Statement: $r2 = "get" 
(assert true)
(define-const var3986 Bool (= var111 var625)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z1 != 0 goto $z8 = 0 
(assert (not (= (ite var3986 1 0) 0))) ; Cond: $z1 != 0 
(define-const var715 Bool (ite (= 1 0) true false)) ; Statement: $z8 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z8 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var728=java.lang.reflect.Method, var5=r0, var625=r1, var236=$z0, var111=$r2, var3986=$z1, var715=$z8}
; {java.lang.reflect.Method=var728, r0=var5, r1=var625, $z0=var236, $r2=var111, $z1=var3986, $z8=var715}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 != 0 goto $r2 = "get";	$r2 = "get";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z1 != 0 goto $z8 = 0;	$z8 = 0;	return $z8
;block_num 4