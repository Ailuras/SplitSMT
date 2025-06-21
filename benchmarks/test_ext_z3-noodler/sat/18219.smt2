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

(declare-sort var2302 0)
(declare-sort var791 0)
(declare-sort var871 0)
(declare-sort var2602 0)
(declare-sort var646 0)
(declare-sort var1117 0)
(declare-sort var1259 0)
(declare-sort var469 0)
(declare-sort var3302 0)
(declare-sort var3076 0)
(declare-sort var3967 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3302!class ClassObject)
(declare-fun channel/-1159611082 (var2302) var871)
(declare-fun var646_getUrl/938756954 (var646) var2602)
(declare-fun cast-from-var871-to-var646 (var871) var646)
(declare-fun getParameter/-1307325648 (var2602 String) String)
(declare-fun var1117_isEmpty/-813097145 (String) Bool)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var2602) var1259)
(declare-fun getExtensionLoader/-514331157 (var3076 ClassObject) var469)
(declare-fun cast-from-var1259-to-var3076 (var1259) var3076)
(declare-fun hasExtension/-1450549355 (var469 String) Bool)
(declare-fun getExtension/-1809037860 (var469 String) var3967)
(declare-fun cast-from-var3967-to-var3302 (var3967) var3302)
(declare-fun var791_iterator/-912451715 (var791) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun isClientSide/318192039 (var2302 var871) Bool)
(declare-const null-var2302 var2302)
(declare-const null-var791 var791)
(declare-const var3330 var2302) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator 
(assert (not (= var3330 null-var2302)))
(declare-const var2942 var791) ; Statement: r10 := @parameter0: java.util.List 
(assert (not (= var2942 null-var791)))
(define-const var1737 var871 (channel/-1159611082 var3330)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(define-const var1926 var2602 (var646_getUrl/938756954 (cast-from-var871-to-var646 var1737))) ; Statement: r2 = interfaceinvoke $r1.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2924 String (getParameter/-1307325648 var1926 "codec")) ; Statement: r49 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec") 
(define-const var2021 Bool (var1117_isEmpty/-813097145 var2924)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r49) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert (= (ite var2021 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2292 var1259 (getOrDefaultFrameworkModel/-1637556979 var1926)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var1086 var469 (getExtensionLoader/-514331157 (cast-from-var1259-to-var3076 var2292) var3302!class)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var2604 Bool (hasExtension/-1450549355 var1086 var2924)) ; Statement: $z1 = virtualinvoke $r4.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r49) 
 ; Statement: if $z1 == 0 goto $r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert (not (= (ite var2604 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1872 var1259 (getOrDefaultFrameworkModel/-1637556979 var1926)) ; Statement: $r46 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var2725 var469 (getExtensionLoader/-514331157 (cast-from-var1259-to-var3076 var1872) var3302!class)) ; Statement: $r47 = virtualinvoke $r46.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var2673 var3967 (getExtension/-1809037860 var2725 var2924)) ; Statement: $r48 = virtualinvoke $r47.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r49) 
(define-const var3977 var3302 (cast-from-var3967-to-var3302 var2673)) ; Statement: r50 = (org.apache.dubbo.remoting.Codec2) $r48 
 ; Statement: goto [?= $z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec] 
(assert true) ; Non Conditional
(define-const var637 Bool true) ; Statement: $z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec 
 ; Statement: if $z5 != 0 goto $r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>() 
(assert (not (= (ite var637 1 0) 0))) ; Cond: $z5 != 0 
(define-const var3852 Iterator (var791_iterator/-912451715 var2942)) ; Statement: $r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3808 Bool (Iterator_hasNext/-1669924200 var3852)) ; Statement: $z6 = interfaceinvoke $r40.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z6 == 0 goto $r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(assert (= (ite var3808 1 0) 0)) ; Cond: $z6 == 0 
(define-const var799 var871 (channel/-1159611082 var3330)) ; Statement: $r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel> 
(assert true)
(define-const var878 Bool (isClientSide/318192039 var3330 var799)) ; Statement: $z3 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: boolean isClientSide(org.apache.dubbo.remoting.Channel)>($r11) 
 ; Statement: if $z3 == 0 goto $r53 = new org.apache.dubbo.remoting.transport.netty4.NettyServerHandler 
