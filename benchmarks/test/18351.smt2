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

(declare-sort var1395 0)
(declare-sort var3479 0)
(declare-sort var1496 0)
(declare-sort var2387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3479_size/-959786421 (var3479) Int)
(declare-fun var1395_localAddress/1290099742 (var1395) var2387)
(declare-const null-var1395 var1395)
(declare-const var1496-ACCESSORS var3479)
(declare-const null-var2387 var2387)
(declare-const var693 var1395) ; Statement: r1 := @parameter0: io.netty.channel.Channel 
(assert (not (= var693 null-var1395)))
(define-const var2362 Int 0) ; Statement: i1 = 0 
(define-const var1877 var3479 var1496-ACCESSORS) ; Statement: $r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var3620 Int (var3479_size/-959786421 var1877)) ; Statement: i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>() 
(assert (>= var2362 var3620)) ; Cond: i1 >= i0 
(define-const var1003 var2387 (var1395_localAddress/1290099742 var693)) ; Statement: r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>() 
 ; Statement: if r15 != null goto $r2 = (java.net.InetSocketAddress) r15 
(assert (not (not (= var1003 null-var2387)))) ; Negate: Cond: r15 != null  
 ; Statement: return "UNKNOWN" 
(check-sat)
; {var3479_size/-959786421=([java.util.List], int), var1395_localAddress/1290099742=([io.netty.channel.Channel], java.net.SocketAddress)}
; {var1395=io.netty.channel.Channel, var693=r1, var2362=i1, var3479=java.util.List, var1496=org.apache.dubbo.remoting.transport.netty4.AddressUtils, var1877=$r0, var3620=i0, var2387=java.net.SocketAddress, var1003=r15}
; {io.netty.channel.Channel=var1395, r1=var693, i1=var2362, java.util.List=var3479, org.apache.dubbo.remoting.transport.netty4.AddressUtils=var1496, $r0=var1877, i0=var3620, java.net.SocketAddress=var2387, r15=var1003}
;seq 
;cnt {}
;stmts r1 := @parameter0: io.netty.channel.Channel;	i1 = 0;	$r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	i0 = interfaceinvoke $r0.<java.util.List: int size()>();	if i1 >= i0 goto r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>();	r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>();	if r15 != null goto $r2 = (java.net.InetSocketAddress) r15;	return "UNKNOWN"
;block_num 4