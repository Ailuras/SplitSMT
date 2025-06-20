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

(declare-sort var1549 0)
(declare-sort var389 0)
(declare-sort var2439 0)
(declare-sort var3716 0)
(declare-sort var2879 0)
(declare-sort var967 0)
(declare-sort var2935 0)
(declare-sort var3226 0)
(declare-sort var3945 0)
(declare-sort var1669 0)
(declare-sort var1575 0)
(declare-sort var3152 0)
(declare-sort var2521 0)
(declare-sort var2025 0)
(declare-sort var712 0)
(declare-sort var2903 0)
(declare-sort var846 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3945!class ClassObject)
(declare-fun channel/-1159611082 (var1549) var2439)
(declare-fun var2879_getUrl/938756954 (var2879) var3716)
(declare-fun cast-from-var2439-to-var2879 (var2439) var2879)
(declare-fun getParameter/-1307325648 (var3716 String) String)
(declare-fun var967_isEmpty/-813097145 (String) Bool)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var3716) var2935)
(declare-fun getExtensionLoader/-514331157 (var1669 ClassObject) var3226)
(declare-fun cast-from-var2935-to-var1669 (var2935) var1669)
(declare-fun hasExtension/-1450549355 (var3226 String) Bool)
(declare-fun getExtension/-1809037860 (var3226 String) var1575)
(declare-fun cast-from-var1575-to-var3945 (var1575) var3945)
(declare-fun var389_iterator/-912451715 (var389) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun isClientSide/318192039 (var1549 var2439) Bool)
(declare-fun var3152-init () var3152)
(declare-fun handler/-1159611082 (var1549) var2521)
(declare-fun <init>/-1863883418 (var3152 var3716 var2521) void)
(declare-fun cast-from-var2439-to-var2025 (var2439) var2025)
(declare-fun getNioChannel/-306675305 (var2025) var712)
(declare-fun var712_pipeline/-2095655993 (var712) var2903)
(declare-fun cast-from-__Array__Int__var846__-to-__Array__Int__var1575__ ((Array Int var846)) (Array Int var1575))
(declare-fun arr-var846-init () (Array Int var846))
(declare-fun cast-from-var3152-to-var1575 (var3152) var1575)
(declare-fun cast-from-__Array__Int__var1575__-to-__Array__Int__var846__ ((Array Int var1575)) (Array Int var846))
(declare-fun var2903_addLast/1556541530 (var2903 (Array Int var846)) var2903)
(declare-const null-var1549 var1549)
(declare-const null-var389 var389)
(declare-const null-__Array__Int__var1575__ (Array Int var1575))
(declare-const var1425 var1549) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator 
(assert (not (= var1425 null-var1549)))
(declare-const var726 var389) ; Statement: r10 := @parameter0: java.util.List 
(assert (not (= var726 null-var389)))
(define-const var3789 var2439 (channel/-1159611082 var1425)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(define-const var252 var3716 (var2879_getUrl/938756954 (cast-from-var2439-to-var2879 var3789))) ; Statement: r2 = interfaceinvoke $r1.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2324 String (getParameter/-1307325648 var252 "codec")) ; Statement: r49 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec") 
(define-const var3149 Bool (var967_isEmpty/-813097145 var2324)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r49) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert (= (ite var3149 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1958 var2935 (getOrDefaultFrameworkModel/-1637556979 var252)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var808 var3226 (getExtensionLoader/-514331157 (cast-from-var2935-to-var1669 var1958) var3945!class)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var2817 Bool (hasExtension/-1450549355 var808 var2324)) ; Statement: $z1 = virtualinvoke $r4.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r49) 
 ; Statement: if $z1 == 0 goto $r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert (not (= (ite var2817 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1343 var2935 (getOrDefaultFrameworkModel/-1637556979 var252)) ; Statement: $r46 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var3297 var3226 (getExtensionLoader/-514331157 (cast-from-var2935-to-var1669 var1343) var3945!class)) ; Statement: $r47 = virtualinvoke $r46.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var812 var1575 (getExtension/-1809037860 var3297 var2324)) ; Statement: $r48 = virtualinvoke $r47.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r49) 
(define-const var3234 var3945 (cast-from-var1575-to-var3945 var812)) ; Statement: r50 = (org.apache.dubbo.remoting.Codec2) $r48 
 ; Statement: goto [?= $z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec] 
(assert true) ; Non Conditional
(define-const var2721 Bool true) ; Statement: $z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec 
 ; Statement: if $z5 != 0 goto $r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>() 
(assert (not (= (ite var2721 1 0) 0))) ; Cond: $z5 != 0 
(define-const var259 Iterator (var389_iterator/-912451715 var726)) ; Statement: $r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var621 Bool (Iterator_hasNext/-1669924200 var259)) ; Statement: $z6 = interfaceinvoke $r40.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z6 == 0 goto $r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(assert (= (ite var621 1 0) 0)) ; Cond: $z6 == 0 
(define-const var1817 var2439 (channel/-1159611082 var1425)) ; Statement: $r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(assert true)
(define-const var1291 Bool (isClientSide/318192039 var1425 var1817)) ; Statement: $z3 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: boolean isClientSide(org.apache.dubbo.remoting.Channel)>($r11) 
 ; Statement: if $z3 == 0 goto $r53 = new org.apache.dubbo.remoting.transport.netty4.NettyServerHandler 
