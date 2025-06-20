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

(declare-sort var88 0)
(declare-sort var1656 0)
(declare-sort var510 0)
(declare-sort var2693 0)
(declare-sort var3588 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/854425250 (var88) String)
(declare-fun var1656_isNotEmpty/-1251449450 (String) Bool)
(declare-fun server/854425250 (var88) var510)
(declare-fun var3588_getUrl/938756954 (var3588) var2693)
(declare-fun cast-from-var510-to-var3588 (var510) var3588)
(declare-fun getAddress/-2093578336 (var2693) String)
(declare-const null-var88 var88)
(declare-const var1981 var88) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer 
(assert (not (= var1981 null-var88)))
(define-const var3426 String (address/854425250 var1981)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: java.lang.String address> 
(define-const var1607 Bool (var1656_isNotEmpty/-1251449450 var3426)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (= (ite var1607 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1178 var510 (server/854425250 var1981)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: org.apache.dubbo.remoting.RemotingServer server> 
(define-const var2365 var2693 (var3588_getUrl/938756954 (cast-from-var510-to-var3588 var1178))) ; Statement: $r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.RemotingServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3361 String (getAddress/-2093578336 var2365)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {address/854425250=([org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer], java.lang.String), var1656_isNotEmpty/-1251449450=([java.lang.String], boolean), server/854425250=([org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer], org.apache.dubbo.remoting.RemotingServer), var3588_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var510-to-var3588=([org.apache.dubbo.remoting.RemotingServer], org.apache.dubbo.remoting.Endpoint), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String)}
; {var88=org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer, var1981=r0, var3426=$r1, var1656=org.apache.dubbo.common.utils.StringUtils, var1607=$z0, var510=org.apache.dubbo.remoting.RemotingServer, var1178=$r2, var2693=org.apache.dubbo.common.URL, var3588=org.apache.dubbo.remoting.Endpoint, var2365=$r3, var3361=$r4}
; {org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer=var88, r0=var1981, $r1=var3426, org.apache.dubbo.common.utils.StringUtils=var1656, $z0=var1607, org.apache.dubbo.remoting.RemotingServer=var510, $r2=var1178, org.apache.dubbo.common.URL=var2693, org.apache.dubbo.remoting.Endpoint=var3588, $r3=var2365, $r4=var3361}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer;	$r1 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: org.apache.dubbo.remoting.RemotingServer server>;	$r2 = r0.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol$ProxyProtocolServer: org.apache.dubbo.remoting.RemotingServer server>;	$r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.RemotingServer: org.apache.dubbo.common.URL getUrl()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	return $r4
;block_num 3