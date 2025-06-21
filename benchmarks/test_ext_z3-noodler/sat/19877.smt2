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

(declare-sort var2821 0)
(declare-sort var2276 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/1634572002 (var2821) String)
(declare-fun var2276_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2821 var2821)
(declare-const var2510 var2821) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer 
(assert (not (= var2510 null-var2821)))
(define-const var1188 String (address/1634572002 var2510)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: java.lang.String address> 
(define-const var569 Bool (var2276_isNotEmpty/-1251449450 var1188)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (not (= (ite var569 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2571 String (address/1634572002 var2510)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: java.lang.String address> 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {address/1634572002=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer], java.lang.String), var2276_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2821=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer, var2510=r0, var1188=$r1, var2276=org.apache.dubbo.common.utils.StringUtils, var569=$z0, var2571=$r4}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer=var2821, r0=var2510, $r1=var1188, org.apache.dubbo.common.utils.StringUtils=var2276, $z0=var569, $r4=var2571}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: org.apache.dubbo.remoting.RemotingServer server>;	$r4 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: java.lang.String address>;	goto [?= return $r4];	return $r4
;block_num 3