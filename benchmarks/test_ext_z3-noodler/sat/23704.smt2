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

(declare-sort var984 0)
(declare-sort var1465 0)
(declare-sort var1532 0)
(declare-sort var1209 0)
(declare-sort var1026 0)
(declare-sort var1154 0)
(declare-sort var1954 0)
(declare-sort var299 0)
(declare-sort var3978 0)
(declare-sort var3212 0)
(declare-sort var1827 0)
(declare-sort var1982 0)
(declare-sort var2247 0)
(declare-sort var579 0)
(declare-sort var317 0)
(declare-sort var1605 0)
(declare-sort var310 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1465-init () var1465)
(declare-fun <init>/-1972266680 (var1465 Bool) void)
(declare-fun scheme/943479956 (var984) var1532)
(declare-fun cast-from-var1532-to-String (var1532) String)
(declare-fun scheme/363955016 (var1465 String) var1209)
(declare-fun address/943479956 (var984) String)
(declare-fun var1209_authority/-1347989041 (var1209 String) var1209)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun asciiName/2077302296 (var1026) var1532)
(declare-fun var1209_method/-1268674275 (var1209 String) var1209)
(declare-fun service/943479956 (var984) String)
(declare-fun method/943479956 (var984) var1154)
(declare-fun var1154_getMethodName/-1216290648 (var1154) String)
(declare-fun var1954_toFullPath/-1782789393 (String String) String)
(declare-fun var1209_path/-1464866855 (var1209 String) var1209)
(declare-fun getKey/83978900 (var299) String)
(declare-fun getName/761802846 (var3978) String)
(declare-fun var1209_set/-1436924789 (var1209 var1827 var1827) var3212)
(declare-fun cast-from-String-to-var1827 (String) var1827)
(declare-fun cast-from-var3212-to-var1209 (var3212) var1209)
(declare-fun cast-from-var1532-to-var1827 (var1532) var1827)
(declare-fun getKey/-24632489 (var2247) String)
(declare-fun timeout/943479956 (var984) String)
(declare-fun setIfNotNull/399264413 (var984 var1465 String String) void)
(declare-fun ignoreDefaultVersion/943479956 (var984) Bool)
(declare-fun version/943479956 (var984) String)
(declare-fun group/943479956 (var984) String)
(declare-fun application/943479956 (var984) String)
(declare-fun acceptEncoding/943479956 (var984) String)
(declare-fun compressor/943479956 (var984) var579)
(declare-fun var317_getMessageEncoding/1501874843 (var317) String)
(declare-fun cast-from-var579-to-var317 (var579) var317)
(declare-fun attachments/943479956 (var984) var1605)
(declare-fun convertNoLowerHeader/943479956 (var984) Bool)
(declare-fun var310_putHeaders/1182873438 (var1465 var1605 Bool) void)
(declare-const null-var984 var984)
(declare-const var1026-POST var1026)
(declare-const var299-CONTENT_TYPE var299)
(declare-const var3978-APPLICATION_GRPC_PROTO var3978)
(declare-const var299-TE var299)
(declare-const var1982-TRAILERS var1532)
(declare-const var2247-TIMEOUT var2247)
(declare-const var2247-SERVICE_GROUP var2247)
(declare-const var2247-CONSUMER_APP_NAME_KEY var2247)
(declare-const var2247-GRPC_ACCEPT_ENCODING var2247)
(declare-const var3188 var984) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.RequestMetadata 
(assert (not (= var3188 null-var984)))
(define-const var1644 var1465 var1465-init) ; Statement: $r48 = new io.netty.handler.codec.http2.DefaultHttp2Headers 
(assert true)
;(assert (<init>/-1972266680 var1644 (ite (= 1 0) true false))) ; Statement: specialinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: void <init>(boolean)>(0) 

