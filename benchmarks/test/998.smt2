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

(declare-sort var3486 0)
(declare-sort var3678 0)
(declare-sort var2745 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3678_isMatch/2132515333 (var2745 var2745) Bool)
(declare-fun cast-from-var3486-to-var2745 (var3486) var2745)
(declare-fun getProtocol/-1423134967 (var3486) String)
(declare-const null-var3486 var3486)
(declare-const var3537 var3486) ; Statement: r0 := @parameter0: org.apache.dubbo.common.ProtocolServiceKey 
(assert (not (= var3537 null-var3486)))
(declare-const var3991 var3486) ; Statement: r1 := @parameter1: org.apache.dubbo.common.ProtocolServiceKey 
(assert (not (= var3991 null-var3486)))
(define-const var271 Bool (var3678_isMatch/2132515333 (cast-from-var3486-to-var2745 var3537) (cast-from-var3486-to-var2745 var3991))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.ServiceKey$Matcher: boolean isMatch(org.apache.dubbo.common.ServiceKey,org.apache.dubbo.common.ServiceKey)>(r0, r1) 
 ; Statement: if $z0 != 0 goto $r3 = "*" 
(assert (not (= (ite var271 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1597 String "*") ; Statement: $r3 = "*" 
(assert true)
(define-const var1479 String (getProtocol/-1423134967 var3537)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String getProtocol()>() 
(assert true)
(define-const var907 Bool (= var1597 var1479)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 != 0 goto return 1 
(assert (not (= (ite var907 1 0) 0))) ; Cond: $z1 != 0 
 ; Statement: return 1 
(check-sat)
; {var3678_isMatch/2132515333=([org.apache.dubbo.common.ServiceKey, org.apache.dubbo.common.ServiceKey], boolean), cast-from-var3486-to-var2745=([org.apache.dubbo.common.ProtocolServiceKey], org.apache.dubbo.common.ServiceKey), getProtocol/-1423134967=([org.apache.dubbo.common.ProtocolServiceKey], java.lang.String)}
; {var3486=org.apache.dubbo.common.ProtocolServiceKey, var3537=r0, var3991=r1, var3678=org.apache.dubbo.common.ServiceKey$Matcher, var2745=org.apache.dubbo.common.ServiceKey, var271=$z0, var1597=$r3, var1479=$r2, var907=$z1}
; {org.apache.dubbo.common.ProtocolServiceKey=var3486, r0=var3537, r1=var3991, org.apache.dubbo.common.ServiceKey$Matcher=var3678, org.apache.dubbo.common.ServiceKey=var2745, $z0=var271, $r3=var1597, $r2=var1479, $z1=var907}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.ProtocolServiceKey;	r1 := @parameter1: org.apache.dubbo.common.ProtocolServiceKey;	$z0 = staticinvoke <org.apache.dubbo.common.ServiceKey$Matcher: boolean isMatch(org.apache.dubbo.common.ServiceKey,org.apache.dubbo.common.ServiceKey)>(r0, r1);	if $z0 != 0 goto $r3 = "*";	$r3 = "*";	$r2 = virtualinvoke r0.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String getProtocol()>();	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 != 0 goto return 1;	return 1
;block_num 3