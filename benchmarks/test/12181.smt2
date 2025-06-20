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

(declare-sort var3575 0)
(declare-sort var3314 0)
(declare-sort var3634 0)
(declare-sort var348 0)
(declare-sort var2197 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var348_currentTimeMillis/630293680 () Int)
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun getAccessKeyPair/-1227244037 (var3575 var3314 var3634) var2197)
(declare-fun getSecretKey/-1494298877 (var2197) String)
(declare-fun getSignature/499323829 (var3575 var3634 var3314 String String) String)
(declare-fun var3314_setAttachment/245726651 (var3314 String String) void)
(declare-fun getAccessKey/-459776329 (var2197) String)
(declare-fun getApplication/-536601276 (var3634) String)
(declare-const null-var3575 var3575)
(declare-const null-var3314 var3314)
(declare-const null-var3634 var3634)
(declare-const var2110 var3575) ; Statement: r1 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator 
(assert (not (= var2110 null-var3575)))
(declare-const var1632 var3314) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1632 null-var3314)))
(declare-const var1515 var3634) ; Statement: r3 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1515 null-var3634)))
(define-const var2504 Int var348_currentTimeMillis/630293680) ; Statement: $l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var1291 String (String_valueOf/-107395227 var2504)) ; Statement: r0 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>($l0) 
(assert true)
(define-const var3223 var2197 (getAccessKeyPair/-1227244037 var2110 var1632 var1515)) ; Statement: r4 = virtualinvoke r1.<org.apache.dubbo.auth.AccessKeyAuthenticator: org.apache.dubbo.auth.model.AccessKeyPair getAccessKeyPair(org.apache.dubbo.rpc.Invocation,org.apache.dubbo.common.URL)>(r2, r3) 
(assert true)
(define-const var1255 String (getSecretKey/-1494298877 var3223)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.auth.model.AccessKeyPair: java.lang.String getSecretKey()>() 
(assert true)
(define-const var2487 String (getSignature/499323829 var2110 var1515 var1632 var1255 var1291)) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.auth.AccessKeyAuthenticator: java.lang.String getSignature(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation,java.lang.String,java.lang.String)>(r3, r2, $r5, r0) 
;(assert (var3314_setAttachment/245726651 var1632 "signature" var2487)) ; Statement: interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("signature", $r6) 

(declare-const var1632!1 var3314)
(declare-const var2155 String)
(declare-const var2487!1 String)
;(assert (var3314_setAttachment/245726651 var1632!1 "timestamp" var1291)) ; Statement: interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("timestamp", r0) 

(declare-const var1632!2 var3314)
(declare-const var3800 String)
(declare-const var1291!1 String)
(assert true)
(define-const var707 String (getAccessKey/-459776329 var3223)) ; Statement: $r7 = virtualinvoke r4.<org.apache.dubbo.auth.model.AccessKeyPair: java.lang.String getAccessKey()>() 
;(assert (var3314_setAttachment/245726651 var1632!2 "ak" var707)) ; Statement: interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("ak", $r7) 

(declare-const var1632!3 var3314)
(declare-const var2672 String)
(declare-const var707!1 String)
(assert true)
(define-const var360 String (getApplication/-536601276 var1515)) ; Statement: $r8 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
;(assert (var3314_setAttachment/245726651 var1632!3 "consumer" var360)) ; Statement: interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("consumer", $r8) 

(declare-const var1632!4 var3314)
(declare-const var590 String)
(declare-const var360!1 String)
 ; Statement: return 
(check-sat)
; {var348_currentTimeMillis/630293680=([], long), String_valueOf/-107395227=([long], java.lang.String), getAccessKeyPair/-1227244037=([org.apache.dubbo.auth.AccessKeyAuthenticator, org.apache.dubbo.rpc.Invocation, org.apache.dubbo.common.URL], org.apache.dubbo.auth.model.AccessKeyPair), getSecretKey/-1494298877=([org.apache.dubbo.auth.model.AccessKeyPair], java.lang.String), getSignature/499323829=([org.apache.dubbo.auth.AccessKeyAuthenticator, org.apache.dubbo.common.URL, org.apache.dubbo.rpc.Invocation, java.lang.String, java.lang.String], java.lang.String), var3314_setAttachment/245726651=([org.apache.dubbo.rpc.Invocation, java.lang.String, java.lang.String], void), getAccessKey/-459776329=([org.apache.dubbo.auth.model.AccessKeyPair], java.lang.String), getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3575=org.apache.dubbo.auth.AccessKeyAuthenticator, var2110=r1, var3314=org.apache.dubbo.rpc.Invocation, var1632=r2, var3634=org.apache.dubbo.common.URL, var1515=r3, var348=java.lang.System, var2504=$l0, var1291=r0, var2197=org.apache.dubbo.auth.model.AccessKeyPair, var3223=r4, var1255=$r5, var2487=$r6, var2155="signature", var3800="timestamp", var707=$r7, var2672="ak", var360=$r8, var590="consumer"}
; {org.apache.dubbo.auth.AccessKeyAuthenticator=var3575, r1=var2110, org.apache.dubbo.rpc.Invocation=var3314, r2=var1632, org.apache.dubbo.common.URL=var3634, r3=var1515, java.lang.System=var348, $l0=var2504, r0=var1291, org.apache.dubbo.auth.model.AccessKeyPair=var2197, r4=var3223, $r5=var1255, $r6=var2487, "signature"=var2155, "timestamp"=var3800, $r7=var707, "ak"=var2672, $r8=var360, "consumer"=var590}
;seq <java.lang.String: java.lang.String valueOf(long)>
;cnt {"<java.lang.String: java.lang.String valueOf(long)>": 1}
;stmts r1 := @this: org.apache.dubbo.auth.AccessKeyAuthenticator;	r2 := @parameter0: org.apache.dubbo.rpc.Invocation;	r3 := @parameter1: org.apache.dubbo.common.URL;	$l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	r0 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>($l0);	r4 = virtualinvoke r1.<org.apache.dubbo.auth.AccessKeyAuthenticator: org.apache.dubbo.auth.model.AccessKeyPair getAccessKeyPair(org.apache.dubbo.rpc.Invocation,org.apache.dubbo.common.URL)>(r2, r3);	$r5 = virtualinvoke r4.<org.apache.dubbo.auth.model.AccessKeyPair: java.lang.String getSecretKey()>();	$r6 = virtualinvoke r1.<org.apache.dubbo.auth.AccessKeyAuthenticator: java.lang.String getSignature(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation,java.lang.String,java.lang.String)>(r3, r2, $r5, r0);	interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("signature", $r6);	interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("timestamp", r0);	$r7 = virtualinvoke r4.<org.apache.dubbo.auth.model.AccessKeyPair: java.lang.String getAccessKey()>();	interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("ak", $r7);	$r8 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("consumer", $r8);	return
;block_num 1