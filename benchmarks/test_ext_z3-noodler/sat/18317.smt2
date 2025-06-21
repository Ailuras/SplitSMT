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

(declare-sort var715 0)
(declare-sort var735 0)
(declare-sort var1224 0)
(declare-sort var2831 0)
(declare-sort var728 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var735_size/-959786421 (var735) Int)
(declare-fun var715_remoteAddress/-1514271323 (var715) var2831)
(declare-fun cast-from-var2831-to-var728 (var2831) var728)
(declare-const null-var715 var715)
(declare-const var1224-ACCESSORS var735)
(declare-const null-var728 var728)
(declare-const var68 var715) ; Statement: r1 := @parameter0: io.netty.channel.Channel 
(assert (not (= var68 null-var715)))
(define-const var838 Int 0) ; Statement: i1 = 0 
(define-const var1355 var735 var1224-ACCESSORS) ; Statement: $r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var441 Int (var735_size/-959786421 var1355)) ; Statement: i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(assert (>= var838 var441)) ; Cond: i1 >= i0 
(define-const var1223 var2831 (var715_remoteAddress/-1514271323 var68)) ; Statement: $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(define-const var1492 var728 (cast-from-var2831-to-var728 var1223)) ; Statement: r15 = (java.net.InetSocketAddress) $r2 
 ; Statement: if r15 != null goto $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r15) 
(assert (not (not (= var1492 null-var728)))) ; Negate: Cond: r15 != null  
 ; Statement: return "UNKNOWN" 
(check-sat)
; {var735_size/-959786421=([java.util.List], int), var715_remoteAddress/-1514271323=([io.netty.channel.Channel], java.net.SocketAddress), cast-from-var2831-to-var728=([java.net.SocketAddress], java.net.InetSocketAddress)}
; {var715=io.netty.channel.Channel, var68=r1, var838=i1, var735=java.util.List, var1224=org.apache.dubbo.remoting.transport.netty4.AddressUtils, var1355=$r0, var441=i0, var2831=java.net.SocketAddress, var1223=$r2, var728=java.net.InetSocketAddress, var1492=r15}
; {io.netty.channel.Channel=var715, r1=var68, i1=var838, java.util.List=var735, org.apache.dubbo.remoting.transport.netty4.AddressUtils=var1224, $r0=var1355, i0=var441, java.net.SocketAddress=var2831, $r2=var1223, java.net.InetSocketAddress=var728, r15=var1492}
;seq 
;cnt {}
;stmts r1 := @parameter0: io.netty.channel.Channel;	i1 = 0;	$r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	i0 = interfaceinvoke $r0.<java.util.List: int size()>();	if i1 >= i0 goto $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	$r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	r15 = (java.net.InetSocketAddress) $r2;	if r15 != null goto $r3 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r15);	return "UNKNOWN"
;block_num 4