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

(declare-sort var59 0)
(declare-sort var2412 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/854425250 (var59) String)
(declare-fun var2412_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var59 var59)
(declare-const var860 var59) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer 
(assert (not (= var860 null-var59)))
(define-const var2800 String (address/854425250 var860)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: java.lang.String address> 
(define-const var3256 Bool (var2412_isNotEmpty/-1251449450 var2800)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (not (= (ite var3256 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var830 String (address/854425250 var860)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: java.lang.String address> 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {address/854425250=([org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer], java.lang.String), var2412_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var59=org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer, var860=r0, var2800=$r1, var2412=org.apache.dubbo.common.utils.StringUtils, var3256=$z0, var830=$r4}
; {org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer=var59, r0=var860, $r1=var2800, org.apache.dubbo.common.utils.StringUtils=var2412, $z0=var3256, $r4=var830}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer;	$r1 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: org.apache.dubbo.remoting.RemotingServer server>;	$r4 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: java.lang.String address>;	goto [?= return $r4];	return $r4
;block_num 3