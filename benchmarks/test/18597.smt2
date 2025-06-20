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

(declare-sort var684 0)
(declare-sort var2785 0)
(declare-sort var3294 0)
(declare-sort var3288 0)
(declare-sort var3454 0)
(declare-sort var3616 0)
(declare-sort var2250 0)
(declare-sort var820 0)
(declare-sort var68 0)
(declare-sort var3076 0)
(declare-sort var2021 0)
(declare-sort var1835 0)
(declare-sort var3352 0)
(declare-sort var3824 0)
(declare-sort var2178 0)
(declare-sort var3501 0)
(declare-sort var3001 0)
(declare-sort var2175 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2021!class ClassObject)
(declare-fun var3616-init () var3616)
(declare-fun protocols/1765886835 (var684) var2250)
(declare-fun var2250_keySet/-712633290 (var2250) var820)
(declare-fun <init>/1161881499 (var3616 var68) void)
(declare-fun cast-from-var820-to-var68 (var820) var68)
(declare-fun urlMapper/1765886835 (var684) var2250)
(declare-fun var820_retainAll/446284003 (var820 var68) Bool)
(declare-fun cast-from-var3616-to-var820 (var3616) var820)
(declare-fun var820_iterator/1911472585 (var820) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun readableBytes/-922465106 (var3454) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun readBytes/-732001956 (var3454 (Array Int Int)) var3454)
(declare-fun getApplicationModel/969163997 (var3294) var3076)
(declare-fun getSupportedExtensions/-542929121 (var1835 ClassObject) var820)
(declare-fun cast-from-var3076-to-var1835 (var3076) var1835)
(declare-fun arr-var3824-init () (Array Int var3824))
(declare-fun var2785_channel/-1990826581 (var2785) var2178)
(declare-fun var2178_remoteAddress/-1514271323 (var2178) var3501)
(declare-fun cast-from-var3501-to-var3824 (var3501) var3824)
(declare-fun var3001_bytes2hex/334228684 ((Array Int Int)) String)
(declare-fun cast-from-String-to-var3824 (String) var3824)
(declare-fun cast-from-var820-to-var3824 (var820) var3824)
(declare-fun String_format/1339386452 (String (Array Int var3824)) String)
(declare-fun var3352_error/-110665684 (var3352 String String String String) void)
(declare-fun clear/230688602 (var3454) var3454)
(declare-fun var2785_close/780824979 (var2785) var2175)
(declare-const null-var684 var684)
(declare-const null-var2785 var2785)
(declare-const null-var3294 var3294)
(declare-const null-var3288 var3288)
(declare-const null-var3454 var3454)
(declare-const var684-LOGGER var3352)
(declare-const null-__Array__Int__var3824__ (Array Int var3824))
(declare-const var2446 var684) ; Statement: r1 := @this: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler 
(assert (not (= var2446 null-var684)))
(declare-const var2249 var2785) ; Statement: r10 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var2249 null-var2785)))
(declare-const var3618 var3294) ; Statement: r7 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3618 null-var3294)))
(declare-const var1916 var3288) ; Statement: r32 := @parameter2: org.apache.dubbo.remoting.transport.netty4.NettyChannel 
(assert (not (= var1916 null-var3288)))
(declare-const var91 var3454) ; Statement: r6 := @parameter3: io.netty.buffer.ByteBuf 
(assert (not (= var91 null-var3454)))
(define-const var88 var3616 var3616-init) ; Statement: $r39 = new java.util.HashSet 
(define-const var248 var2250 (protocols/1765886835 var2446)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: java.util.Map protocols> 
(define-const var3022 var820 (var2250_keySet/-712633290 var248)) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.util.Set keySet()>() 
(assert true)
;(assert (<init>/1161881499 var88 (cast-from-var820-to-var68 var3022))) ; Statement: specialinvoke $r39.<java.util.HashSet: void <init>(java.util.Collection)>($r3) 

(declare-const var88!1 var3616)
(declare-const var3022!1 var820)
(define-const var69 var2250 (urlMapper/1765886835 var2446)) ; Statement: $r4 = r1.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: java.util.Map urlMapper> 
(define-const var2908 var820 (var2250_keySet/-712633290 var69)) ; Statement: $r5 = interfaceinvoke $r4.<java.util.Map: java.util.Set keySet()>() 
;(assert (var820_retainAll/446284003 (cast-from-var3616-to-var820 var88!1) (cast-from-var820-to-var68 var2908))) ; Statement: interfaceinvoke $r39.<java.util.Set: boolean retainAll(java.util.Collection)>($r5) 

(declare-const var88!2 var3616)
(declare-const var2908!1 var820)
(define-const var1799 Iterator (var820_iterator/1911472585 (cast-from-var3616-to-var820 var88!2))) ; Statement: r35 = interfaceinvoke $r39.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var178 Bool (Iterator_hasNext/-1669924200 var1799)) ; Statement: $z0 = interfaceinvoke r35.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke r6.<io.netty.buffer.ByteBuf: int readableBytes()>() 
(assert (= (ite var178 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var634 Int (readableBytes/-922465106 var91)) ; Statement: $i0 = virtualinvoke r6.<io.netty.buffer.ByteBuf: int readableBytes()>() 
(define-const var2255 (Array Int Int) arr-Int-init) ; Statement: r37 = newarray (byte)[$i0] 
(assert true)
;(assert (readBytes/-732001956 var91 var2255)) ; Statement: virtualinvoke r6.<io.netty.buffer.ByteBuf: io.netty.buffer.ByteBuf readBytes(byte[])>(r37) 

(declare-const var91!1 var3454)
(declare-const var2255!1 (Array Int Int))
(assert true)
(define-const var1506 var3076 (getApplicationModel/969163997 var3618)) ; Statement: $r8 = virtualinvoke r7.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1261 var820 (getSupportedExtensions/-542929121 (cast-from-var3076-to-var1835 var1506) var2021!class)) ; Statement: r38 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: java.util.Set getSupportedExtensions(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/api/WireProtocol;") 
(define-const var1762 var3352 var684-LOGGER) ; Statement: $r11 = <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var3877 (Array Int var3824) arr-var3824-init) ; Statement: $r9 = newarray (java.lang.Object)[3] 
(define-const var2247 var2178 (var2785_channel/-1990826581 var2249)) ; Statement: $r12 = interfaceinvoke r10.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(define-const var656 var3501 (var2178_remoteAddress/-1514271323 var2247)) ; Statement: $r13 = interfaceinvoke $r12.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(declare-const var3877!1 (Array Int var3824))
(assert (not (= var3877!1 null-__Array__Int__var3824__)))
(assert (= (select var3877!1 0) (cast-from-var3501-to-var3824 var656))) ; Statement: $r9[0] = $r13 
(define-const var1807 String (var3001_bytes2hex/334228684 var2255!1)) ; Statement: $r14 = staticinvoke <org.apache.dubbo.common.io.Bytes: java.lang.String bytes2hex(byte[])>(r37) 
(declare-const var3877!2 (Array Int var3824))
(assert (not (= var3877!2 null-__Array__Int__var3824__)))
(assert (= (select var3877!2 1) (cast-from-String-to-var3824 var1807))) ; Statement: $r9[1] = $r14 
(declare-const var3877!3 (Array Int var3824))
(assert (not (= var3877!3 null-__Array__Int__var3824__)))
(assert (= (select var3877!3 2) (cast-from-var820-to-var3824 var1261))) ; Statement: $r9[2] = r38 
(define-const var3884 String (String_format/1339386452 "Can not recognize protocol from downstream=%s . preface=%s protocols=%s" var3877!3)) ; Statement: $r15 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Can not recognize protocol from downstream=%s . preface=%s protocols=%s", $r9) 
;(assert (var3352_error/-110665684 var1762 "99-0" "unknown error in remoting module" "" var3884)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "unknown error in remoting module", "", $r15) 

(declare-const var1762!1 var3352)
(declare-const var1818 String)
(declare-const var3495 String)
(declare-const var686 String)
(declare-const var3884!1 String)
(assert true)
;(assert (clear/230688602 var91!1)) ; Statement: virtualinvoke r6.<io.netty.buffer.ByteBuf: io.netty.buffer.ByteBuf clear()>() 

(declare-const var91!2 var3454)
;(assert (var2785_close/780824979 var2249)) ; Statement: interfaceinvoke r10.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var2249!1 var2785)
 ; Statement: return 
