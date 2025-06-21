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

(declare-sort var3424 0)
(declare-sort var2358 0)
(declare-sort var1486 0)
(declare-sort var1921 0)
(declare-sort var425 0)
(declare-sort var2640 0)
(declare-sort var3769 0)
(declare-sort var2917 0)
(declare-sort var3016 0)
(declare-sort var3226 0)
(declare-sort var1137 0)
(declare-sort var3422 0)
(declare-sort var337 0)
(declare-sort var3511 0)
(declare-sort var2152 0)
(declare-sort var3842 0)
(declare-sort var1373 0)
(declare-sort var812 0)
(declare-sort var2903 0)
(declare-sort var944 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1921_getMethodName/-516674313 (var1486) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1486_getCompatibleParamSignatures/-1626066609 (var1486) (Array Int String))
(declare-fun var425_toString/-575966009 ((Array Int var2640)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2640__ ((Array Int String)) (Array Int var2640))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3769_requireNonNull/1378936425 (var2640 String) var2640)
(declare-fun cast-from-var2358-to-var2640 (var2358) var2640)
(declare-fun var2917-init () var2917)
(declare-fun <init>/1497424029 (var2917) void)
(declare-fun getUrl/-945338117 (var3226) var3016)
(declare-fun cast-from-var3424-to-var3226 (var3424) var3226)
(declare-fun packableMethodCache/-1039249422 (var3424) var1137)
(declare-fun var337_bootstrap$/131151985 (var3424 var3016) var3422)
(declare-fun var1137_computeIfAbsent/2133881068 (var1137 var2640 var3422) var2640)
(declare-fun cast-from-var2640-to-var3511 (var2640) var3511)
(declare-fun packableMethod/943479956 (var2917) var3511)
(declare-fun convertNoLowerHeader/943479956 (var2917) Bool)
(declare-fun ignoreDefaultVersion/943479956 (var2917) Bool)
(declare-fun method/943479956 (var2917) var2358)
(declare-fun var3424_getSchemeFromUrl/1890683227 (var3016) var3842)
(declare-fun scheme/943479956 (var2917) var3842)
(declare-fun var3424_getCompressorFromEnv/1117912125 () var1373)
(declare-fun compressor/943479956 (var2917) var1373)
(declare-fun var2903_getCancellationContext/-1529113401 () var812)
(declare-fun cancellationContext/943479956 (var2917) var812)
(declare-fun getAddress/-2093578336 (var3016) String)
(declare-fun address/943479956 (var2917) String)
(declare-fun getPath/898047937 (var3016) String)
(declare-fun service/943479956 (var2917) String)
(declare-fun getGroup/1342955253 (var3016) String)
(declare-fun group/943479956 (var2917) String)
(declare-fun getVersion/189836348 (var3016) String)
(declare-fun version/943479956 (var2917) String)
(declare-fun acceptEncodings/-1039249422 (var3424) String)
(declare-fun acceptEncoding/943479956 (var2917) String)
(declare-fun var1486_getObjectAttachmentWithoutConvert/-2125165309 (var1486 String) var2640)
(declare-fun cast-from-var2640-to-String (var2640) String)
(declare-fun application/943479956 (var2917) String)
(declare-fun var1486_getObjectAttachments/241945301 (var1486) var1137)
(declare-fun attachments/943479956 (var2917) var1137)
(declare-const null-var3424 var3424)
(declare-const null-var2358 var2358)
(declare-const null-var1486 var1486)
(declare-const null-Int Int)
(declare-const null-var2917 var2917)
(declare-const var2152-CONVERT_NO_LOWER_HEADER Bool)
(declare-const var2152-IGNORE_1_0_0_VERSION Bool)
(declare-const null-String String)
(declare-const var845 var3424) ; Statement: r12 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker 
(assert (not (= var845 null-var3424)))
(declare-const var3457 var2358) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor 
(assert (not (= var3457 null-var2358)))
(declare-const var1440 var1486) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1440 null-var1486)))
(declare-const var2495 Int) ; Statement: r26 := @parameter2: java.lang.Integer 
(assert (not (= var2495 null-Int)))
(define-const var1933 String (var1921_getMethodName/-516674313 var1440)) ; Statement: r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var530 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var530)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var530!1 String)
(assert (= var530!1 ""))
(assert true)
(define-const var492 String (append/672562846 var530!1 "MethodDescriptor not found for")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodDescriptor not found for") 
(declare-const var530!2 String)
(assert (= var530!2 (str.++ var530!1 "MethodDescriptor not found for")))
(assert true)
(define-const var3366 String (append/672562846 var492 var1933)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var492!1 String)
(assert (= var492!1 (str.++ var492 var1933)))
(assert true)
(define-const var3199 String (append/672562846 var3366 " params:")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" params:") 
(declare-const var3366!1 String)
(assert (= var3366!1 (str.++ var3366 " params:")))
(define-const var45 (Array Int String) (var1486_getCompatibleParamSignatures/-1626066609 var1440)) ; Statement: $r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String[] getCompatibleParamSignatures()>() 
(define-const var2830 String (var425_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2640__ var45))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r6) 
(assert true)
(define-const var274 String (append/672562846 var3199 var2830)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3199!1 String)
(assert (= var3199!1 (str.++ var3199 var2830)))
(assert true)
(define-const var1455 String (toString/-2075883882 var274)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3769_requireNonNull/1378936425 (cast-from-var2358-to-var2640 var3457) var1455)) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object,java.lang.String)>(r2, $r10) 

