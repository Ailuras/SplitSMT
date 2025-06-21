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

(declare-sort var1412 0)
(declare-sort var54 0)
(declare-sort var722 0)
(declare-sort var3985 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun userEventTriggered/-1954844633 (var3985 var54 var722) void)
(declare-fun cast-from-var1412-to-var3985 (var1412) var3985)
(declare-const null-var1412 var1412)
(declare-const null-var54 var54)
(declare-const null-var722 var722)
(declare-const var2010 var1412) ; Statement: r1 := @this: org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler 
(assert (not (= var2010 null-var1412)))
(declare-const var3774 var54) ; Statement: r2 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var3774 null-var54)))
(declare-const var1708 var722) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1708 null-var722)))
(define-const var2330 Bool false) ; Statement: $z0 = r0 instanceof io.netty.handler.timeout.IdleStateEvent 
 ; Statement: if $z0 == 0 goto specialinvoke r1.<io.netty.channel.ChannelDuplexHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r2, r0) 
(assert (= (ite var2330 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (userEventTriggered/-1954844633 (cast-from-var1412-to-var3985 var2010) var3774 var1708)) ; Statement: specialinvoke r1.<io.netty.channel.ChannelDuplexHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r2, r0) 

(declare-const var2010!1 var1412)
(declare-const var3774!1 var54)
(declare-const var1708!1 var722)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {userEventTriggered/-1954844633=([io.netty.channel.ChannelDuplexHandler, io.netty.channel.ChannelHandlerContext, java.lang.Object], void), cast-from-var1412-to-var3985=([org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler], io.netty.channel.ChannelDuplexHandler)}
; {var1412=org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler, var2010=r1, var54=io.netty.channel.ChannelHandlerContext, var3774=r2, var722=java.lang.Object, var1708=r0, var2330=$z0, var3985=io.netty.channel.ChannelDuplexHandler}
; {org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler=var1412, r1=var2010, io.netty.channel.ChannelHandlerContext=var54, r2=var3774, java.lang.Object=var722, r0=var1708, $z0=var2330, io.netty.channel.ChannelDuplexHandler=var3985}
;seq 
;cnt {}
;stmts r1 := @this: org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler;	r2 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: java.lang.Object;	$z0 = r0 instanceof io.netty.handler.timeout.IdleStateEvent;	if $z0 == 0 goto specialinvoke r1.<io.netty.channel.ChannelDuplexHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r2, r0);	specialinvoke r1.<io.netty.channel.ChannelDuplexHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r2, r0);	return
;block_num 3