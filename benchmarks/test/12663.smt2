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

(declare-sort var2652 0)
(declare-sort var489 0)
(declare-sort var798 0)
(declare-sort var2515 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2515_isEmpty/-813097145 (String) Bool)
(declare-const null-var2652 var2652)
(declare-const null-var489 var489)
(declare-const null-String String)
(declare-const var3061 var2652) ; Statement: r26 := @this: org.apache.dubbo.qos.legacy.ChangeTelnetHandler 
(assert (not (= var3061 null-var2652)))
(declare-const var1332 var489) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1332 null-var489)))
(declare-const var2947 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2947 null-String)))
(define-const var1227 Bool (var2515_isEmpty/-813097145 var2947)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (= (ite var1227 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "Please input service name, eg: \r\ncd XxxService\r\ncd com.xxx.XxxService" 
(check-sat)
; {var2515_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2652=org.apache.dubbo.qos.legacy.ChangeTelnetHandler, var3061=r26, var489=org.apache.dubbo.remoting.Channel, var1332=r3, var2947=r0, var798=null_type, var2515=org.apache.dubbo.common.utils.StringUtils, var1227=$z0}
; {org.apache.dubbo.qos.legacy.ChangeTelnetHandler=var2652, r26=var3061, org.apache.dubbo.remoting.Channel=var489, r3=var1332, r0=var2947, null_type=var798, org.apache.dubbo.common.utils.StringUtils=var2515, $z0=var1227}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r26 := @this: org.apache.dubbo.qos.legacy.ChangeTelnetHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	return "Please input service name, eg: \r\ncd XxxService\r\ncd com.xxx.XxxService"
;block_num 2