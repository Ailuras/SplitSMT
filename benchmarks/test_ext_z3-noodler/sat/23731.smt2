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

(declare-sort var537 0)
(declare-sort var3700 0)
(declare-sort var1263 0)
(declare-sort var705 0)
(declare-sort var3740 0)
(declare-sort var512 0)
(declare-sort var2546 0)
(declare-sort var2549 0)
(declare-sort var141 0)
(declare-sort var687 0)
(declare-sort var2695 0)
(declare-sort var3133 0)
(declare-sort var1404 0)
(declare-sort var3461 0)
(declare-sort var1909 0)
(declare-sort var1 0)
(declare-sort var3055 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3700-init () var3700)
(declare-fun <init>/-1972266680 (var3700 Bool) void)
(declare-fun scheme/943479956 (var537) var1263)
(declare-fun cast-from-var1263-to-String (var1263) String)
(declare-fun scheme/363955016 (var3700 String) var705)
(declare-fun address/943479956 (var537) String)
(declare-fun var705_authority/-1347989041 (var705 String) var705)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun asciiName/2077302296 (var3740) var1263)
(declare-fun var705_method/-1268674275 (var705 String) var705)
(declare-fun service/943479956 (var537) String)
(declare-fun method/943479956 (var537) var512)
(declare-fun var512_getMethodName/-1216290648 (var512) String)
(declare-fun var2546_toFullPath/-1782789393 (String String) String)
(declare-fun var705_path/-1464866855 (var705 String) var705)
(declare-fun getKey/83978900 (var2549) String)
(declare-fun getName/761802846 (var141) String)
(declare-fun var705_set/-1436924789 (var705 var2695 var2695) var687)
(declare-fun cast-from-String-to-var2695 (String) var2695)
(declare-fun cast-from-var687-to-var705 (var687) var705)
(declare-fun cast-from-var1263-to-var2695 (var1263) var2695)
(declare-fun getKey/-24632489 (var1404) String)
(declare-fun timeout/943479956 (var537) String)
(declare-fun setIfNotNull/399264413 (var537 var3700 String String) void)
(declare-fun ignoreDefaultVersion/943479956 (var537) Bool)
(declare-fun version/943479956 (var537) String)
(declare-fun group/943479956 (var537) String)
(declare-fun application/943479956 (var537) String)
(declare-fun acceptEncoding/943479956 (var537) String)
(declare-fun compressor/943479956 (var537) var3461)
(declare-fun var1909_getMessageEncoding/1501874843 (var1909) String)
(declare-fun cast-from-var3461-to-var1909 (var3461) var1909)
(declare-fun attachments/943479956 (var537) var1)
(declare-fun convertNoLowerHeader/943479956 (var537) Bool)
(declare-fun var3055_putHeaders/1182873438 (var3700 var1 Bool) void)
(declare-const null-var537 var537)
(declare-const var3740-POST var3740)
(declare-const var2549-CONTENT_TYPE var2549)
(declare-const var141-APPLICATION_GRPC_PROTO var141)
(declare-const var2549-TE var2549)
(declare-const var3133-TRAILERS var1263)
(declare-const var1404-TIMEOUT var1404)
(declare-const var1404-SERVICE_VERSION var1404)
(declare-const var1404-SERVICE_GROUP var1404)
(declare-const var1404-CONSUMER_APP_NAME_KEY var1404)
(declare-const var1404-GRPC_ACCEPT_ENCODING var1404)
(declare-const var703 var537) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.RequestMetadata 
(assert (not (= var703 null-var537)))
(define-const var599 var3700 var3700-init) ; Statement: $r48 = new io.netty.handler.codec.http2.DefaultHttp2Headers 
(assert true)
;(assert (<init>/-1972266680 var599 (ite (= 1 0) true false))) ; Statement: specialinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: void <init>(boolean)>(0) 

