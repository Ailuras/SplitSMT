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

(declare-sort var3009 0)
(declare-sort var2106 0)
(declare-sort var2832 0)
(declare-sort var3529 0)
(declare-sort var1783 0)
(declare-sort var1391 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2106_size/-959786421 (var2106) Int)
(declare-fun var3009_localAddress/1290099742 (var3009) var3529)
(declare-fun cast-from-var3529-to-var1783 (var3529) var1783)
(declare-fun var1391_toAddressString/-2067247090 (var1783) String)
(declare-const null-var3009 var3009)
(declare-const var2832-ACCESSORS var2106)
(declare-const null-var3529 var3529)
(declare-const var2536 var3009) ; Statement: r1 := @parameter0: io.netty.channel.Channel 
(assert (not (= var2536 null-var3009)))
(define-const var668 Int 0) ; Statement: i1 = 0 
(define-const var2304 var2106 var2832-ACCESSORS) ; Statement: $r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var2474 Int (var2106_size/-959786421 var2304)) ; Statement: i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>() 
(assert (>= var668 var2474)) ; Cond: i1 >= i0 
(define-const var3154 var3529 (var3009_localAddress/1290099742 var2536)) ; Statement: r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>() 
 ; Statement: if r15 != null goto $r2 = (java.net.InetSocketAddress) r15 
(assert (not (= var3154 null-var3529))) ; Cond: r15 != null 
(define-const var1573 var1783 (cast-from-var3529-to-var1783 var3154)) ; Statement: $r2 = (java.net.InetSocketAddress) r15 
(define-const var2537 String (var1391_toAddressString/-2067247090 var1573)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var2106_size/-959786421=([java.util.List], int), var3009_localAddress/1290099742=([io.netty.channel.Channel], java.net.SocketAddress), cast-from-var3529-to-var1783=([java.net.SocketAddress], java.net.InetSocketAddress), var1391_toAddressString/-2067247090=([java.net.InetSocketAddress], java.lang.String)}
; {var3009=io.netty.channel.Channel, var2536=r1, var668=i1, var2106=java.util.List, var2832=org.apache.dubbo.remoting.transport.netty4.AddressUtils, var2304=$r0, var2474=i0, var3529=java.net.SocketAddress, var3154=r15, var1783=java.net.InetSocketAddress, var1573=$r2, var1391=org.apache.dubbo.common.utils.NetUtils, var2537=$r3}
; {io.netty.channel.Channel=var3009, r1=var2536, i1=var668, java.util.List=var2106, org.apache.dubbo.remoting.transport.netty4.AddressUtils=var2832, $r0=var2304, i0=var2474, java.net.SocketAddress=var3529, r15=var3154, java.net.InetSocketAddress=var1783, $r2=var1573, org.apache.dubbo.common.utils.NetUtils=var1391, $r3=var2537}
;seq 
;cnt {}
;stmts r1 := @parameter0: io.netty.channel.Channel;	i1 = 0;	$r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	i0 = interfaceinvoke $r0.<java.util.List: int size()>();	if i1 >= i0 goto r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>();	r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>();	if r15 != null goto $r2 = (java.net.InetSocketAddress) r15;	$r2 = (java.net.InetSocketAddress) r15;	$r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>($r2);	return $r3
;block_num 4