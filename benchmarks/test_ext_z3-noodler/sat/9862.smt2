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

(declare-sort var1493 0)
(declare-sort var3446 0)
(declare-sort var2147 0)
(declare-sort var3084 0)
(declare-sort var1097 0)
(declare-sort var243 0)
(declare-sort var1622 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var243_getValueFromConfig/-1280208315 (var1493 String) String)
(declare-fun var243_parsePort/1420099487 (String) Int)
(declare-fun String_valueOf/-333372740 (var1622) String)
(declare-fun cast-from-Int-to-var1622 (Int) var1622)
(declare-fun var1097_put/1464166817 (var1097 var1622 var1622) var1622)
(declare-fun cast-from-String-to-var1622 (String) var1622)
(declare-const null-var1493 var1493)
(declare-const null-var3446 var3446)
(declare-const null-var2147 var2147)
(declare-const null-String String)
(declare-const null-var1097 var1097)
(declare-const null-Int Int)
(declare-const var1566 var1493) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var1566 null-var1493)))
(declare-const var1527 var3446) ; Statement: r3 := @parameter1: org.apache.dubbo.config.ProviderConfig 
(assert (not (= var1527 null-var3446)))
(declare-const var776 var2147) ; Statement: r4 := @parameter2: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var776 null-var2147)))
(declare-const var1203 String) ; Statement: r5 := @parameter3: java.lang.String 
(assert (not (= var1203 null-String)))
(declare-const var2132 var1097) ; Statement: r2 := @parameter4: java.util.Map 
(assert (not (= var2132 null-var1097)))
(define-const var1655 String (var243_getValueFromConfig/-1280208315 var1566 "DUBBO_PORT_TO_BIND")) ; Statement: r1 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String getValueFromConfig(org.apache.dubbo.config.ProtocolConfig,java.lang.String)>(r0, "DUBBO_PORT_TO_BIND") 
(define-const var18 Int (var243_parsePort/1420099487 var1655)) ; Statement: r7 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer parsePort(java.lang.String)>(r1) 
 ; Statement: if r7 != null goto $r10 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r7) 
(assert (not (= var18 null-Int))) ; Cond: r7 != null 
(define-const var1235 String (String_valueOf/-333372740 (cast-from-Int-to-var1622 var18))) ; Statement: $r10 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r7) 
;(assert (var1097_put/1464166817 var2132 (cast-from-String-to-var1622 "bind.port") (cast-from-String-to-var1622 var1235))) ; Statement: interfaceinvoke r2.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("bind.port", $r10) 

(declare-const var2132!1 var1097)
(declare-const var1404 String)
(declare-const var1235!1 String)
(define-const var219 String (var243_getValueFromConfig/-1280208315 var1566 "DUBBO_PORT_TO_REGISTRY")) ; Statement: $r11 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String getValueFromConfig(org.apache.dubbo.config.ProtocolConfig,java.lang.String)>(r0, "DUBBO_PORT_TO_REGISTRY") 
(define-const var2665 Int (var243_parsePort/1420099487 var219)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer parsePort(java.lang.String)>($r11) 
(define-const var2311 Int var2665) ; Statement: r13 = $r12 
 ; Statement: if $r12 != null goto return r13 
(assert (not (= var2665 null-Int))) ; Cond: $r12 != null 
 ; Statement: return r13 
(check-sat)
; {var243_getValueFromConfig/-1280208315=([org.apache.dubbo.config.ProtocolConfig, java.lang.String], java.lang.String), var243_parsePort/1420099487=([java.lang.String], java.lang.Integer), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-Int-to-var1622=([java.lang.Integer], java.lang.Object), var1097_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1622=([java.lang.String], java.lang.Object)}
; {var1493=org.apache.dubbo.config.ProtocolConfig, var1566=r0, var3446=org.apache.dubbo.config.ProviderConfig, var1527=r3, var2147=org.apache.dubbo.common.extension.ExtensionLoader, var776=r4, var1203=r5, var3084=null_type, var1097=java.util.Map, var2132=r2, var243=org.apache.dubbo.config.ServiceConfig, var1655=r1, var18=r7, var1622=java.lang.Object, var1235=$r10, var1404="bind.port", var219=$r11, var2665=$r12, var2311=r13}
; {org.apache.dubbo.config.ProtocolConfig=var1493, r0=var1566, org.apache.dubbo.config.ProviderConfig=var3446, r3=var1527, org.apache.dubbo.common.extension.ExtensionLoader=var2147, r4=var776, r5=var1203, null_type=var3084, java.util.Map=var1097, r2=var2132, org.apache.dubbo.config.ServiceConfig=var243, r1=var1655, r7=var18, java.lang.Object=var1622, $r10=var1235, "bind.port"=var1404, $r11=var219, $r12=var2665, r13=var2311}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig;	r3 := @parameter1: org.apache.dubbo.config.ProviderConfig;	r4 := @parameter2: org.apache.dubbo.common.extension.ExtensionLoader;	r5 := @parameter3: java.lang.String;	r2 := @parameter4: java.util.Map;	r1 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String getValueFromConfig(org.apache.dubbo.config.ProtocolConfig,java.lang.String)>(r0, "DUBBO_PORT_TO_BIND");	r7 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer parsePort(java.lang.String)>(r1);	if r7 != null goto $r10 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r7);	$r10 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r7);	interfaceinvoke r2.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("bind.port", $r10);	$r11 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String getValueFromConfig(org.apache.dubbo.config.ProtocolConfig,java.lang.String)>(r0, "DUBBO_PORT_TO_REGISTRY");	$r12 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer parsePort(java.lang.String)>($r11);	r13 = $r12;	if $r12 != null goto return r13;	return r13
;block_num 3