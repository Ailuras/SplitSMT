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

(declare-sort var2405 0)
(declare-sort var3052 0)
(declare-sort var927 0)
(declare-sort var2807 0)
(declare-sort var2040 0)
(declare-sort var114 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun arr-var2040-init () (Array Int var2040))
(declare-fun cast-from-String-to-var2040 (String) var2040)
(declare-fun getBaseUrl/-1900615306 (var2405) String)
(declare-fun var114_info/1796807304 (var114 String (Array Int var2040)) void)
(declare-fun cast-from-var2807-to-var114 (var2807) var114)
(declare-const null-var2405 var2405)
(declare-const null-String String)
(declare-const null-var927 var927)
(declare-const var2405-LOGGER var2807)
(declare-const null-__Array__Int__var2040__ (Array Int var2040))
(declare-const var3849 var2405) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var3849 null-var2405)))
(declare-const var2275 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2275 null-String)))
(declare-const var1135 var927) ; Statement: r0 := @parameter1: java.lang.Throwable 
(assert (not (= var1135 null-var927)))
 ; Statement: if r0 != null goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling> 
(assert (not (not (= var1135 null-var927)))) ; Negate: Cond: r0 != null  
(assert true)
(define-const var36 Bool (contains/1009244746 var2275 (cast-from-String-to-String "h3="))) ; Statement: $z1 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("h3=") 
 ; Statement: if $z1 == 0 goto $r5 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(assert (= (ite var36 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1182 var2807 var2405-LOGGER) ; Statement: $r5 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var3670 (Array Int var2040) arr-var2040-init) ; Statement: $r4 = newarray (java.lang.Object)[2] 
(declare-const var3670!1 (Array Int var2040))
(assert (not (= var3670!1 null-__Array__Int__var2040__)))
(assert (= (select var3670!1 0) (cast-from-String-to-var2040 var2275))) ; Statement: $r4[0] = r3 
(assert true)
(define-const var1697 String (getBaseUrl/-1900615306 var3849)) ; Statement: $r6 = specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.lang.String getBaseUrl()>() 
(declare-const var3670!2 (Array Int var2040))
(assert (not (= var3670!2 null-__Array__Int__var2040__)))
(assert (= (select var3670!2 1) (cast-from-String-to-var2040 var1697))) ; Statement: $r4[1] = $r6 
;(assert (var114_info/1796807304 (cast-from-var2807-to-var114 var1182) "HTTP/3 negotiation succeed, but provider reply alt-svc=\u0027{}\u0027 not support HTTP/3 for [{}]" var3670!2)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String,java.lang.Object[])>("HTTP/3 negotiation succeed, but provider reply alt-svc=\'{}\' not support HTTP/3 for [{}]", $r4) 

(declare-const var1182!1 var2807)
(declare-const var2282 String)
(declare-const var3670!3 (Array Int var2040))
 ; Statement: return 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), arr-var2040-init=([], java.lang.Object[]), cast-from-String-to-var2040=([java.lang.String], java.lang.Object), getBaseUrl/-1900615306=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], java.lang.String), var114_info/1796807304=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Object[]], void), cast-from-var2807-to-var114=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var2405=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var3849=r1, var2275=r3, var3052=null_type, var927=java.lang.Throwable, var1135=r0, var36=$z1, var2807=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1182=$r5, var2040=java.lang.Object, var3670=$r4, var1697=$r6, var114=org.apache.dubbo.common.logger.Logger, var2282="HTTP/3 negotiation succeed, but provider reply alt-svc=\'{}\' not support HTTP/3 for [{}]"}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var2405, r1=var3849, r3=var2275, null_type=var3052, java.lang.Throwable=var927, r0=var1135, $z1=var36, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2807, $r5=var1182, java.lang.Object=var2040, $r4=var3670, $r6=var1697, org.apache.dubbo.common.logger.Logger=var114, "HTTP/3 negotiation succeed, but provider reply alt-svc=\'{}\' not support HTTP/3 for [{}]"=var2282}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Throwable;	if r0 != null goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling>;	$z1 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("h3=");	if $z1 == 0 goto $r5 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r5 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r4 = newarray (java.lang.Object)[2];	$r4[0] = r3;	$r6 = specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.lang.String getBaseUrl()>();	$r4[1] = $r6;	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String,java.lang.Object[])>("HTTP/3 negotiation succeed, but provider reply alt-svc=\'{}\' not support HTTP/3 for [{}]", $r4);	return
;block_num 3