(declare-const var599!1 var3700)
(declare-const var1130 Int)
(define-const var1297 var1263 (scheme/943479956 var703)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme> 
(define-const var3908 String (cast-from-var1263-to-String var1297)) ; Statement: $r49 = (java.lang.CharSequence) $r2 
(assert true)
(define-const var381 var705 (scheme/363955016 var599!1 var3908)) ; Statement: $r4 = virtualinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: io.netty.handler.codec.http2.Http2Headers scheme(java.lang.CharSequence)>($r49) 
(define-const var727 String (address/943479956 var703)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address> 
(define-const var1078 var705 (var705_authority/-1347989041 var381 (cast-from-String-to-String var727))) ; Statement: $r7 = interfaceinvoke $r4.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers authority(java.lang.CharSequence)>($r3) 
(define-const var3338 var3740 var3740-POST) ; Statement: $r5 = <io.netty.handler.codec.http.HttpMethod: io.netty.handler.codec.http.HttpMethod POST> 
(assert true)
(define-const var1315 var1263 (asciiName/2077302296 var3338)) ; Statement: $r6 = virtualinvoke $r5.<io.netty.handler.codec.http.HttpMethod: io.netty.util.AsciiString asciiName()>() 
(define-const var741 String (cast-from-var1263-to-String var1315)) ; Statement: $r50 = (java.lang.CharSequence) $r6 
(define-const var3264 var705 (var705_method/-1268674275 var1078 var741)) ; Statement: $r12 = interfaceinvoke $r7.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers method(java.lang.CharSequence)>($r50) 
(define-const var2018 String (service/943479956 var703)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> 
(define-const var190 var512 (method/943479956 var703)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> 
(define-const var3249 String (var512_getMethodName/-1216290648 var190)) ; Statement: $r10 = interfaceinvoke $r8.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>() 
(define-const var1712 String (var2546_toFullPath/-1782789393 var2018 var3249)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String toFullPath(java.lang.String,java.lang.String)>($r9, $r10) 
(define-const var1767 var705 (var705_path/-1464866855 var3264 (cast-from-String-to-String var1712))) ; Statement: $r17 = interfaceinvoke $r12.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers path(java.lang.CharSequence)>($r11) 
(define-const var3433 var2549 var2549-CONTENT_TYPE) ; Statement: $r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_TYPE> 
(assert true)
(define-const var192 String (getKey/83978900 var3433)) ; Statement: $r16 = virtualinvoke $r13.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>() 
(define-const var2536 var141 var141-APPLICATION_GRPC_PROTO) ; Statement: $r14 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType APPLICATION_GRPC_PROTO> 
(assert true)
(define-const var2147 String (getName/761802846 var2536)) ; Statement: $r15 = virtualinvoke $r14.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(define-const var299 var687 (var705_set/-1436924789 var1767 (cast-from-String-to-var2695 var192) (cast-from-String-to-var2695 var2147))) ; Statement: $r18 = interfaceinvoke $r17.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r16, $r15) 
(define-const var905 var705 (cast-from-var687-to-var705 var299)) ; Statement: $r22 = (io.netty.handler.codec.http2.Http2Headers) $r18 
(define-const var2366 var2549 var2549-TE) ; Statement: $r19 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames TE> 
(assert true)
(define-const var3173 String (getKey/83978900 var2366)) ; Statement: $r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>() 
(define-const var2462 var1263 var3133-TRAILERS) ; Statement: $r20 = <io.netty.handler.codec.http.HttpHeaderValues: io.netty.util.AsciiString TRAILERS> 
;(assert (var705_set/-1436924789 var905 (cast-from-String-to-var2695 var3173) (cast-from-var1263-to-var2695 var2462))) ; Statement: interfaceinvoke $r22.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r21, $r20) 

(declare-const var905!1 var705)
(declare-const var3173!1 String)
(declare-const var2462!1 var1263)
(define-const var3811 var1404 var1404-TIMEOUT) ; Statement: $r23 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum TIMEOUT> 
(assert true)
(define-const var3999 String (getKey/-24632489 var3811)) ; Statement: $r25 = virtualinvoke $r23.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var1845 String (timeout/943479956 var703)) ; Statement: $r24 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String timeout> 
(assert true)
;(assert (setIfNotNull/399264413 var703 var599!1 var3999 (cast-from-String-to-String var1845))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r25, $r24) 

(declare-const var703!1 var537)
(declare-const var599!2 var3700)
(declare-const var3999!1 String)
(declare-const var1845!1 String)
(define-const var3879 Bool (ignoreDefaultVersion/943479956 var703!1)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion> 
 ; Statement: if $z0 == 0 goto $r26 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_VERSION> 
(assert (= (ite var3879 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1343 var1404 var1404-SERVICE_VERSION) ; Statement: $r26 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_VERSION> 
(assert true)
(define-const var3760 String (getKey/-24632489 var1343)) ; Statement: $r28 = virtualinvoke $r26.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var2184 String (version/943479956 var703!1)) ; Statement: $r27 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version> 
(assert true)
;(assert (setIfNotNull/399264413 var703!1 var599!2 var3760 (cast-from-String-to-String var2184))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r28, $r27) 

(declare-const var703!2 var537)
(declare-const var599!3 var3700)
(declare-const var3760!1 String)
(declare-const var2184!1 String)
(assert true) ; Non Conditional
(define-const var365 var1404 var1404-SERVICE_GROUP) ; Statement: $r36 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_GROUP> 
(assert true)
(define-const var1629 String (getKey/-24632489 var365)) ; Statement: $r37 = virtualinvoke $r36.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var2182 String (group/943479956 var703!2)) ; Statement: $r38 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group> 
(assert true)
;(assert (setIfNotNull/399264413 var703!2 var599!3 var1629 (cast-from-String-to-String var2182))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r37, $r38) 

(declare-const var703!3 var537)
(declare-const var599!4 var3700)
(declare-const var1629!1 String)
(declare-const var2182!1 String)
(define-const var216 var1404 var1404-CONSUMER_APP_NAME_KEY) ; Statement: $r39 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum CONSUMER_APP_NAME_KEY> 
(assert true)
(define-const var413 String (getKey/-24632489 var216)) ; Statement: $r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var2062 String (application/943479956 var703!3)) ; Statement: $r41 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> 
(assert true)
;(assert (setIfNotNull/399264413 var703!3 var599!4 var413 (cast-from-String-to-String var2062))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r40, $r41) 

(declare-const var703!4 var537)
(declare-const var599!5 var3700)
(declare-const var413!1 String)
(declare-const var2062!1 String)
(define-const var2087 var1404 var1404-GRPC_ACCEPT_ENCODING) ; Statement: $r42 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum GRPC_ACCEPT_ENCODING> 
(assert true)
(define-const var3511 String (getKey/-24632489 var2087)) ; Statement: $r43 = virtualinvoke $r42.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var3975 String (acceptEncoding/943479956 var703!4)) ; Statement: $r44 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding> 
(assert true)
;(assert (setIfNotNull/399264413 var703!4 var599!5 var3511 (cast-from-String-to-String var3975))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r43, $r44) 

(declare-const var703!5 var537)
(declare-const var599!6 var3700)
(declare-const var3511!1 String)
(declare-const var3975!1 String)
(define-const var484 String "identity") ; Statement: $r45 = "identity" 
(define-const var1106 var3461 (compressor/943479956 var703!5)) ; Statement: $r46 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor> 
(define-const var2041 String (var1909_getMessageEncoding/1501874843 (cast-from-var3461-to-var1909 var1106))) ; Statement: $r47 = interfaceinvoke $r46.<org.apache.dubbo.rpc.protocol.tri.compressor.Compressor: java.lang.String getMessageEncoding()>() 
(assert true)
(define-const var2976 Bool (= var484 var2041)) ; Statement: $z3 = virtualinvoke $r45.<java.lang.String: boolean equals(java.lang.Object)>($r47) 
 ; Statement: if $z3 != 0 goto $r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> 
(assert (not (= (ite var2976 1 0) 0))) ; Cond: $z3 != 0 
(define-const var822 var1 (attachments/943479956 var703!5)) ; Statement: $r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> 
(define-const var1223 Bool (convertNoLowerHeader/943479956 var703!5)) ; Statement: $z1 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader> 
;(assert (var3055_putHeaders/1182873438 var599!6 var822 var1223)) ; Statement: staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: void putHeaders(io.netty.handler.codec.http2.DefaultHttp2Headers,java.util.Map,boolean)>($r48, $r29, $z1) 

(declare-const var599!7 var3700)
(declare-const var822!1 var1)
(declare-const var1223!1 Bool)
 ; Statement: return $r48 
(check-sat)
; {var3700-init=([], io.netty.handler.codec.http2.DefaultHttp2Headers), <init>/-1972266680=([io.netty.handler.codec.http2.DefaultHttp2Headers, boolean], void), scheme/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], io.netty.util.AsciiString), cast-from-var1263-to-String=([io.netty.util.AsciiString], java.lang.CharSequence), scheme/363955016=([io.netty.handler.codec.http2.DefaultHttp2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), address/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), var705_authority/-1347989041=([io.netty.handler.codec.http2.Http2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), asciiName/2077302296=([io.netty.handler.codec.http.HttpMethod], io.netty.util.AsciiString), var705_method/-1268674275=([io.netty.handler.codec.http2.Http2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), service/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), method/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.MethodDescriptor), var512_getMethodName/-1216290648=([org.apache.dubbo.rpc.model.MethodDescriptor], java.lang.String), var2546_toFullPath/-1782789393=([java.lang.String, java.lang.String], java.lang.String), var705_path/-1464866855=([io.netty.handler.codec.http2.Http2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), getKey/83978900=([org.apache.dubbo.remoting.http12.HttpHeaderNames], java.lang.CharSequence), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), var705_set/-1436924789=([io.netty.handler.codec.http2.Http2Headers, java.lang.Object, java.lang.Object], io.netty.handler.codec.Headers), cast-from-String-to-var2695=([java.lang.CharSequence], java.lang.Object), cast-from-var687-to-var705=([io.netty.handler.codec.Headers], io.netty.handler.codec.http2.Http2Headers), cast-from-var1263-to-var2695=([io.netty.util.AsciiString], java.lang.Object), getKey/-24632489=([org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum], java.lang.CharSequence), timeout/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), setIfNotNull/399264413=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata, io.netty.handler.codec.http2.DefaultHttp2Headers, java.lang.CharSequence, java.lang.CharSequence], void), ignoreDefaultVersion/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), version/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), group/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), application/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), acceptEncoding/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), compressor/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.protocol.tri.compressor.Compressor), var1909_getMessageEncoding/1501874843=([org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding], java.lang.String), cast-from-var3461-to-var1909=([org.apache.dubbo.rpc.protocol.tri.compressor.Compressor], org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding), attachments/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.util.Map), convertNoLowerHeader/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), var3055_putHeaders/1182873438=([io.netty.handler.codec.http2.DefaultHttp2Headers, java.util.Map, boolean], void)}
; {var537=org.apache.dubbo.rpc.protocol.tri.RequestMetadata, var703=r1, var3700=io.netty.handler.codec.http2.DefaultHttp2Headers, var599=$r48, var1130=0, var1263=io.netty.util.AsciiString, var1297=$r2, var3908=$r49, var705=io.netty.handler.codec.http2.Http2Headers, var381=$r4, var727=$r3, var1078=$r7, var3740=io.netty.handler.codec.http.HttpMethod, var3338=$r5, var1315=$r6, var741=$r50, var3264=$r12, var2018=$r9, var512=org.apache.dubbo.rpc.model.MethodDescriptor, var190=$r8, var3249=$r10, var2546=org.apache.dubbo.rpc.protocol.tri.RequestPath, var1712=$r11, var1767=$r17, var2549=org.apache.dubbo.remoting.http12.HttpHeaderNames, var3433=$r13, var192=$r16, var141=org.apache.dubbo.remoting.http12.message.MediaType, var2536=$r14, var2147=$r15, var687=io.netty.handler.codec.Headers, var2695=java.lang.Object, var299=$r18, var905=$r22, var2366=$r19, var3173=$r21, var3133=io.netty.handler.codec.http.HttpHeaderValues, var2462=$r20, var1404=org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum, var3811=$r23, var3999=$r25, var1845=$r24, var3879=$z0, var1343=$r26, var3760=$r28, var2184=$r27, var365=$r36, var1629=$r37, var2182=$r38, var216=$r39, var413=$r40, var2062=$r41, var2087=$r42, var3511=$r43, var3975=$r44, var484=$r45, var3461=org.apache.dubbo.rpc.protocol.tri.compressor.Compressor, var1106=$r46, var1909=org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding, var2041=$r47, var2976=$z3, var1=java.util.Map, var822=$r29, var1223=$z1, var3055=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils}
; {org.apache.dubbo.rpc.protocol.tri.RequestMetadata=var537, r1=var703, io.netty.handler.codec.http2.DefaultHttp2Headers=var3700, $r48=var599, 0=var1130, io.netty.util.AsciiString=var1263, $r2=var1297, $r49=var3908, io.netty.handler.codec.http2.Http2Headers=var705, $r4=var381, $r3=var727, $r7=var1078, io.netty.handler.codec.http.HttpMethod=var3740, $r5=var3338, $r6=var1315, $r50=var741, $r12=var3264, $r9=var2018, org.apache.dubbo.rpc.model.MethodDescriptor=var512, $r8=var190, $r10=var3249, org.apache.dubbo.rpc.protocol.tri.RequestPath=var2546, $r11=var1712, $r17=var1767, org.apache.dubbo.remoting.http12.HttpHeaderNames=var2549, $r13=var3433, $r16=var192, org.apache.dubbo.remoting.http12.message.MediaType=var141, $r14=var2536, $r15=var2147, io.netty.handler.codec.Headers=var687, java.lang.Object=var2695, $r18=var299, $r22=var905, $r19=var2366, $r21=var3173, io.netty.handler.codec.http.HttpHeaderValues=var3133, $r20=var2462, org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum=var1404, $r23=var3811, $r25=var3999, $r24=var1845, $z0=var3879, $r26=var1343, $r28=var3760, $r27=var2184, $r36=var365, $r37=var1629, $r38=var2182, $r39=var216, $r40=var413, $r41=var2062, $r42=var2087, $r43=var3511, $r44=var3975, $r45=var484, org.apache.dubbo.rpc.protocol.tri.compressor.Compressor=var3461, $r46=var1106, org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding=var1909, $r47=var2041, $z3=var2976, java.util.Map=var1, $r29=var822, $z1=var1223, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var3055}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.RequestMetadata;	$r48 = new io.netty.handler.codec.http2.DefaultHttp2Headers;	specialinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: void <init>(boolean)>(0);	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme>;	$r49 = (java.lang.CharSequence) $r2;	$r4 = virtualinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: io.netty.handler.codec.http2.Http2Headers scheme(java.lang.CharSequence)>($r49);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address>;	$r7 = interfaceinvoke $r4.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers authority(java.lang.CharSequence)>($r3);	$r5 = <io.netty.handler.codec.http.HttpMethod: io.netty.handler.codec.http.HttpMethod POST>;	$r6 = virtualinvoke $r5.<io.netty.handler.codec.http.HttpMethod: io.netty.util.AsciiString asciiName()>();	$r50 = (java.lang.CharSequence) $r6;	$r12 = interfaceinvoke $r7.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers method(java.lang.CharSequence)>($r50);	$r9 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service>;	$r8 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method>;	$r10 = interfaceinvoke $r8.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>();	$r11 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String toFullPath(java.lang.String,java.lang.String)>($r9, $r10);	$r17 = interfaceinvoke $r12.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers path(java.lang.CharSequence)>($r11);	$r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_TYPE>;	$r16 = virtualinvoke $r13.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>();	$r14 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType APPLICATION_GRPC_PROTO>;	$r15 = virtualinvoke $r14.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$r18 = interfaceinvoke $r17.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r16, $r15);	$r22 = (io.netty.handler.codec.http2.Http2Headers) $r18;	$r19 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames TE>;	$r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>();	$r20 = <io.netty.handler.codec.http.HttpHeaderValues: io.netty.util.AsciiString TRAILERS>;	interfaceinvoke $r22.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r21, $r20);	$r23 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum TIMEOUT>;	$r25 = virtualinvoke $r23.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r24 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String timeout>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r25, $r24);	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion>;	if $z0 == 0 goto $r26 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_VERSION>;	$r26 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_VERSION>;	$r28 = virtualinvoke $r26.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r27 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r28, $r27);	$r36 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_GROUP>;	$r37 = virtualinvoke $r36.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r38 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r37, $r38);	$r39 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum CONSUMER_APP_NAME_KEY>;	$r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r41 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r40, $r41);	$r42 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum GRPC_ACCEPT_ENCODING>;	$r43 = virtualinvoke $r42.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r44 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r43, $r44);	$r45 = "identity";	$r46 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor>;	$r47 = interfaceinvoke $r46.<org.apache.dubbo.rpc.protocol.tri.compressor.Compressor: java.lang.String getMessageEncoding()>();	$z3 = virtualinvoke $r45.<java.lang.String: boolean equals(java.lang.Object)>($r47);	if $z3 != 0 goto $r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments>;	$r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments>;	$z1 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader>;	staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: void putHeaders(io.netty.handler.codec.http2.DefaultHttp2Headers,java.util.Map,boolean)>($r48, $r29, $z1);	return $r48
;block_num 4