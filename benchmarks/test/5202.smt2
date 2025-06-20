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

(declare-sort var645 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var645) String)
(declare-const null-var645 var645)
(declare-const var2452 var645) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2452 null-var645)))
(define-const var1173 String "setParameters") ; Statement: $r2 = "setParameters" 
(assert true)
(define-const var656 String (getName/1227988463 var2452)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2333 Bool (= var1173 var656)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var2333 1 0) 0)) ; Cond: $z0 == 0 
(define-const var594 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String)}
; {var645=java.lang.reflect.Method, var2452=r0, var1173=$r2, var656=$r1, var2333=$z0, var594=$z2}
; {java.lang.reflect.Method=var645, r0=var2452, $r2=var1173, $r1=var656, $z0=var2333, $z2=var594}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.reflect.Method;	$r2 = "setParameters";	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3