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

(declare-sort var1836 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var1836) String)
(declare-const null-var1836 var1836)
(declare-const var877 var1836) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var877 null-var1836)))
(define-const var224 String "route") ; Statement: $r2 = "route" 
(assert true)
(define-const var1196 String (getProtocol/491749358 var877)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2080 Bool (= var224 var1196)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2080 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1615 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1836=org.apache.dubbo.common.URL, var877=r0, var224=$r2, var1196=$r1, var2080=$z0, var1615=$z2}
; {org.apache.dubbo.common.URL=var1836, r0=var877, $r2=var224, $r1=var1196, $z0=var2080, $z2=var1615}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "route";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3