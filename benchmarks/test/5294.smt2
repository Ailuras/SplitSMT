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

(declare-sort var917 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var917) String)
(declare-const null-var917 var917)
(declare-const var587 var917) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var587 null-var917)))
(define-const var1672 String "registry") ; Statement: $r2 = "registry" 
(assert true)
(define-const var1045 String (getProtocol/491749358 var587)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1516 Bool (= var1672 var1045)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $z3 = 1 
(assert (not (= (ite var1516 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1401 Bool (ite (= 1 1) true false)) ; Statement: $z3 = 1 
 ; Statement: goto [?= return $z3] 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var917=org.apache.dubbo.common.URL, var587=r0, var1672=$r2, var1045=$r1, var1516=$z0, var1401=$z3}
; {org.apache.dubbo.common.URL=var917, r0=var587, $r2=var1672, $r1=var1045, $z0=var1516, $z3=var1401}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "registry";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $z3 = 1;	$z3 = 1;	goto [?= return $z3];	return $z3
;block_num 3