(assert (not (= (ite var878 1 0) 0))) ; Negate: Cond: $z3 == 0  
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {channel/-1159611082=([org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator], org.apache.dubbo.remoting.Channel), var646_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var871-to-var646=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1117_isEmpty/-813097145=([java.lang.String], boolean), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1259-to-var3076=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var3967-to-var3302=([java.lang.Object], org.apache.dubbo.remoting.Codec2), var791_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), isClientSide/318192039=([org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator, org.apache.dubbo.remoting.Channel], boolean)}
; {var2302=org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator, var3330=r0, var791=java.util.List, var2942=r10, var871=org.apache.dubbo.remoting.Channel, var1737=$r1, var2602=org.apache.dubbo.common.URL, var646=org.apache.dubbo.remoting.Endpoint, var1926=r2, var2924=r49, var1117=org.apache.dubbo.common.utils.StringUtils, var2021=$z0, var1259=org.apache.dubbo.rpc.model.FrameworkModel, var2292=$r3, var469=org.apache.dubbo.common.extension.ExtensionLoader, var3302=org.apache.dubbo.remoting.Codec2, var3076=org.apache.dubbo.common.extension.ExtensionAccessor, var1086=$r4, var2604=$z1, var1872=$r46, var2725=$r47, var3967=java.lang.Object, var2673=$r48, var3977=r50, var637=$z5, var3852=$r40, var3808=$z6, var799=$r11, var878=$z3}
; {org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator=var2302, r0=var3330, java.util.List=var791, r10=var2942, org.apache.dubbo.remoting.Channel=var871, $r1=var1737, org.apache.dubbo.common.URL=var2602, org.apache.dubbo.remoting.Endpoint=var646, r2=var1926, r49=var2924, org.apache.dubbo.common.utils.StringUtils=var1117, $z0=var2021, org.apache.dubbo.rpc.model.FrameworkModel=var1259, $r3=var2292, org.apache.dubbo.common.extension.ExtensionLoader=var469, org.apache.dubbo.remoting.Codec2=var3302, org.apache.dubbo.common.extension.ExtensionAccessor=var3076, $r4=var1086, $z1=var2604, $r46=var1872, $r47=var2725, java.lang.Object=var3967, $r48=var2673, r50=var3977, $z5=var637, $r40=var3852, $z6=var3808, $r11=var799, $z3=var878}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator;	r10 := @parameter0: java.util.List;	$r1 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	r2 = interfaceinvoke $r1.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	r49 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r49);	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$z1 = virtualinvoke $r4.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r49);	if $z1 == 0 goto $r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r46 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r47 = virtualinvoke $r46.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$r48 = virtualinvoke $r47.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r49);	r50 = (org.apache.dubbo.remoting.Codec2) $r48;	goto [?= $z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec];	$z5 = r50 instanceof org.apache.dubbo.remoting.api.pu.DefaultCodec;	if $z5 != 0 goto $r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>();	$r40 = interfaceinvoke r10.<java.util.List: java.util.Iterator iterator()>();	$z6 = interfaceinvoke $r40.<java.util.Iterator: boolean hasNext()>();	if $z6 == 0 goto $r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	$r11 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: org.apache.dubbo.remoting.Channel channel>;	$z3 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator: boolean isClientSide(org.apache.dubbo.remoting.Channel)>($r11);	if $z3 == 0 goto $r53 = new org.apache.dubbo.remoting.transport.netty4.NettyServerHandler;	goto [?= return];	return
;block_num 9