(assert (= (ite var1291 1 0) 0)) ; Cond: $z3 == 0 
(define-const var2049 var3152 var3152-init) ; Statement: $r53 = new org.apache.dubbo.remoting.transport.netty4.NettyServerHandler 
(define-const var1596 var2439 (channel/-1159611082 var1425)) ; Statement: $r13 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(define-const var3752 var3716 (var2879_getUrl/938756954 (cast-from-var2439-to-var2879 var1596))) ; Statement: $r15 = interfaceinvoke $r13.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(define-const var875 var2521 (handler/-1159611082 var1425)) ; Statement: $r14 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.ChannelHandler handler> 
(assert true)
;(assert (<init>/-1863883418 var2049 var3752 var875)) ; Statement: specialinvoke $r53.<org.apache.dubbo.remoting.transport.netty4.NettyServerHandler: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>($r15, $r14) 

(declare-const var2049!1 var3152)
(declare-const var3752!1 var3716)
(declare-const var875!1 var2521)
(define-const var2107 var2439 (channel/-1159611082 var1425)) ; Statement: $r16 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(define-const var3027 var2025 (cast-from-var2439-to-var2025 var2107)) ; Statement: $r17 = (org.apache.dubbo.remoting.transport.netty4.NettyChannel) $r16 
(assert true)
(define-const var731 var712 (getNioChannel/-306675305 var3027)) ; Statement: $r18 = virtualinvoke $r17.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: io.netty.channel.Channel getNioChannel()>() 
(define-const var2601 var2903 (var712_pipeline/-2095655993 var731)) ; Statement: $r20 = interfaceinvoke $r18.<io.netty.channel.Channel: io.netty.channel.ChannelPipeline pipeline()>() 
(define-const var3257 (Array Int var1575) (cast-from-__Array__Int__var846__-to-__Array__Int__var1575__ arr-var846-init)) ; Statement: $r19 = newarray (io.netty.channel.ChannelHandler)[1] 
(declare-const var3257!1 (Array Int var1575))
(assert (not (= var3257!1 null-__Array__Int__var1575__)))
(assert (= (select var3257!1 0) (cast-from-var3152-to-var1575 var2049!1))) ; Statement: $r19[0] = $r53 
(define-const var2697 (Array Int var846) (cast-from-__Array__Int__var1575__-to-__Array__Int__var846__ var3257!1)) ; Statement: $r54 = (io.netty.channel.ChannelHandler[]) $r19 
;(assert (var2903_addLast/1556541530 var2601 var2697)) ; Statement: interfaceinvoke $r20.<io.netty.channel.ChannelPipeline: io.netty.channel.ChannelPipeline addLast(io.netty.channel.ChannelHandler[])>($r54) 

