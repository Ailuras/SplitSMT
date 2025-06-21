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

(declare-sort var3367 0)
(declare-sort var3508 0)
(declare-sort var302 0)
(declare-sort var796 0)
(declare-sort var1950 0)
(declare-sort var265 0)
(declare-sort var3236 0)
(declare-sort var887 0)
(declare-sort var3719 0)
(declare-sort var3444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3508_channel/-1990826581 (var3508) var796)
(declare-fun this$0/505167680 (var3367) var1950)
(declare-fun var1950_access$000/-444661539 (var1950) var265)
(declare-fun var1950_access$100/-1766482208 (var1950) var3236)
(declare-fun var887_getOrAddChannel/1948297356 (var796 var265 var3236) var887)
(declare-fun var3508_alloc/754691875 (var3508) var3719)
(declare-fun var3719_buffer/-1147816974 (var3719) var3444)
(declare-fun var1950_access$200/720048426 (var1950 var3508 var265 var887 var3444) void)
(declare-const null-var3367 var3367)
(declare-const null-var3508 var3508)
(declare-const null-String String)
(declare-const var1683 var3367) ; Statement: r3 := @this: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1 
(assert (not (= var1683 null-var3367)))
(declare-const var1467 var3508) ; Statement: r2 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var1467 null-var3508)))
(declare-const var2039 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2039 null-String)))
(define-const var3045 String "h2") ; Statement: $r1 = "h2" 
(assert true)
(define-const var1408 Bool (= var3045 var2039)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 != 0 goto $r8 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(assert (not (= (ite var1408 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2306 var796 (var3508_channel/-1990826581 var1467)) ; Statement: $r8 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(define-const var471 var1950 (this$0/505167680 var1683)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0> 
(define-const var1664 var265 (var1950_access$000/-444661539 var471)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.common.URL access$000(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler)>($r4) 
(define-const var2453 var1950 (this$0/505167680 var1683)) ; Statement: $r5 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0> 
(define-const var3925 var3236 (var1950_access$100/-1766482208 var2453)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.remoting.ChannelHandler access$100(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler)>($r5) 
(define-const var1588 var887 (var887_getOrAddChannel/1948297356 var2306 var1664 var3925)) ; Statement: r9 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyChannel: org.apache.dubbo.remoting.transport.netty4.NettyChannel getOrAddChannel(io.netty.channel.Channel,org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>($r8, $r7, $r6) 
(define-const var1011 var3719 (var3508_alloc/754691875 var1467)) ; Statement: $r10 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.buffer.ByteBufAllocator alloc()>() 
(define-const var3138 var3444 (var3719_buffer/-1147816974 var1011)) ; Statement: r11 = interfaceinvoke $r10.<io.netty.buffer.ByteBufAllocator: io.netty.buffer.ByteBuf buffer()>() 
(define-const var3129 var1950 (this$0/505167680 var1683)) ; Statement: $r13 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0> 
(define-const var992 var1950 (this$0/505167680 var1683)) ; Statement: $r12 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0> 
(define-const var501 var265 (var1950_access$000/-444661539 var992)) ; Statement: $r14 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.common.URL access$000(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler)>($r12) 
;(assert (var1950_access$200/720048426 var3129 var1467 var501 var1588 var3138)) ; Statement: staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: void access$200(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler,io.netty.channel.ChannelHandlerContext,org.apache.dubbo.common.URL,org.apache.dubbo.remoting.transport.netty4.NettyChannel,io.netty.buffer.ByteBuf)>($r13, r2, $r14, r9, r11) 

(declare-const var3129!1 var1950)
(declare-const var1467!1 var3508)
(declare-const var501!1 var265)
(declare-const var1588!1 var887)
(declare-const var3138!1 var3444)
 ; Statement: return 
(check-sat)
; {var3508_channel/-1990826581=([io.netty.channel.ChannelHandlerContext], io.netty.channel.Channel), this$0/505167680=([org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1], org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler), var1950_access$000/-444661539=([org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler], org.apache.dubbo.common.URL), var1950_access$100/-1766482208=([org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler], org.apache.dubbo.remoting.ChannelHandler), var887_getOrAddChannel/1948297356=([io.netty.channel.Channel, org.apache.dubbo.common.URL, org.apache.dubbo.remoting.ChannelHandler], org.apache.dubbo.remoting.transport.netty4.NettyChannel), var3508_alloc/754691875=([io.netty.channel.ChannelHandlerContext], io.netty.buffer.ByteBufAllocator), var3719_buffer/-1147816974=([io.netty.buffer.ByteBufAllocator], io.netty.buffer.ByteBuf), var1950_access$200/720048426=([org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler, io.netty.channel.ChannelHandlerContext, org.apache.dubbo.common.URL, org.apache.dubbo.remoting.transport.netty4.NettyChannel, io.netty.buffer.ByteBuf], void)}
; {var3367=org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1, var1683=r3, var3508=io.netty.channel.ChannelHandlerContext, var1467=r2, var2039=r0, var302=null_type, var3045=$r1, var1408=$z0, var796=io.netty.channel.Channel, var2306=$r8, var1950=org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler, var471=$r4, var265=org.apache.dubbo.common.URL, var1664=$r7, var2453=$r5, var3236=org.apache.dubbo.remoting.ChannelHandler, var3925=$r6, var887=org.apache.dubbo.remoting.transport.netty4.NettyChannel, var1588=r9, var3719=io.netty.buffer.ByteBufAllocator, var1011=$r10, var3444=io.netty.buffer.ByteBuf, var3138=r11, var3129=$r13, var992=$r12, var501=$r14}
; {org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1=var3367, r3=var1683, io.netty.channel.ChannelHandlerContext=var3508, r2=var1467, r0=var2039, null_type=var302, $r1=var3045, $z0=var1408, io.netty.channel.Channel=var796, $r8=var2306, org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler=var1950, $r4=var471, org.apache.dubbo.common.URL=var265, $r7=var1664, $r5=var2453, org.apache.dubbo.remoting.ChannelHandler=var3236, $r6=var3925, org.apache.dubbo.remoting.transport.netty4.NettyChannel=var887, r9=var1588, io.netty.buffer.ByteBufAllocator=var3719, $r10=var1011, io.netty.buffer.ByteBuf=var3444, r11=var3138, $r13=var3129, $r12=var992, $r14=var501}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1;	r2 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: java.lang.String;	$r1 = "h2";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 != 0 goto $r8 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r8 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r4 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0>;	$r7 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.common.URL access$000(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler)>($r4);	$r5 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0>;	$r6 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.remoting.ChannelHandler access$100(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler)>($r5);	r9 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyChannel: org.apache.dubbo.remoting.transport.netty4.NettyChannel getOrAddChannel(io.netty.channel.Channel,org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>($r8, $r7, $r6);	$r10 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.buffer.ByteBufAllocator alloc()>();	r11 = interfaceinvoke $r10.<io.netty.buffer.ByteBufAllocator: io.netty.buffer.ByteBuf buffer()>();	$r13 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0>;	$r12 = r3.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler this$0>;	$r14 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.common.URL access$000(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler)>($r12);	staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: void access$200(org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler,io.netty.channel.ChannelHandlerContext,org.apache.dubbo.common.URL,org.apache.dubbo.remoting.transport.netty4.NettyChannel,io.netty.buffer.ByteBuf)>($r13, r2, $r14, r9, r11);	return
;block_num 2