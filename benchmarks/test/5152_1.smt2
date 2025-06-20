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

(declare-sort var31 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var31) String)
(declare-const null-var31 var31)
(declare-const var3688 var31) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3688 null-var31)))
(assert true)
(define-const var331 String (getName/1227988463 var3688)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(define-const var2985 String "getParameters") ; Statement: $r2 = "getParameters" 
(assert true)
(define-const var2488 Bool (= var2985 var331)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var2488 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3809 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String)}
; {var31=java.lang.reflect.Method, var3688=r0, var331=r1, var2985=$r2, var2488=$z0, var3809=$z2}
; {java.lang.reflect.Method=var31, r0=var3688, r1=var331, $r2=var2985, $z0=var2488, $z2=var3809}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r2 = "getParameters";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3