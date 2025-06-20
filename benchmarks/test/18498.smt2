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

(declare-sort var1497 0)
(declare-sort var1485 0)
(declare-sort var252 0)
(declare-sort var1115 0)
(declare-sort var1069 0)
(declare-sort var414 0)
(declare-sort var2716 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1069-init () (Array Int var1069))
(declare-fun var1485_channel/-1990826581 (var1485) var414)
(declare-fun cast-from-var414-to-var1069 (var414) var1069)
(declare-fun String_format/1339386452 (String (Array Int var1069)) String)
(declare-fun var1115_warn/126438324 (var1115 String String String String var252) void)
(declare-fun var1485_close/780824979 (var1485) var2716)
(declare-const null-var1497 var1497)
(declare-const null-var1485 var1485)
(declare-const null-var252 var252)
(declare-const var1497-LOGGER var1115)
(declare-const null-__Array__Int__var1069__ (Array Int var1069))
(declare-const var1580 var1497) ; Statement: r6 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler 
(assert (not (= var1580 null-var1497)))
(declare-const var2221 var1485) ; Statement: r1 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var2221 null-var1485)))
(declare-const var3689 var252) ; Statement: r4 := @parameter1: java.lang.Throwable 
(assert (not (= var3689 null-var252)))
(define-const var159 var1115 var1497-LOGGER) ; Statement: $r2 = <org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var2512 (Array Int var1069) arr-var1069-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var1818 var414 (var1485_channel/-1990826581 var2221)) ; Statement: $r3 = interfaceinvoke r1.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(declare-const var2512!1 (Array Int var1069))
(assert (not (= var2512!1 null-__Array__Int__var1069__)))
(assert (= (select var2512!1 0) (cast-from-var414-to-var1069 var1818))) ; Statement: $r0[0] = $r3 
(define-const var2506 String (String_format/1339386452 "Channel error:%s" var2512!1)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Channel error:%s", $r0) 
;(assert (var1115_warn/126438324 var159 "6-4" "" "" var2506 var3689)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-4", "", "", $r5, r4) 

(declare-const var159!1 var1115)
(declare-const var1075 String)
(declare-const var1574 String)
(declare-const var1574!1 String)
(declare-const var2506!1 String)
(declare-const var3689!1 var252)
;(assert (var1485_close/780824979 var2221)) ; Statement: interfaceinvoke r1.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var2221!1 var1485)
 ; Statement: return 
(check-sat)
; {arr-var1069-init=([], java.lang.Object[]), var1485_channel/-1990826581=([io.netty.channel.ChannelHandlerContext], io.netty.channel.Channel), cast-from-var414-to-var1069=([io.netty.channel.Channel], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var1115_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var1485_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture)}
; {var1497=org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler, var1580=r6, var1485=io.netty.channel.ChannelHandlerContext, var2221=r1, var252=java.lang.Throwable, var3689=r4, var1115=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var159=$r2, var1069=java.lang.Object, var2512=$r0, var414=io.netty.channel.Channel, var1818=$r3, var2506=$r5, var1075="6-4", var1574="", var2716=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler=var1497, r6=var1580, io.netty.channel.ChannelHandlerContext=var1485, r1=var2221, java.lang.Throwable=var252, r4=var3689, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1115, $r2=var159, java.lang.Object=var1069, $r0=var2512, io.netty.channel.Channel=var414, $r3=var1818, $r5=var2506, "6-4"=var1075, ""=var1574, io.netty.channel.ChannelFuture=var2716}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r6 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler;	r1 := @parameter0: io.netty.channel.ChannelHandlerContext;	r4 := @parameter1: java.lang.Throwable;	$r2 = <org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r0 = newarray (java.lang.Object)[1];	$r3 = interfaceinvoke r1.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r0[0] = $r3;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Channel error:%s", $r0);	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-4", "", "", $r5, r4);	interfaceinvoke r1.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	return
;block_num 1