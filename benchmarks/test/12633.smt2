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

(declare-sort var319 0)
(declare-sort var1152 0)
(declare-sort var3894 0)
(declare-sort var3035 0)
(declare-sort var1058 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1152_getAttribute/-229173065 (var1152 String) var3035)
(declare-fun cast-from-var3035-to-String (var3035) String)
(declare-fun var1058_isEmpty/-813097145 (String) Bool)
(declare-const null-var319 var319)
(declare-const null-var1152 var1152)
(declare-const null-String String)
(declare-const var3725 var319) ; Statement: r37 := @this: org.apache.dubbo.qos.legacy.TraceTelnetHandler 
(assert (not (= var3725 null-var319)))
(declare-const var3320 var1152) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3320 null-var1152)))
(declare-const var3437 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3437 null-String)))
(define-const var3247 var3035 (var1152_getAttribute/-229173065 var3320 "telnet.service")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("telnet.service") 
(define-const var2244 String (cast-from-var3035-to-String var3247)) ; Statement: r38 = (java.lang.String) $r1 
(define-const var2408 Bool (var1058_isEmpty/-813097145 var2244)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r38) 
 ; Statement: if $z0 == 0 goto $r36 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(assert (not (= (ite var2408 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1590 Bool (var1058_isEmpty/-813097145 var3437)) ; Statement: $z9 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z9 == 0 goto $r36 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(assert (not (= (ite var1590 1 0) 0))) ; Negate: Cond: $z9 == 0  
 ; Statement: return "Please input service name, eg: \r\ntrace XxxService\r\ntrace XxxService xxxMethod\r\ntrace XxxService xxxMethod 10\r\nor \"cd XxxService\" firstly." 
(check-sat)
; {var1152_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var3035-to-String=([java.lang.Object], java.lang.String), var1058_isEmpty/-813097145=([java.lang.String], boolean)}
; {var319=org.apache.dubbo.qos.legacy.TraceTelnetHandler, var3725=r37, var1152=org.apache.dubbo.remoting.Channel, var3320=r0, var3437=r2, var3894=null_type, var3035=java.lang.Object, var3247=$r1, var2244=r38, var1058=org.apache.dubbo.common.utils.StringUtils, var2408=$z0, var1590=$z9}
; {org.apache.dubbo.qos.legacy.TraceTelnetHandler=var319, r37=var3725, org.apache.dubbo.remoting.Channel=var1152, r0=var3320, r2=var3437, null_type=var3894, java.lang.Object=var3035, $r1=var3247, r38=var2244, org.apache.dubbo.common.utils.StringUtils=var1058, $z0=var2408, $z9=var1590}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r37 := @this: org.apache.dubbo.qos.legacy.TraceTelnetHandler;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: java.lang.String;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("telnet.service");	r38 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r38);	if $z0 == 0 goto $r36 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$z9 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z9 == 0 goto $r36 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	return "Please input service name, eg: \r\ntrace XxxService\r\ntrace XxxService xxxMethod\r\ntrace XxxService xxxMethod 10\r\nor \"cd XxxService\" firstly."
;block_num 3