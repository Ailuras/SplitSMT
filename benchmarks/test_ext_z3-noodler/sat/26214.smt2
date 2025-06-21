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

(declare-sort var610 0)
(declare-sort var1705 0)
(declare-sort var2706 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2706_valueOf/1602327315 (Bool) var2706)
(declare-fun allowCredentials/-83969598 (var610) var2706)
(declare-const null-var610 var610)
(declare-const null-String String)
(declare-const var3372 var610) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder 
(assert (not (= var3372 null-var610)))
(declare-const var3622 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3622 null-String)))
(define-const var1101 String "true") ; Statement: $r1 = "true" 
(assert true)
(define-const var2680 Bool (= var1101 var3622)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "false" 
(assert (not (= (ite var2680 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1248 var2706 (var2706_valueOf/1602327315 (ite (= 1 1) true false))) ; Statement: $r5 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1) 
(declare-const var3372!1 var610)
(assert (not (= var3372!1 null-var610)))
(assert (= (allowCredentials/-83969598 var3372!1) var1248)) ; Statement: r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder: java.lang.Boolean allowCredentials> = $r5 
 ; Statement: goto [?= return r3] 
(assert true) ; Non Conditional
 ; Statement: return r3 
(check-sat)
; {var2706_valueOf/1602327315=([boolean], java.lang.Boolean), allowCredentials/-83969598=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder], java.lang.Boolean)}
; {var610=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder, var3372=r3, var3622=r0, var1705=null_type, var1101=$r1, var2680=$z0, var2706=java.lang.Boolean, var1248=$r5}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder=var610, r3=var3372, r0=var3622, null_type=var1705, $r1=var1101, $z0=var2680, java.lang.Boolean=var2706, $r5=var1248}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder;	r0 := @parameter0: java.lang.String;	$r1 = "true";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "false";	$r5 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1);	r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder: java.lang.Boolean allowCredentials> = $r5;	goto [?= return r3];	return r3
;block_num 3