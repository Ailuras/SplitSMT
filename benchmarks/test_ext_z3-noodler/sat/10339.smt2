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

(declare-sort var2122 0)
(declare-sort var1457 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var1457) String)
(declare-const null-String String)
(declare-const null-var1457 var1457)
(declare-const var3839 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3839 null-String)))
(declare-const var1057 var1457) ; Statement: r3 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1057 null-var1457)))
(declare-const var551 var1457) ; Statement: r1 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var551 null-var1457)))
(assert true)
(define-const var700 String (getProtocol/491749358 var551)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1473 Bool (= var3839 var700)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var1473 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1045 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3839=r0, var2122=null_type, var1457=org.apache.dubbo.common.URL, var1057=r3, var551=r1, var700=$r2, var1473=$z0, var1045=$z2}
; {r0=var3839, null_type=var2122, org.apache.dubbo.common.URL=var1457, r3=var1057, r1=var551, $r2=var700, $z0=var1473, $z2=var1045}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: org.apache.dubbo.common.URL;	r1 := @parameter2: org.apache.dubbo.common.URL;	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3