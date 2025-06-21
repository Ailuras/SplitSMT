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

(declare-sort var3163 0)
(declare-sort var2820 0)
(declare-sort var3817 0)
(declare-sort var1085 0)
(declare-sort var3982 0)
(declare-sort var2682 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2820_size/-959786421 (var2820) Int)
(declare-fun var3163_remoteAddress/-1514271323 (var3163) var1085)
(declare-fun cast-from-var1085-to-var3982 (var1085) var3982)
(declare-fun var2682_toAddressString/-2067247090 (var3982) String)
(declare-const null-var3163 var3163)
(declare-const var3817-ACCESSORS var2820)
(declare-const null-var3982 var3982)
(declare-const var2463 var3163) ; Statement: r1 := @parameter0: io.netty.channel.Channel 
(assert (not (= var2463 null-var3163)))
(define-const var2893 Int 0) ; Statement: i1 = 0 
(define-const var1360 var2820 var3817-ACCESSORS) ; Statement: $r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var3195 Int (var2820_size/-959786421 var1360)) ; Statement: i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(assert (>= var2893 var3195)) ; Cond: i1 >= i0 
(define-const var2483 var1085 (var3163_remoteAddress/-1514271323 var2463)) ; Statement: $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(define-const var1430 var3982 (cast-from-var1085-to-var3982 var2483)) ; Statement: r15 = (java.net.InetSocketAddress) $r2 
 ; Statement: if r15 != null goto $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r15) 
(assert (not (= var1430 null-var3982))) ; Cond: r15 != null 
(define-const var2775 String (var2682_toAddressString/-2067247090 var1430)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r15) 
 ; Statement: return $r3 
(check-sat)
; {var2820_size/-959786421=([java.util.List], int), var3163_remoteAddress/-1514271323=([io.netty.channel.Channel], java.net.SocketAddress), cast-from-var1085-to-var3982=([java.net.SocketAddress], java.net.InetSocketAddress), var2682_toAddressString/-2067247090=([java.net.InetSocketAddress], java.lang.String)}
; {var3163=io.netty.channel.Channel, var2463=r1, var2893=i1, var2820=java.util.List, var3817=org.apache.dubbo.remoting.transport.netty4.AddressUtils, var1360=$r0, var3195=i0, var1085=java.net.SocketAddress, var2483=$r2, var3982=java.net.InetSocketAddress, var1430=r15, var2682=org.apache.dubbo.common.utils.NetUtils, var2775=$r3}
; {io.netty.channel.Channel=var3163, r1=var2463, i1=var2893, java.util.List=var2820, org.apache.dubbo.remoting.transport.netty4.AddressUtils=var3817, $r0=var1360, i0=var3195, java.net.SocketAddress=var1085, $r2=var2483, java.net.InetSocketAddress=var3982, r15=var1430, org.apache.dubbo.common.utils.NetUtils=var2682, $r3=var2775}
;seq 
;cnt {}
;stmts r1 := @parameter0: io.netty.channel.Channel;	i1 = 0;	$r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	i0 = interfaceinvoke $r0.<java.util.List: int size()>();	if i1 >= i0 goto $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	$r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	r15 = (java.net.InetSocketAddress) $r2;	if r15 != null goto $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r15);	$r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r15);	return $r3
;block_num 4