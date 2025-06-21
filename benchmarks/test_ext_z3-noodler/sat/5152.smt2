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

(declare-sort var3531 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3531 String) String)
(declare-const null-var3531 var3531)
(declare-const var1173 var3531) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1173 null-var3531)))
(declare-const var3977 var3531) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3977 null-var3531)))
(assert true)
(define-const var2546 String (getParameter/-1307325648 var1173 "interface")) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("interface") 
(assert true)
(define-const var1411 String (getParameter/-1307325648 var3977 "interface")) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("interface") 
(assert true)
(define-const var3969 Bool (= var2546 var1411)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z0 == 0 goto $z3 = 0 
(assert (= (ite var3969 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3195 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var3531=org.apache.dubbo.common.URL, var1173=r0, var3977=r1, var2546=$r3, var1411=$r2, var3969=$z0, var3195=$z3}
; {org.apache.dubbo.common.URL=var3531, r0=var1173, r1=var3977, $r3=var2546, $r2=var1411, $z0=var3969, $z3=var3195}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.common.URL;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("interface");	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("interface");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z0 == 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 3