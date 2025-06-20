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

(declare-sort var1471 0)
(declare-sort var2923 0)
(declare-sort var2477 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2923_getAttribute/-229173065 (var2923 String) var2477)
(declare-fun cast-from-var2477-to-String (var2477) String)
(declare-const null-var1471 var1471)
(declare-const null-var2923 var2923)
(declare-const var2975 var1471) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var2975 null-var1471)))
(declare-const var2801 var2923) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2801 null-var2923)))
(define-const var3827 var2477 (var2923_getAttribute/-229173065 var2801 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var65 String (cast-from-var2477-to-String var3827)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var3810 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var3123 Bool (= var3810 var65)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (not (= (ite var3123 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 1 
(check-sat)
; {var2923_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var2477-to-String=([java.lang.Object], java.lang.String)}
; {var1471=org.apache.dubbo.remoting.transport.AbstractCodec, var2975=r12, var2923=org.apache.dubbo.remoting.Channel, var2801=r0, var2477=java.lang.Object, var3827=$r1, var65=r2, var3810=$r3, var3123=$z0}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var1471, r12=var2975, org.apache.dubbo.remoting.Channel=var2923, r0=var2801, java.lang.Object=var2477, $r1=var3827, r2=var65, $r3=var3810, $z0=var3123}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	return 1
;block_num 2