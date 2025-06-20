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

(declare-sort var1328 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var1328) String)
(declare-const null-var1328 var1328)
(declare-const var1458 var1328) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1458 null-var1328)))
(define-const var3706 String "override") ; Statement: $r2 = "override" 
(assert true)
(define-const var2763 String (getProtocol/491749358 var1458)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1278 Bool (= var3706 var2763)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $z3 = 0 
(assert (not (= (ite var1278 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1473 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1328=org.apache.dubbo.common.URL, var1458=r0, var3706=$r2, var2763=$r1, var1278=$z0, var1473=$z3}
; {org.apache.dubbo.common.URL=var1328, r0=var1458, $r2=var3706, $r1=var2763, $z0=var1278, $z3=var1473}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "override";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 3