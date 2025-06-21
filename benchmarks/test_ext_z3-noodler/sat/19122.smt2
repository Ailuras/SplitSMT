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

(declare-sort var1666 0)
(declare-sort var3078 0)
(declare-sort var3118 0)
(declare-sort var3738 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isAvailable/-2005661297 (var1666) Bool)
(declare-fun getNettyChannel/-460916855 (var1666) var3118)
(declare-fun var3118_writeAndFlush/-559963145 (var3118 var3078) var3738)
(declare-const null-var1666 var1666)
(declare-const null-var3078 var3078)
(declare-const var778 var1666) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient 
(assert (not (= var778 null-var1666)))
(declare-const var1556 var3078) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var1556 null-var3078)))
(assert true)
(define-const var1008 Bool (isAvailable/-2005661297 var778)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: boolean isAvailable()>() 
 ; Statement: if $z0 != 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: io.netty.channel.Channel getNettyChannel()>() 
(assert (not (= (ite var1008 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var3659 var3118 (getNettyChannel/-460916855 var778)) ; Statement: $r2 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: io.netty.channel.Channel getNettyChannel()>() 
(define-const var1937 var3738 (var3118_writeAndFlush/-559963145 var3659 var1556)) ; Statement: $r3 = interfaceinvoke $r2.<io.netty.channel.Channel: io.netty.channel.ChannelFuture writeAndFlush(java.lang.Object)>(r1) 
 ; Statement: return $r3 
(check-sat)
; {isAvailable/-2005661297=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient], boolean), getNettyChannel/-460916855=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient], io.netty.channel.Channel), var3118_writeAndFlush/-559963145=([io.netty.channel.Channel, java.lang.Object], io.netty.channel.ChannelFuture)}
; {var1666=org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient, var778=r0, var3078=java.lang.Object, var1556=r1, var1008=$z0, var3118=io.netty.channel.Channel, var3659=$r2, var3738=io.netty.channel.ChannelFuture, var1937=$r3}
; {org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient=var1666, r0=var778, java.lang.Object=var3078, r1=var1556, $z0=var1008, io.netty.channel.Channel=var3118, $r2=var3659, io.netty.channel.ChannelFuture=var3738, $r3=var1937}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient;	r1 := @parameter0: java.lang.Object;	$z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: boolean isAvailable()>();	if $z0 != 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: io.netty.channel.Channel getNettyChannel()>();	$r2 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: io.netty.channel.Channel getNettyChannel()>();	$r3 = interfaceinvoke $r2.<io.netty.channel.Channel: io.netty.channel.ChannelFuture writeAndFlush(java.lang.Object)>(r1);	return $r3
;block_num 2