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

(declare-sort var3796 0)
(declare-sort var379 0)
(declare-sort var685 0)
(declare-sort var2378 0)
(declare-sort var2768 0)
(declare-sort var236 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var379_channel/-1990826581 (var379) var2378)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var685) String)
(declare-fun cast-from-var2378-to-var685 (var2378) var685)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2768_info/484404803 (var2768 String) void)
(declare-fun var2378_close/-918005992 (var2378) var236)
(declare-const null-var3796 var3796)
(declare-const null-var379 var379)
(declare-const null-var685 var685)
(declare-const var3796-log var2768)
(declare-const var1256 var3796) ; Statement: r1 := @this: org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler 
(assert (not (= var1256 null-var3796)))
(declare-const var1649 var379) ; Statement: r2 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var1649 null-var379)))
(declare-const var1307 var685) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1307 null-var685)))
(define-const var3819 Bool false) ; Statement: $z0 = r0 instanceof io.netty.handler.timeout.IdleStateEvent 
 ; Statement: if $z0 == 0 goto specialinvoke r1.<io.netty.channel.ChannelDuplexHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r2, r0) 
(assert (not (= (ite var3819 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1942 var2378 (var379_channel/-1990826581 var1649)) ; Statement: r3 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(define-const var2035 var2768 var3796-log) ; Statement: $r5 = <org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler: org.apache.dubbo.common.logger.Logger log> 
(define-const var13 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var13)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var13!1 String)
(assert (= var13!1 ""))
(assert true)
(define-const var734 String (append/672562846 var13!1 "IdleStateEvent triggered, close channel ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("IdleStateEvent triggered, close channel ") 
(declare-const var13!2 String)
(assert (= var13!2 (str.++ var13!1 "IdleStateEvent triggered, close channel ")))
(assert true)
(define-const var980 String (append/-1031950772 var734 (cast-from-var2378-to-var685 var1942))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var734!1 String)
(assert (str.prefixof var734 var734!1))
(assert true)
(define-const var3270 String (toString/-2075883882 var980)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2768_info/484404803 var2035 var3270)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r8) 

(declare-const var2035!1 var2768)
(declare-const var3270!1 String)
;(assert (var2378_close/-918005992 var1942)) ; Statement: interfaceinvoke r3.<io.netty.channel.Channel: io.netty.channel.ChannelFuture close()>() 

(declare-const var1942!1 var2378)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var379_channel/-1990826581=([io.netty.channel.ChannelHandlerContext], io.netty.channel.Channel), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2378-to-var685=([io.netty.channel.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2768_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var2378_close/-918005992=([io.netty.channel.Channel], io.netty.channel.ChannelFuture)}
; {var3796=org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler, var1256=r1, var379=io.netty.channel.ChannelHandlerContext, var1649=r2, var685=java.lang.Object, var1307=r0, var3819=$z0, var2378=io.netty.channel.Channel, var1942=r3, var2768=org.apache.dubbo.common.logger.Logger, var2035=$r5, var13=$r4, var734=$r6, var980=$r7, var3270=$r8, var236=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler=var3796, r1=var1256, io.netty.channel.ChannelHandlerContext=var379, r2=var1649, java.lang.Object=var685, r0=var1307, $z0=var3819, io.netty.channel.Channel=var2378, r3=var1942, org.apache.dubbo.common.logger.Logger=var2768, $r5=var2035, $r4=var13, $r6=var734, $r7=var980, $r8=var3270, io.netty.channel.ChannelFuture=var236}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler;	r2 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: java.lang.Object;	$z0 = r0 instanceof io.netty.handler.timeout.IdleStateEvent;	if $z0 == 0 goto specialinvoke r1.<io.netty.channel.ChannelDuplexHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r2, r0);	r3 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r5 = <org.apache.dubbo.qos.server.handler.TelnetIdleEventHandler: org.apache.dubbo.common.logger.Logger log>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("IdleStateEvent triggered, close channel ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r8);	interfaceinvoke r3.<io.netty.channel.Channel: io.netty.channel.ChannelFuture close()>();	goto [?= return];	return
;block_num 3