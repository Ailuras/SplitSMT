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

(declare-sort var753 0)
(declare-sort var1682 0)
(declare-sort var2092 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun negotiateSuccess/-2063770552 (var753) void)
(declare-const null-var753 var753)
(declare-const null-String String)
(declare-const null-var2092 var2092)
(declare-const var3579 var753) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var3579 null-var753)))
(declare-const var114 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var114 null-String)))
(declare-const var577 var2092) ; Statement: r0 := @parameter1: java.lang.Throwable 
(assert (not (= var577 null-var2092)))
 ; Statement: if r0 != null goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling> 
(assert (not (not (= var577 null-var2092)))) ; Negate: Cond: r0 != null  
(assert true)
(define-const var1480 Bool (contains/1009244746 var114 (cast-from-String-to-String "h3="))) ; Statement: $z1 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("h3=") 
 ; Statement: if $z1 == 0 goto $r5 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(assert (not (= (ite var1480 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
;(assert (negotiateSuccess/-2063770552 var3579)) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: void negotiateSuccess()>() 

(declare-const var3579!1 var753)
 ; Statement: return 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), negotiateSuccess/-2063770552=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], void)}
; {var753=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var3579=r1, var114=r3, var1682=null_type, var2092=java.lang.Throwable, var577=r0, var1480=$z1}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var753, r1=var3579, r3=var114, null_type=var1682, java.lang.Throwable=var2092, r0=var577, $z1=var1480}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Throwable;	if r0 != null goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling>;	$z1 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("h3=");	if $z1 == 0 goto $r5 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: void negotiateSuccess()>();	return
;block_num 3