(declare-const var1644!1 var1465)
(declare-const var2919 Int)
(define-const var3839 var1532 (scheme/943479956 var3188)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme> 
(define-const var2719 String (cast-from-var1532-to-String var3839)) ; Statement: $r49 = (java.lang.CharSequence) $r2 
(assert true)
(define-const var3036 var1209 (scheme/363955016 var1644!1 var2719)) ; Statement: $r4 = virtualinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: io.netty.handler.codec.http2.Http2Headers scheme(java.lang.CharSequence)>($r49) 
(define-const var1755 String (address/943479956 var3188)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address> 
(define-const var1031 var1209 (var1209_authority/-1347989041 var3036 (cast-from-String-to-String var1755))) ; Statement: $r7 = interfaceinvoke $r4.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers authority(java.lang.CharSequence)>($r3) 
(define-const var1153 var1026 var1026-POST) ; Statement: $r5 = <io.netty.handler.codec.http.HttpMethod: io.netty.handler.codec.http.HttpMethod POST> 
(assert true)
(define-const var2616 var1532 (asciiName/2077302296 var1153)) ; Statement: $r6 = virtualinvoke $r5.<io.netty.handler.codec.http.HttpMethod: io.netty.util.AsciiString asciiName()>() 
(define-const var1963 String (cast-from-var1532-to-String var2616)) ; Statement: $r50 = (java.lang.CharSequence) $r6 
(define-const var1059 var1209 (var1209_method/-1268674275 var1031 var1963)) ; Statement: $r12 = interfaceinvoke $r7.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers method(java.lang.CharSequence)>($r50) 
(define-const var3789 String (service/943479956 var3188)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> 
(define-const var1984 var1154 (method/943479956 var3188)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> 
(define-const var172 String (var1154_getMethodName/-1216290648 var1984)) ; Statement: $r10 = interfaceinvoke $r8.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>() 
(define-const var2101 String (var1954_toFullPath/-1782789393 var3789 var172)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String toFullPath(java.lang.String,java.lang.String)>($r9, $r10) 
(define-const var1379 var1209 (var1209_path/-1464866855 var1059 (cast-from-String-to-String var2101))) ; Statement: $r17 = interfaceinvoke $r12.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers path(java.lang.CharSequence)>($r11) 
(define-const var1875 var299 var299-CONTENT_TYPE) ; Statement: $r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_TYPE> 
(assert true)
(define-const var314 String (getKey/83978900 var1875)) ; Statement: $r16 = virtualinvoke $r13.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>() 
(define-const var2910 var3978 var3978-APPLICATION_GRPC_PROTO) ; Statement: $r14 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType APPLICATION_GRPC_PROTO> 
(assert true)
(define-const var143 String (getName/761802846 var2910)) ; Statement: $r15 = virtualinvoke $r14.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>() 
(define-const var3180 var3212 (var1209_set/-1436924789 var1379 (cast-from-String-to-var1827 var314) (cast-from-String-to-var1827 var143))) ; Statement: $r18 = interfaceinvoke $r17.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r16, $r15) 
(define-const var3201 var1209 (cast-from-var3212-to-var1209 var3180)) ; Statement: $r22 = (io.netty.handler.codec.http2.Http2Headers) $r18 
(define-const var3266 var299 var299-TE) ; Statement: $r19 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames TE> 
(assert true)
(define-const var3006 String (getKey/83978900 var3266)) ; Statement: $r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>() 
(define-const var347 var1532 var1982-TRAILERS) ; Statement: $r20 = <io.netty.handler.codec.http.HttpHeaderValues: io.netty.util.AsciiString TRAILERS> 
;(assert (var1209_set/-1436924789 var3201 (cast-from-String-to-var1827 var3006) (cast-from-var1532-to-var1827 var347))) ; Statement: interfaceinvoke $r22.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r21, $r20) 

(declare-const var3201!1 var1209)
(declare-const var3006!1 String)
(declare-const var347!1 var1532)
(define-const var1238 var2247 var2247-TIMEOUT) ; Statement: $r23 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum TIMEOUT> 
(assert true)
(define-const var824 String (getKey/-24632489 var1238)) ; Statement: $r25 = virtualinvoke $r23.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var1353 String (timeout/943479956 var3188)) ; Statement: $r24 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String timeout> 
(assert true)
;(assert (setIfNotNull/399264413 var3188 var1644!1 var824 (cast-from-String-to-String var1353))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r25, $r24) 

(declare-const var3188!1 var984)
(declare-const var1644!2 var1465)
(declare-const var824!1 String)
(declare-const var1353!1 String)
(define-const var2117 Bool (ignoreDefaultVersion/943479956 var3188!1)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion> 
 ; Statement: if $z0 == 0 goto $r26 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_VERSION> 
(assert (not (= (ite var2117 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2431 String "1.0.0") ; Statement: $r35 = "1.0.0" 
(define-const var3100 String (version/943479956 var3188!1)) ; Statement: $r34 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version> 
(assert true)
(define-const var1952 Bool (= var2431 var3100)) ; Statement: $z2 = virtualinvoke $r35.<java.lang.String: boolean equals(java.lang.Object)>($r34) 
 ; Statement: if $z2 != 0 goto $r36 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_GROUP> 
(assert (not (= (ite var1952 1 0) 0))) ; Cond: $z2 != 0 
(define-const var1665 var2247 var2247-SERVICE_GROUP) ; Statement: $r36 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_GROUP> 
(assert true)
(define-const var3998 String (getKey/-24632489 var1665)) ; Statement: $r37 = virtualinvoke $r36.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var311 String (group/943479956 var3188!1)) ; Statement: $r38 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group> 
(assert true)
;(assert (setIfNotNull/399264413 var3188!1 var1644!2 var3998 (cast-from-String-to-String var311))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r37, $r38) 

(declare-const var3188!2 var984)
(declare-const var1644!3 var1465)
(declare-const var3998!1 String)
(declare-const var311!1 String)
(define-const var2630 var2247 var2247-CONSUMER_APP_NAME_KEY) ; Statement: $r39 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum CONSUMER_APP_NAME_KEY> 
(assert true)
(define-const var1380 String (getKey/-24632489 var2630)) ; Statement: $r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var3537 String (application/943479956 var3188!2)) ; Statement: $r41 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> 
(assert true)
;(assert (setIfNotNull/399264413 var3188!2 var1644!3 var1380 (cast-from-String-to-String var3537))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r40, $r41) 

(declare-const var3188!3 var984)
(declare-const var1644!4 var1465)
(declare-const var1380!1 String)
(declare-const var3537!1 String)
(define-const var2356 var2247 var2247-GRPC_ACCEPT_ENCODING) ; Statement: $r42 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum GRPC_ACCEPT_ENCODING> 
(assert true)
(define-const var2524 String (getKey/-24632489 var2356)) ; Statement: $r43 = virtualinvoke $r42.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>() 
(define-const var1565 String (acceptEncoding/943479956 var3188!3)) ; Statement: $r44 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding> 
(assert true)
;(assert (setIfNotNull/399264413 var3188!3 var1644!4 var2524 (cast-from-String-to-String var1565))) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r43, $r44) 

(declare-const var3188!4 var984)
(declare-const var1644!5 var1465)
(declare-const var2524!1 String)
(declare-const var1565!1 String)
(define-const var2411 String "identity") ; Statement: $r45 = "identity" 
(define-const var686 var579 (compressor/943479956 var3188!4)) ; Statement: $r46 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor> 
(define-const var2769 String (var317_getMessageEncoding/1501874843 (cast-from-var579-to-var317 var686))) ; Statement: $r47 = interfaceinvoke $r46.<org.apache.dubbo.rpc.protocol.tri.compressor.Compressor: java.lang.String getMessageEncoding()>() 
(assert true)
(define-const var2911 Bool (= var2411 var2769)) ; Statement: $z3 = virtualinvoke $r45.<java.lang.String: boolean equals(java.lang.Object)>($r47) 
 ; Statement: if $z3 != 0 goto $r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> 
(assert (not (= (ite var2911 1 0) 0))) ; Cond: $z3 != 0 
(define-const var2746 var1605 (attachments/943479956 var3188!4)) ; Statement: $r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> 
(define-const var1728 Bool (convertNoLowerHeader/943479956 var3188!4)) ; Statement: $z1 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader> 
;(assert (var310_putHeaders/1182873438 var1644!5 var2746 var1728)) ; Statement: staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: void putHeaders(io.netty.handler.codec.http2.DefaultHttp2Headers,java.util.Map,boolean)>($r48, $r29, $z1) 

(declare-const var1644!6 var1465)
(declare-const var2746!1 var1605)
(declare-const var1728!1 Bool)
 ; Statement: return $r48 
(check-sat)
; {var1465-init=([], io.netty.handler.codec.http2.DefaultHttp2Headers), <init>/-1972266680=([io.netty.handler.codec.http2.DefaultHttp2Headers, boolean], void), scheme/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], io.netty.util.AsciiString), cast-from-var1532-to-String=([io.netty.util.AsciiString], java.lang.CharSequence), scheme/363955016=([io.netty.handler.codec.http2.DefaultHttp2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), address/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), var1209_authority/-1347989041=([io.netty.handler.codec.http2.Http2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), asciiName/2077302296=([io.netty.handler.codec.http.HttpMethod], io.netty.util.AsciiString), var1209_method/-1268674275=([io.netty.handler.codec.http2.Http2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), service/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), method/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.MethodDescriptor), var1154_getMethodName/-1216290648=([org.apache.dubbo.rpc.model.MethodDescriptor], java.lang.String), var1954_toFullPath/-1782789393=([java.lang.String, java.lang.String], java.lang.String), var1209_path/-1464866855=([io.netty.handler.codec.http2.Http2Headers, java.lang.CharSequence], io.netty.handler.codec.http2.Http2Headers), getKey/83978900=([org.apache.dubbo.remoting.http12.HttpHeaderNames], java.lang.CharSequence), getName/761802846=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), var1209_set/-1436924789=([io.netty.handler.codec.http2.Http2Headers, java.lang.Object, java.lang.Object], io.netty.handler.codec.Headers), cast-from-String-to-var1827=([java.lang.CharSequence], java.lang.Object), cast-from-var3212-to-var1209=([io.netty.handler.codec.Headers], io.netty.handler.codec.http2.Http2Headers), cast-from-var1532-to-var1827=([io.netty.util.AsciiString], java.lang.Object), getKey/-24632489=([org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum], java.lang.CharSequence), timeout/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), setIfNotNull/399264413=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata, io.netty.handler.codec.http2.DefaultHttp2Headers, java.lang.CharSequence, java.lang.CharSequence], void), ignoreDefaultVersion/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), version/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), group/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), application/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), acceptEncoding/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), compressor/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.protocol.tri.compressor.Compressor), var317_getMessageEncoding/1501874843=([org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding], java.lang.String), cast-from-var579-to-var317=([org.apache.dubbo.rpc.protocol.tri.compressor.Compressor], org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding), attachments/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.util.Map), convertNoLowerHeader/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), var310_putHeaders/1182873438=([io.netty.handler.codec.http2.DefaultHttp2Headers, java.util.Map, boolean], void)}
; {var984=org.apache.dubbo.rpc.protocol.tri.RequestMetadata, var3188=r1, var1465=io.netty.handler.codec.http2.DefaultHttp2Headers, var1644=$r48, var2919=0, var1532=io.netty.util.AsciiString, var3839=$r2, var2719=$r49, var1209=io.netty.handler.codec.http2.Http2Headers, var3036=$r4, var1755=$r3, var1031=$r7, var1026=io.netty.handler.codec.http.HttpMethod, var1153=$r5, var2616=$r6, var1963=$r50, var1059=$r12, var3789=$r9, var1154=org.apache.dubbo.rpc.model.MethodDescriptor, var1984=$r8, var172=$r10, var1954=org.apache.dubbo.rpc.protocol.tri.RequestPath, var2101=$r11, var1379=$r17, var299=org.apache.dubbo.remoting.http12.HttpHeaderNames, var1875=$r13, var314=$r16, var3978=org.apache.dubbo.remoting.http12.message.MediaType, var2910=$r14, var143=$r15, var3212=io.netty.handler.codec.Headers, var1827=java.lang.Object, var3180=$r18, var3201=$r22, var3266=$r19, var3006=$r21, var1982=io.netty.handler.codec.http.HttpHeaderValues, var347=$r20, var2247=org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum, var1238=$r23, var824=$r25, var1353=$r24, var2117=$z0, var2431=$r35, var3100=$r34, var1952=$z2, var1665=$r36, var3998=$r37, var311=$r38, var2630=$r39, var1380=$r40, var3537=$r41, var2356=$r42, var2524=$r43, var1565=$r44, var2411=$r45, var579=org.apache.dubbo.rpc.protocol.tri.compressor.Compressor, var686=$r46, var317=org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding, var2769=$r47, var2911=$z3, var1605=java.util.Map, var2746=$r29, var1728=$z1, var310=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils}
; {org.apache.dubbo.rpc.protocol.tri.RequestMetadata=var984, r1=var3188, io.netty.handler.codec.http2.DefaultHttp2Headers=var1465, $r48=var1644, 0=var2919, io.netty.util.AsciiString=var1532, $r2=var3839, $r49=var2719, io.netty.handler.codec.http2.Http2Headers=var1209, $r4=var3036, $r3=var1755, $r7=var1031, io.netty.handler.codec.http.HttpMethod=var1026, $r5=var1153, $r6=var2616, $r50=var1963, $r12=var1059, $r9=var3789, org.apache.dubbo.rpc.model.MethodDescriptor=var1154, $r8=var1984, $r10=var172, org.apache.dubbo.rpc.protocol.tri.RequestPath=var1954, $r11=var2101, $r17=var1379, org.apache.dubbo.remoting.http12.HttpHeaderNames=var299, $r13=var1875, $r16=var314, org.apache.dubbo.remoting.http12.message.MediaType=var3978, $r14=var2910, $r15=var143, io.netty.handler.codec.Headers=var3212, java.lang.Object=var1827, $r18=var3180, $r22=var3201, $r19=var3266, $r21=var3006, io.netty.handler.codec.http.HttpHeaderValues=var1982, $r20=var347, org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum=var2247, $r23=var1238, $r25=var824, $r24=var1353, $z0=var2117, $r35=var2431, $r34=var3100, $z2=var1952, $r36=var1665, $r37=var3998, $r38=var311, $r39=var2630, $r40=var1380, $r41=var3537, $r42=var2356, $r43=var2524, $r44=var1565, $r45=var2411, org.apache.dubbo.rpc.protocol.tri.compressor.Compressor=var579, $r46=var686, org.apache.dubbo.rpc.protocol.tri.compressor.MessageEncoding=var317, $r47=var2769, $z3=var2911, java.util.Map=var1605, $r29=var2746, $z1=var1728, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var310}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.RequestMetadata;	$r48 = new io.netty.handler.codec.http2.DefaultHttp2Headers;	specialinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: void <init>(boolean)>(0);	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme>;	$r49 = (java.lang.CharSequence) $r2;	$r4 = virtualinvoke $r48.<io.netty.handler.codec.http2.DefaultHttp2Headers: io.netty.handler.codec.http2.Http2Headers scheme(java.lang.CharSequence)>($r49);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address>;	$r7 = interfaceinvoke $r4.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers authority(java.lang.CharSequence)>($r3);	$r5 = <io.netty.handler.codec.http.HttpMethod: io.netty.handler.codec.http.HttpMethod POST>;	$r6 = virtualinvoke $r5.<io.netty.handler.codec.http.HttpMethod: io.netty.util.AsciiString asciiName()>();	$r50 = (java.lang.CharSequence) $r6;	$r12 = interfaceinvoke $r7.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers method(java.lang.CharSequence)>($r50);	$r9 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service>;	$r8 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method>;	$r10 = interfaceinvoke $r8.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>();	$r11 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String toFullPath(java.lang.String,java.lang.String)>($r9, $r10);	$r17 = interfaceinvoke $r12.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.http2.Http2Headers path(java.lang.CharSequence)>($r11);	$r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_TYPE>;	$r16 = virtualinvoke $r13.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>();	$r14 = <org.apache.dubbo.remoting.http12.message.MediaType: org.apache.dubbo.remoting.http12.message.MediaType APPLICATION_GRPC_PROTO>;	$r15 = virtualinvoke $r14.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String getName()>();	$r18 = interfaceinvoke $r17.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r16, $r15);	$r22 = (io.netty.handler.codec.http2.Http2Headers) $r18;	$r19 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames TE>;	$r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>();	$r20 = <io.netty.handler.codec.http.HttpHeaderValues: io.netty.util.AsciiString TRAILERS>;	interfaceinvoke $r22.<io.netty.handler.codec.http2.Http2Headers: io.netty.handler.codec.Headers set(java.lang.Object,java.lang.Object)>($r21, $r20);	$r23 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum TIMEOUT>;	$r25 = virtualinvoke $r23.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r24 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String timeout>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r25, $r24);	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion>;	if $z0 == 0 goto $r26 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_VERSION>;	$r35 = "1.0.0";	$r34 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version>;	$z2 = virtualinvoke $r35.<java.lang.String: boolean equals(java.lang.Object)>($r34);	if $z2 != 0 goto $r36 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_GROUP>;	$r36 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum SERVICE_GROUP>;	$r37 = virtualinvoke $r36.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r38 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r37, $r38);	$r39 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum CONSUMER_APP_NAME_KEY>;	$r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r41 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r40, $r41);	$r42 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum GRPC_ACCEPT_ENCODING>;	$r43 = virtualinvoke $r42.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.CharSequence getKey()>();	$r44 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding>;	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void setIfNotNull(io.netty.handler.codec.http2.DefaultHttp2Headers,java.lang.CharSequence,java.lang.CharSequence)>($r48, $r43, $r44);	$r45 = "identity";	$r46 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor>;	$r47 = interfaceinvoke $r46.<org.apache.dubbo.rpc.protocol.tri.compressor.Compressor: java.lang.String getMessageEncoding()>();	$z3 = virtualinvoke $r45.<java.lang.String: boolean equals(java.lang.Object)>($r47);	if $z3 != 0 goto $r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments>;	$r29 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments>;	$z1 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader>;	staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: void putHeaders(io.netty.handler.codec.http2.DefaultHttp2Headers,java.util.Map,boolean)>($r48, $r29, $z1);	return $r48
;block_num 4