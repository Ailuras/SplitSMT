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

(declare-sort var203 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHost/-1506772130 (var203) String)
(declare-const null-var203 var203)
(declare-const var3346 var203) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3346 null-var203)))
(define-const var1895 String "0.0.0.0") ; Statement: $r2 = "0.0.0.0" 
(assert true)
(define-const var2092 String (getHost/-1506772130 var3346)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var2414 Bool (= var1895 var2092)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2414 1 0) 0))) ; Cond: $z0 != 0 
(define-const var284 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String)}
; {var203=org.apache.dubbo.common.URL, var3346=r0, var1895=$r2, var2092=$r1, var2414=$z0, var284=$z2}
; {org.apache.dubbo.common.URL=var203, r0=var3346, $r2=var1895, $r1=var2092, $z0=var2414, $z2=var284}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	$r2 = "0.0.0.0";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3