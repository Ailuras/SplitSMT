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

(declare-sort var2949 0)
(declare-sort var335 0)
(declare-sort var1488 0)
(declare-sort var3188 0)
(declare-sort var2621 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/1634572002 (var2949) String)
(declare-fun var335_isNotEmpty/-1251449450 (String) Bool)
(declare-fun server/1634572002 (var2949) var1488)
(declare-fun var2621_getUrl/938756954 (var2621) var3188)
(declare-fun cast-from-var1488-to-var2621 (var1488) var2621)
(declare-fun getAddress/-2093578336 (var3188) String)
(declare-const null-var2949 var2949)
(declare-const var3056 var2949) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer 
(assert (not (= var3056 null-var2949)))
(define-const var696 String (address/1634572002 var3056)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: java.lang.String address> 
(define-const var3357 Bool (var335_isNotEmpty/-1251449450 var696)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (= (ite var3357 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3409 var1488 (server/1634572002 var3056)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: org.apache.dubbo.remoting.RemotingServer server> 
(define-const var3614 var3188 (var2621_getUrl/938756954 (cast-from-var1488-to-var2621 var3409))) ; Statement: $r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.RemotingServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2504 String (getAddress/-2093578336 var3614)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {address/1634572002=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer], java.lang.String), var335_isNotEmpty/-1251449450=([java.lang.String], boolean), server/1634572002=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer], org.apache.dubbo.remoting.RemotingServer), var2621_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var1488-to-var2621=([org.apache.dubbo.remoting.RemotingServer], org.apache.dubbo.remoting.Endpoint), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String)}
; {var2949=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer, var3056=r0, var696=$r1, var335=org.apache.dubbo.common.utils.StringUtils, var3357=$z0, var1488=org.apache.dubbo.remoting.RemotingServer, var3409=$r2, var3188=org.apache.dubbo.common.URL, var2621=org.apache.dubbo.remoting.Endpoint, var3614=$r3, var2504=$r4}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer=var2949, r0=var3056, $r1=var696, org.apache.dubbo.common.utils.StringUtils=var335, $z0=var3357, org.apache.dubbo.remoting.RemotingServer=var1488, $r2=var3409, org.apache.dubbo.common.URL=var3188, org.apache.dubbo.remoting.Endpoint=var2621, $r3=var3614, $r4=var2504}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: org.apache.dubbo.remoting.RemotingServer server>;	$r2 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocolServer: org.apache.dubbo.remoting.RemotingServer server>;	$r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.RemotingServer: org.apache.dubbo.common.URL getUrl()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	return $r4
;block_num 3