(declare-const var3457!1 var2358)
(declare-const var1455!1 String)
(define-const var1855 var2917 var2917-init) ; Statement: $r11 = new org.apache.dubbo.rpc.protocol.tri.RequestMetadata 
(assert true)
;(assert (<init>/1497424029 var1855)) ; Statement: specialinvoke $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void <init>()>() 

(declare-const var1855!1 var2917)
(assert true)
(define-const var885 var3016 (getUrl/-945338117 (cast-from-var3424-to-var3226 var845))) ; Statement: r13 = virtualinvoke r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var85 Bool true) ; Statement: $z0 = r2 instanceof org.apache.dubbo.rpc.model.PackableMethod 
 ; Statement: if $z0 == 0 goto $r14 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.util.Map packableMethodCache> 
(assert (= (ite var85 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2144 var1137 (packableMethodCache/-1039249422 var845)) ; Statement: $r14 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.util.Map packableMethodCache> 
(define-const var1380 var3422 (var337_bootstrap$/131151985 var845 var885)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker$lambda_createRequest_2__1377: java.util.function.Function bootstrap$(org.apache.dubbo.rpc.protocol.tri.TripleInvoker,org.apache.dubbo.common.URL)>(r12, r13) 
(define-const var2223 var2640 (var1137_computeIfAbsent/2133881068 var2144 (cast-from-var2358-to-var2640 var3457!1) var1380)) ; Statement: $r16 = interfaceinvoke $r14.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r2, $r15) 
(define-const var3399 var3511 (cast-from-var2640-to-var3511 var2223)) ; Statement: $r17 = (org.apache.dubbo.rpc.model.PackableMethod) $r16 
(declare-const var1855!2 var2917)
(assert (not (= var1855!2 null-var2917)))
(assert (= (packableMethod/943479956 var1855!2) var3399)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.PackableMethod packableMethod> = $r17 
(assert true) ; Non Conditional
(define-const var811 Bool var2152-CONVERT_NO_LOWER_HEADER) ; Statement: $z1 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER> 
(declare-const var1855!3 var2917)
(assert (not (= var1855!3 null-var2917)))
(assert (= (convertNoLowerHeader/943479956 var1855!3) var811)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader> = $z1 
(define-const var3860 Bool var2152-IGNORE_1_0_0_VERSION) ; Statement: $z2 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION> 
(declare-const var1855!4 var2917)
(assert (not (= var1855!4 null-var2917)))
(assert (= (ignoreDefaultVersion/943479956 var1855!4) var3860)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion> = $z2 
(declare-const var1855!5 var2917)
(assert (not (= var1855!5 null-var2917)))
(assert (= (method/943479956 var1855!5) var3457!1)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> = r2 
(define-const var1482 var3842 (var3424_getSchemeFromUrl/1890683227 var885)) ; Statement: $r18 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: io.netty.util.AsciiString getSchemeFromUrl(org.apache.dubbo.common.URL)>(r13) 
(declare-const var1855!6 var2917)
(assert (not (= var1855!6 null-var2917)))
(assert (= (scheme/943479956 var1855!6) var1482)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme> = $r18 
(define-const var2454 var1373 var3424_getCompressorFromEnv/1117912125) ; Statement: $r19 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor getCompressorFromEnv()>() 
(declare-const var1855!7 var2917)
(assert (not (= var1855!7 null-var2917)))
(assert (= (compressor/943479956 var1855!7) var2454)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor> = $r19 
(define-const var496 var812 var2903_getCancellationContext/-1529113401) ; Statement: $r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.CancellationContext getCancellationContext()>() 
(declare-const var1855!8 var2917)
(assert (not (= var1855!8 null-var2917)))
(assert (= (cancellationContext/943479956 var1855!8) var496)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.CancellationContext cancellationContext> = $r20 
(assert true)
(define-const var1537 String (getAddress/-2093578336 var885)) ; Statement: $r21 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(declare-const var1855!9 var2917)
(assert (not (= var1855!9 null-var2917)))
(assert (= (address/943479956 var1855!9) var1537)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address> = $r21 
(assert true)
(define-const var3166 String (getPath/898047937 var885)) ; Statement: $r22 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(declare-const var1855!10 var2917)
(assert (not (= var1855!10 null-var2917)))
(assert (= (service/943479956 var1855!10) var3166)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> = $r22 
(assert true)
(define-const var1695 String (getGroup/1342955253 var885)) ; Statement: $r23 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(declare-const var1855!11 var2917)
(assert (not (= var1855!11 null-var2917)))
(assert (= (group/943479956 var1855!11) var1695)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group> = $r23 
(assert true)
(define-const var1605 String (getVersion/189836348 var885)) ; Statement: $r24 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(declare-const var1855!12 var2917)
(assert (not (= var1855!12 null-var2917)))
(assert (= (version/943479956 var1855!12) var1605)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version> = $r24 
(define-const var3992 String (acceptEncodings/-1039249422 var845)) ; Statement: $r25 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.lang.String acceptEncodings> 
(declare-const var1855!13 var2917)
(assert (not (= var1855!13 null-var2917)))
(assert (= (acceptEncoding/943479956 var1855!13) var3992)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding> = $r25 
 ; Statement: if r26 == null goto $r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application") 
(assert (= var2495 null-Int)) ; Cond: r26 == null 
(define-const var3420 var2640 (var1486_getObjectAttachmentWithoutConvert/-2125165309 var1440 "application")) ; Statement: $r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application") 
(define-const var1472 String (cast-from-var2640-to-String var3420)) ; Statement: $r34 = (java.lang.String) $r27 
(define-const var2738 String var1472) ; Statement: r36 = $r34 
 ; Statement: if $r34 != null goto $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36 
(assert (not (= var1472 null-String))) ; Cond: $r34 != null 
(declare-const var1855!14 var2917)
(assert (not (= var1855!14 null-var2917)))
(assert (= (application/943479956 var1855!14) var2738)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36 
(define-const var1741 var1137 (var1486_getObjectAttachments/241945301 var1440)) ; Statement: $r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>() 
(declare-const var1855!15 var2917)
(assert (not (= var1855!15 null-var2917)))
(assert (= (attachments/943479956 var1855!15) var1741)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> = $r28 
 ; Statement: return $r11 
(check-sat)
; {var1921_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1486_getCompatibleParamSignatures/-1626066609=([org.apache.dubbo.rpc.Invocation], java.lang.String[]), var425_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var2640__=([java.lang.String[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3769_requireNonNull/1378936425=([java.lang.Object, java.lang.String], java.lang.Object), cast-from-var2358-to-var2640=([org.apache.dubbo.rpc.model.MethodDescriptor], java.lang.Object), var2917-init=([], org.apache.dubbo.rpc.protocol.tri.RequestMetadata), <init>/1497424029=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], void), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var3424-to-var3226=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), packableMethodCache/-1039249422=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], java.util.Map), var337_bootstrap$/131151985=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker, org.apache.dubbo.common.URL], java.util.function.Function), var1137_computeIfAbsent/2133881068=([java.util.Map, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-var2640-to-var3511=([java.lang.Object], org.apache.dubbo.rpc.model.PackableMethod), packableMethod/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.PackableMethod), convertNoLowerHeader/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), ignoreDefaultVersion/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), method/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.MethodDescriptor), var3424_getSchemeFromUrl/1890683227=([org.apache.dubbo.common.URL], io.netty.util.AsciiString), scheme/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], io.netty.util.AsciiString), var3424_getCompressorFromEnv/1117912125=([], org.apache.dubbo.rpc.protocol.tri.compressor.Compressor), compressor/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.protocol.tri.compressor.Compressor), var2903_getCancellationContext/-1529113401=([], org.apache.dubbo.rpc.CancellationContext), cancellationContext/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.CancellationContext), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), address/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), service/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), group/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), version/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), acceptEncodings/-1039249422=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], java.lang.String), acceptEncoding/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), var1486_getObjectAttachmentWithoutConvert/-2125165309=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.Object), cast-from-var2640-to-String=([java.lang.Object], java.lang.String), application/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), var1486_getObjectAttachments/241945301=([org.apache.dubbo.rpc.Invocation], java.util.Map), attachments/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.util.Map)}
; {var3424=org.apache.dubbo.rpc.protocol.tri.TripleInvoker, var845=r12, var2358=org.apache.dubbo.rpc.model.MethodDescriptor, var3457=r2, var1486=org.apache.dubbo.rpc.Invocation, var1440=r0, var2495=r26, var1921=org.apache.dubbo.rpc.support.RpcUtils, var1933=r1, var530=$r3, var492=$r4, var3366=$r5, var3199=$r8, var45=$r6, var425=java.util.Arrays, var2640=java.lang.Object, var2830=$r7, var274=$r9, var1455=$r10, var3769=java.util.Objects, var2917=org.apache.dubbo.rpc.protocol.tri.RequestMetadata, var1855=$r11, var3016=org.apache.dubbo.common.URL, var3226=org.apache.dubbo.rpc.protocol.AbstractInvoker, var885=r13, var85=$z0, var1137=java.util.Map, var2144=$r14, var3422=java.util.function.Function, var337=org.apache.dubbo.rpc.protocol.tri.TripleInvoker$lambda_createRequest_2__1377, var1380=$r15, var2223=$r16, var3511=org.apache.dubbo.rpc.model.PackableMethod, var3399=$r17, var2152=org.apache.dubbo.rpc.protocol.tri.TripleProtocol, var811=$z1, var3860=$z2, var3842=io.netty.util.AsciiString, var1482=$r18, var1373=org.apache.dubbo.rpc.protocol.tri.compressor.Compressor, var2454=$r19, var812=org.apache.dubbo.rpc.CancellationContext, var2903=org.apache.dubbo.rpc.RpcContext, var496=$r20, var1537=$r21, var3166=$r22, var1695=$r23, var1605=$r24, var3992=$r25, var3420=$r27, var1472=$r34, var2738=r36, var944=null_type, var1741=$r28}
; {org.apache.dubbo.rpc.protocol.tri.TripleInvoker=var3424, r12=var845, org.apache.dubbo.rpc.model.MethodDescriptor=var2358, r2=var3457, org.apache.dubbo.rpc.Invocation=var1486, r0=var1440, r26=var2495, org.apache.dubbo.rpc.support.RpcUtils=var1921, r1=var1933, $r3=var530, $r4=var492, $r5=var3366, $r8=var3199, $r6=var45, java.util.Arrays=var425, java.lang.Object=var2640, $r7=var2830, $r9=var274, $r10=var1455, java.util.Objects=var3769, org.apache.dubbo.rpc.protocol.tri.RequestMetadata=var2917, $r11=var1855, org.apache.dubbo.common.URL=var3016, org.apache.dubbo.rpc.protocol.AbstractInvoker=var3226, r13=var885, $z0=var85, java.util.Map=var1137, $r14=var2144, java.util.function.Function=var3422, org.apache.dubbo.rpc.protocol.tri.TripleInvoker$lambda_createRequest_2__1377=var337, $r15=var1380, $r16=var2223, org.apache.dubbo.rpc.model.PackableMethod=var3511, $r17=var3399, org.apache.dubbo.rpc.protocol.tri.TripleProtocol=var2152, $z1=var811, $z2=var3860, io.netty.util.AsciiString=var3842, $r18=var1482, org.apache.dubbo.rpc.protocol.tri.compressor.Compressor=var1373, $r19=var2454, org.apache.dubbo.rpc.CancellationContext=var812, org.apache.dubbo.rpc.RpcContext=var2903, $r20=var496, $r21=var1537, $r22=var3166, $r23=var1695, $r24=var1605, $r25=var3992, $r27=var3420, $r34=var1472, r36=var2738, null_type=var944, $r28=var1741}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	r26 := @parameter2: java.lang.Integer;	r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodDescriptor not found for");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" params:");	$r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String[] getCompatibleParamSignatures()>();	$r7 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object,java.lang.String)>(r2, $r10);	$r11 = new org.apache.dubbo.rpc.protocol.tri.RequestMetadata;	specialinvoke $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void <init>()>();	r13 = virtualinvoke r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = r2 instanceof org.apache.dubbo.rpc.model.PackableMethod;	if $z0 == 0 goto $r14 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.util.Map packableMethodCache>;	$r14 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.util.Map packableMethodCache>;	$r15 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker$lambda_createRequest_2__1377: java.util.function.Function bootstrap$(org.apache.dubbo.rpc.protocol.tri.TripleInvoker,org.apache.dubbo.common.URL)>(r12, r13);	$r16 = interfaceinvoke $r14.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r2, $r15);	$r17 = (org.apache.dubbo.rpc.model.PackableMethod) $r16;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.PackableMethod packableMethod> = $r17;	$z1 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER>;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader> = $z1;	$z2 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION>;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion> = $z2;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> = r2;	$r18 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: io.netty.util.AsciiString getSchemeFromUrl(org.apache.dubbo.common.URL)>(r13);	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme> = $r18;	$r19 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor getCompressorFromEnv()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor> = $r19;	$r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.CancellationContext getCancellationContext()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.CancellationContext cancellationContext> = $r20;	$r21 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address> = $r21;	$r22 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> = $r22;	$r23 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group> = $r23;	$r24 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version> = $r24;	$r25 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.lang.String acceptEncodings>;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding> = $r25;	if r26 == null goto $r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application");	$r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application");	$r34 = (java.lang.String) $r27;	r36 = $r34;	if $r34 != null goto $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36;	$r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> = $r28;	return $r11
;block_num 5