(declare-const var2601!1 var2903)
(declare-const var2697!1 (Array Int var846))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {channel/-1159611082=([org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator], org.apache.dubbo.remoting.Channel), var2879_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var2439-to-var2879=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var967_isEmpty/-813097145=([java.lang.String], boolean), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2935-to-var1669=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var1575-to-var3945=([java.lang.Object], org.apache.dubbo.remoting.Codec2), var389_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), isClientSide/318192039=([org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator, org.apache.dubbo.remoting.Channel], boolean), var3152-init=([], org.apache.dubbo.remoting.transport.netty4.NettyServerHandler), handler/-1159611082=([org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator], org.apache.dubbo.remoting.ChannelHandler), <init>/-1863883418=([org.apache.dubbo.remoting.transport.netty4.NettyServerHandler, org.apache.dubbo.common.URL, org.apache.dubbo.remoting.ChannelHandler], void), cast-from-var2439-to-var2025=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.transport.netty4.NettyChannel), getNioChannel/-306675305=([org.apache.dubbo.remoting.transport.netty4.NettyChannel], io.netty.channel.Channel), var712_pipeline/-2095655993=([io.netty.channel.Channel], io.netty.channel.ChannelPipeline), cast-from-__Array__Int__var846__-to-__Array__Int__var1575__=([io.netty.channel.ChannelHandler[]], java.lang.Object[]), arr-var846-init=([], io.netty.channel.ChannelHandler[]), cast-from-var3152-to-var1575=([org.apache.dubbo.remoting.transport.netty4.NettyServerHandler], java.lang.Object), cast-from-__Array__Int__var1575__-to-__Array__Int__var846__=([java.lang.Object[]], io.netty.channel.ChannelHandler[]), var2903_addLast/1556541530=([io.netty.channel.ChannelPipeline, io.netty.channel.ChannelHandler[]], io.netty.channel.ChannelPipeline)}
; {var1549=org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator, var1425=r0, var389=java.util.List, var726=r10, var2439=org.apache.dubbo.remoting.Channel, var3789=$r1, var3716=org.apache.dubbo.common.URL, var2879=org.apache.dubbo.remoting.Endpoint, var252=r2, var2324=r49, var967=org.apache.dubbo.common.utils.StringUtils, var3149=$z0, var2935=org.apache.dubbo.rpc.model.FrameworkModel, var1958=$r3, var3226=org.apache.dubbo.common.extension.ExtensionLoader, var3945=org.apache.dubbo.remoting.Codec2, var1669=org.apache.dubbo.common.extension.ExtensionAccessor, var808=$r4, var2817=$z1, var1343=$r46, var3297=$r47, var1575=java.lang.Object, var812=$r48, var3234=r50, var2721=$z5, var259=$r40, var621=$z6, var1817=$r11, var1291=$z3, var3152=org.apache.dubbo.remoting.transport.netty4.NettyServerHandler, var2049=$r53, var1596=$r13, var3752=$r15, var2521=org.apache.dubbo.remoting.ChannelHandler, var875=$r14, var2107=$r16, var2025=org.apache.dubbo.remoting.transport.netty4.NettyChannel, var3027=$r17, var712=io.netty.channel.Channel, var731=$r18, var2903=io.netty.channel.ChannelPipeline, var2601=$r20, var846=io.netty.channel.ChannelHandler, var3257=$r19, var2697=$r54}
; {org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator=var1549, r0=var1425, java.util.List=var389, r10=var726, org.apache.dubbo.remoting.Channel=var2439, $r1=var3789, org.apache.dubbo.common.URL=var3716, org.apache.dubbo.remoting.Endpoint=var2879, r2=var252, r49=var2324, org.apache.dubbo.common.utils.StringUtils=var967, $z0=var3149, org.apache.dubbo.rpc.model.FrameworkModel=var2935, $r3=var1958, org.apache.dubbo.common.extension.ExtensionLoader=var3226, org.apache.dubbo.remoting.Codec2=var3945, org.apache.dubbo.common.extension.ExtensionAccessor=var1669, $r4=var808, $z1=var2817, $r46=var1343, $r47=var3297, java.lang.Object=var1575, $r48=var812, r50=var3234, $z5=var2721, $r40=var259, $z6=var621, $r11=var1817, $z3=var1291, org.apache.dubbo.remoting.transport.netty4.NettyServerHandler=var3152, $r53=var2049, $r13=var1596, $r15=var3752, org.apache.dubbo.remoting.ChannelHandler=var2521, $r14=var875, $r16=var2107, org.apache.dubbo.remoting.transport.netty4.NettyChannel=var2025, $r17=var3027, io.netty.channel.Channel=var712, $r18=var731, io.netty.channel.ChannelPipeline=var2903, $r20=var2601, io.netty.channel.ChannelHandler=var846, $r19=var3257, $r54=var2697}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator;	r10 := @parameter0: java.util.List;	$r1 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	r2 = interfaceinvoke $r1.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	r49 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r49);	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$z1 = virtualinvoke $r4.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r49);	if $z1 == 0 goto $r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r46 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r47 = virtualinvoke $r46.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$r48 = virtualinvoke $r47.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r49);	r50 = (org.apache.dubbo.remoting.Codec2) $r48;	goto [?= $z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec];	$z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec;	if $z5 != 0 goto $r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>();	$r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>();	$z6 = interfaceinvoke $r40.<java.util.Iterator: boolean hasNext()>();	if $z6 == 0 goto $r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	$r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	$z3 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: boolean isClientSide(org.apache.dubbo.remoting.Channel)>($r11);	if $z3 == 0 goto $r53 = new org.apache.dubbo.remoting.transport.netty4.NettyServerHandler;	$r53 = new org.apache.dubbo.remoting.transport.netty4.NettyServerHandler;	$r13 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	$r15 = interfaceinvoke $r13.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r14 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.ChannelHandler handler>;	specialinvoke $r53.<org.apache.dubbo.remoting.transport.netty4.NettyServerHandler: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>($r15, $r14);	$r16 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	$r17 = (org.apache.dubbo.remoting.transport.netty4.NettyChannel) $r16;	$r18 = virtualinvoke $r17.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: io.netty.channel.Channel getNioChannel()>();	$r20 = interfaceinvoke $r18.<io.netty.channel.Channel: io.netty.channel.ChannelPipeline pipeline()>();	$r19 = newarray (io.netty.channel.ChannelHandler)[1];	$r19[0] = $r53;	$r54 = (io.netty.channel.ChannelHandler[]) $r19;	interfaceinvoke $r20.<io.netty.channel.ChannelPipeline: io.netty.channel.ChannelPipeline addLast(io.netty.channel.ChannelHandler[])>($r54);	return
;block_num 9