(check-sat)
; {var3616-init=([], java.util.HashSet), protocols/1765886835=([org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler], java.util.Map), var2250_keySet/-712633290=([java.util.Map], java.util.Set), <init>/1161881499=([java.util.HashSet, java.util.Collection], void), cast-from-var820-to-var68=([java.util.Set], java.util.Collection), urlMapper/1765886835=([org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler], java.util.Map), var820_retainAll/446284003=([java.util.Set, java.util.Collection], boolean), cast-from-var3616-to-var820=([java.util.HashSet], java.util.Set), var820_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), readableBytes/-922465106=([io.netty.buffer.ByteBuf], int), arr-Int-init=([], byte[]), readBytes/-732001956=([io.netty.buffer.ByteBuf, byte[]], io.netty.buffer.ByteBuf), getApplicationModel/969163997=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), getSupportedExtensions/-542929121=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], java.util.Set), cast-from-var3076-to-var1835=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), arr-var3824-init=([], java.lang.Object[]), var2785_channel/-1990826581=([io.netty.channel.ChannelHandlerContext], io.netty.channel.Channel), var2178_remoteAddress/-1514271323=([io.netty.channel.Channel], java.net.SocketAddress), cast-from-var3501-to-var3824=([java.net.SocketAddress], java.lang.Object), var3001_bytes2hex/334228684=([byte[]], java.lang.String), cast-from-String-to-var3824=([java.lang.String], java.lang.Object), cast-from-var820-to-var3824=([java.util.Set], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3352_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), clear/230688602=([io.netty.buffer.ByteBuf], io.netty.buffer.ByteBuf), var2785_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture)}
; {var684=org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler, var2446=r1, var2785=io.netty.channel.ChannelHandlerContext, var2249=r10, var3294=org.apache.dubbo.common.URL, var3618=r7, var3288=org.apache.dubbo.remoting.transport.netty4.NettyChannel, var1916=r32, var3454=io.netty.buffer.ByteBuf, var91=r6, var3616=java.util.HashSet, var88=$r39, var2250=java.util.Map, var248=$r2, var820=java.util.Set, var3022=$r3, var68=java.util.Collection, var69=$r4, var2908=$r5, var1799=r35, var178=$z0, var634=$i0, var2255=r37, var3076=org.apache.dubbo.rpc.model.ApplicationModel, var1506=$r8, var2021=org.apache.dubbo.remoting.api.WireProtocol, var1835=org.apache.dubbo.common.extension.ExtensionAccessor, var1261=r38, var3352=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1762=$r11, var3824=java.lang.Object, var3877=$r9, var2178=io.netty.channel.Channel, var2247=$r12, var3501=java.net.SocketAddress, var656=$r13, var3001=org.apache.dubbo.common.io.Bytes, var1807=$r14, var3884=$r15, var1818="99-0", var3495="unknown error in remoting module", var686="", var2175=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler=var684, r1=var2446, io.netty.channel.ChannelHandlerContext=var2785, r10=var2249, org.apache.dubbo.common.URL=var3294, r7=var3618, org.apache.dubbo.remoting.transport.netty4.NettyChannel=var3288, r32=var1916, io.netty.buffer.ByteBuf=var3454, r6=var91, java.util.HashSet=var3616, $r39=var88, java.util.Map=var2250, $r2=var248, java.util.Set=var820, $r3=var3022, java.util.Collection=var68, $r4=var69, $r5=var2908, r35=var1799, $z0=var178, $i0=var634, r37=var2255, org.apache.dubbo.rpc.model.ApplicationModel=var3076, $r8=var1506, org.apache.dubbo.remoting.api.WireProtocol=var2021, org.apache.dubbo.common.extension.ExtensionAccessor=var1835, r38=var1261, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3352, $r11=var1762, java.lang.Object=var3824, $r9=var3877, io.netty.channel.Channel=var2178, $r12=var2247, java.net.SocketAddress=var3501, $r13=var656, org.apache.dubbo.common.io.Bytes=var3001, $r14=var1807, $r15=var3884, "99-0"=var1818, "unknown error in remoting module"=var3495, ""=var686, io.netty.channel.ChannelFuture=var2175}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler;	r10 := @parameter0: io.netty.channel.ChannelHandlerContext;	r7 := @parameter1: org.apache.dubbo.common.URL;	r32 := @parameter2: org.apache.dubbo.remoting.transport.netty4.NettyChannel;	r6 := @parameter3: io.netty.buffer.ByteBuf;	$r39 = new java.util.HashSet;	$r2 = r1.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: java.util.Map protocols>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.util.Set keySet()>();	specialinvoke $r39.<java.util.HashSet: void <init>(java.util.Collection)>($r3);	$r4 = r1.<org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: java.util.Map urlMapper>;	$r5 = interfaceinvoke $r4.<java.util.Map: java.util.Set keySet()>();	interfaceinvoke $r39.<java.util.Set: boolean retainAll(java.util.Collection)>($r5);	r35 = interfaceinvoke $r39.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r35.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $i0 = virtualinvoke r6.<io.netty.buffer.ByteBuf: int readableBytes()>();	$i0 = virtualinvoke r6.<io.netty.buffer.ByteBuf: int readableBytes()>();	r37 = newarray (byte)[$i0];	virtualinvoke r6.<io.netty.buffer.ByteBuf: io.netty.buffer.ByteBuf readBytes(byte[])>(r37);	$r8 = virtualinvoke r7.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	r38 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: java.util.Set getSupportedExtensions(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/api/WireProtocol;");	$r11 = <org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r9 = newarray (java.lang.Object)[3];	$r12 = interfaceinvoke r10.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r13 = interfaceinvoke $r12.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	$r9[0] = $r13;	$r14 = staticinvoke <org.apache.dubbo.common.io.Bytes: java.lang.String bytes2hex(byte[])>(r37);	$r9[1] = $r14;	$r9[2] = r38;	$r15 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Can not recognize protocol from downstream=%s . preface=%s protocols=%s", $r9);	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "unknown error in remoting module", "", $r15);	virtualinvoke r6.<io.netty.buffer.ByteBuf: io.netty.buffer.ByteBuf clear()>();	interfaceinvoke r10.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	return
;block_num 3