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

(declare-sort var3900 0)
(declare-sort var592 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var592) String)
(declare-const null-String String)
(declare-const null-var592 var592)
(declare-const var962 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var962 null-String)))
(declare-const var2605 var592) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var2605 null-var592)))
(assert true)
(define-const var1283 String (getName/1227988463 var2605)) ; Statement: $r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var3928 Bool (= var1283 var962)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String)}
; {var962=r1, var3900=null_type, var592=java.lang.reflect.Method, var2605=r0, var1283=$r2, var3928=$z0}
; {r1=var962, null_type=var3900, java.lang.reflect.Method=var592, r0=var2605, $r2=var1283, $z0=var3928}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.reflect.Method;	$r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	return $z0
;block_num 1