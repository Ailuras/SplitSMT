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

(declare-sort var565 0)
(declare-sort var674 0)
(declare-sort var1896 0)
(declare-sort var1121 0)
(declare-sort var2078 0)
(declare-sort var2542 0)
(declare-sort var1116 0)
(declare-sort var1873 0)
(declare-sort var99 0)
(declare-sort var1594 0)
(declare-sort var3715 0)
(declare-sort var1330 0)
(declare-sort var1154 0)
(declare-sort var1165 0)
(declare-sort var48 0)
(declare-sort var697 0)
(declare-sort var2743 0)
(declare-sort var685 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1121_getMethodName/-516674313 (var1896) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1896_getCompatibleParamSignatures/-1626066609 (var1896) (Array Int String))
(declare-fun var2078_toString/-575966009 ((Array Int var2542)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2542__ ((Array Int String)) (Array Int var2542))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1116_requireNonNull/1378936425 (var2542 String) var2542)
(declare-fun cast-from-var674-to-var2542 (var674) var2542)
(declare-fun var1873-init () var1873)
(declare-fun <init>/1497424029 (var1873) void)
(declare-fun getUrl/-945338117 (var1594) var99)
(declare-fun cast-from-var565-to-var1594 (var565) var1594)
(declare-fun cast-from-var674-to-var3715 (var674) var3715)
(declare-fun packableMethod/943479956 (var1873) var3715)
(declare-fun convertNoLowerHeader/943479956 (var1873) Bool)
(declare-fun ignoreDefaultVersion/943479956 (var1873) Bool)
(declare-fun method/943479956 (var1873) var674)
(declare-fun var565_getSchemeFromUrl/1890683227 (var99) var1154)
(declare-fun scheme/943479956 (var1873) var1154)
(declare-fun var565_getCompressorFromEnv/1117912125 () var1165)
(declare-fun compressor/943479956 (var1873) var1165)
(declare-fun var697_getCancellationContext/-1529113401 () var48)
(declare-fun cancellationContext/943479956 (var1873) var48)
(declare-fun getAddress/-2093578336 (var99) String)
(declare-fun address/943479956 (var1873) String)
(declare-fun getPath/898047937 (var99) String)
(declare-fun service/943479956 (var1873) String)
(declare-fun getGroup/1342955253 (var99) String)
(declare-fun group/943479956 (var1873) String)
(declare-fun getVersion/189836348 (var99) String)
(declare-fun version/943479956 (var1873) String)
(declare-fun acceptEncodings/-1039249422 (var565) String)
(declare-fun acceptEncoding/943479956 (var1873) String)
(declare-fun var1896_getObjectAttachmentWithoutConvert/-2125165309 (var1896 String) var2542)
(declare-fun cast-from-var2542-to-String (var2542) String)
(declare-fun application/943479956 (var1873) String)
(declare-fun var1896_getObjectAttachments/241945301 (var1896) var685)
(declare-fun attachments/943479956 (var1873) var685)
(declare-const null-var565 var565)
(declare-const null-var674 var674)
(declare-const null-var1896 var1896)
(declare-const null-Int Int)
(declare-const null-var1873 var1873)
(declare-const var1330-CONVERT_NO_LOWER_HEADER Bool)
(declare-const var1330-IGNORE_1_0_0_VERSION Bool)
(declare-const null-String String)
(declare-const var2225 var565) ; Statement: r12 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker 
(assert (not (= var2225 null-var565)))
(declare-const var1518 var674) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor 
(assert (not (= var1518 null-var674)))
(declare-const var3395 var1896) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3395 null-var1896)))
(declare-const var2434 Int) ; Statement: r26 := @parameter2: java.lang.Integer 
(assert (not (= var2434 null-Int)))
(define-const var2973 String (var1121_getMethodName/-516674313 var3395)) ; Statement: r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var2474 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2474)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2474!1 String)
(assert (= var2474!1 ""))
(assert true)
(define-const var2784 String (append/672562846 var2474!1 "MethodDescriptor not found for")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodDescriptor not found for") 
(declare-const var2474!2 String)
(assert (= var2474!2 (str.++ var2474!1 "MethodDescriptor not found for")))
(assert true)
(define-const var2889 String (append/672562846 var2784 var2973)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2784!1 String)
(assert (= var2784!1 (str.++ var2784 var2973)))
(assert true)
(define-const var611 String (append/672562846 var2889 " params:")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" params:") 
(declare-const var2889!1 String)
(assert (= var2889!1 (str.++ var2889 " params:")))
(define-const var252 (Array Int String) (var1896_getCompatibleParamSignatures/-1626066609 var3395)) ; Statement: $r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String[] getCompatibleParamSignatures()>() 
(define-const var2231 String (var2078_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2542__ var252))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r6) 
(assert true)
(define-const var2347 String (append/672562846 var611 var2231)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var611!1 String)
(assert (= var611!1 (str.++ var611 var2231)))
(assert true)
(define-const var2134 String (toString/-2075883882 var2347)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1116_requireNonNull/1378936425 (cast-from-var674-to-var2542 var1518) var2134)) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object,java.lang.String)>(r2, $r10) 

(declare-const var1518!1 var674)
(declare-const var2134!1 String)
(define-const var1197 var1873 var1873-init) ; Statement: $r11 = new org.apache.dubbo.rpc.protocol.tri.RequestMetadata 
(assert true)
;(assert (<init>/1497424029 var1197)) ; Statement: specialinvoke $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void <init>()>() 

(declare-const var1197!1 var1873)
(assert true)
(define-const var91 var99 (getUrl/-945338117 (cast-from-var565-to-var1594 var2225))) ; Statement: r13 = virtualinvoke r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var3476 Bool true) ; Statement: $z0 = r2 instanceof org.apache.dubbo.rpc.model.PackableMethod 
 ; Statement: if $z0 == 0 goto $r14 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.util.Map packableMethodCache> 
(assert (not (= (ite var3476 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1142 var3715 (cast-from-var674-to-var3715 var1518!1)) ; Statement: $r35 = (org.apache.dubbo.rpc.model.PackableMethod) r2 
(declare-const var1197!2 var1873)
(assert (not (= var1197!2 null-var1873)))
(assert (= (packableMethod/943479956 var1197!2) var1142)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.PackableMethod packableMethod> = $r35 
 ; Statement: goto [?= $z1 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER>] 
(assert true) ; Non Conditional
(define-const var2158 Bool var1330-CONVERT_NO_LOWER_HEADER) ; Statement: $z1 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER> 
(declare-const var1197!3 var1873)
(assert (not (= var1197!3 null-var1873)))
(assert (= (convertNoLowerHeader/943479956 var1197!3) var2158)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader> = $z1 
(define-const var1324 Bool var1330-IGNORE_1_0_0_VERSION) ; Statement: $z2 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION> 
(declare-const var1197!4 var1873)
(assert (not (= var1197!4 null-var1873)))
(assert (= (ignoreDefaultVersion/943479956 var1197!4) var1324)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion> = $z2 
(declare-const var1197!5 var1873)
(assert (not (= var1197!5 null-var1873)))
(assert (= (method/943479956 var1197!5) var1518!1)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> = r2 
(define-const var1380 var1154 (var565_getSchemeFromUrl/1890683227 var91)) ; Statement: $r18 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: io.netty.util.AsciiString getSchemeFromUrl(org.apache.dubbo.common.URL)>(r13) 
(declare-const var1197!6 var1873)
(assert (not (= var1197!6 null-var1873)))
(assert (= (scheme/943479956 var1197!6) var1380)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme> = $r18 
(define-const var2535 var1165 var565_getCompressorFromEnv/1117912125) ; Statement: $r19 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor getCompressorFromEnv()>() 
(declare-const var1197!7 var1873)
(assert (not (= var1197!7 null-var1873)))
(assert (= (compressor/943479956 var1197!7) var2535)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor> = $r19 
(define-const var2332 var48 var697_getCancellationContext/-1529113401) ; Statement: $r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.CancellationContext getCancellationContext()>() 
(declare-const var1197!8 var1873)
(assert (not (= var1197!8 null-var1873)))
(assert (= (cancellationContext/943479956 var1197!8) var2332)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.CancellationContext cancellationContext> = $r20 
(assert true)
(define-const var2206 String (getAddress/-2093578336 var91)) ; Statement: $r21 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(declare-const var1197!9 var1873)
(assert (not (= var1197!9 null-var1873)))
(assert (= (address/943479956 var1197!9) var2206)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address> = $r21 
(assert true)
(define-const var3616 String (getPath/898047937 var91)) ; Statement: $r22 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(declare-const var1197!10 var1873)
(assert (not (= var1197!10 null-var1873)))
(assert (= (service/943479956 var1197!10) var3616)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> = $r22 
(assert true)
(define-const var2650 String (getGroup/1342955253 var91)) ; Statement: $r23 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(declare-const var1197!11 var1873)
(assert (not (= var1197!11 null-var1873)))
(assert (= (group/943479956 var1197!11) var2650)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group> = $r23 
(assert true)
(define-const var3380 String (getVersion/189836348 var91)) ; Statement: $r24 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(declare-const var1197!12 var1873)
(assert (not (= var1197!12 null-var1873)))
(assert (= (version/943479956 var1197!12) var3380)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version> = $r24 
(define-const var3254 String (acceptEncodings/-1039249422 var2225)) ; Statement: $r25 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.lang.String acceptEncodings> 
(declare-const var1197!13 var1873)
(assert (not (= var1197!13 null-var1873)))
(assert (= (acceptEncoding/943479956 var1197!13) var3254)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding> = $r25 
 ; Statement: if r26 == null goto $r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application") 
(assert (= var2434 null-Int)) ; Cond: r26 == null 
(define-const var779 var2542 (var1896_getObjectAttachmentWithoutConvert/-2125165309 var3395 "application")) ; Statement: $r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application") 
(define-const var3150 String (cast-from-var2542-to-String var779)) ; Statement: $r34 = (java.lang.String) $r27 
(define-const var3630 String var3150) ; Statement: r36 = $r34 
 ; Statement: if $r34 != null goto $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36 
(assert (not (= var3150 null-String))) ; Cond: $r34 != null 
(declare-const var1197!14 var1873)
(assert (not (= var1197!14 null-var1873)))
(assert (= (application/943479956 var1197!14) var3630)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36 
(define-const var1693 var685 (var1896_getObjectAttachments/241945301 var3395)) ; Statement: $r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>() 
(declare-const var1197!15 var1873)
(assert (not (= var1197!15 null-var1873)))
(assert (= (attachments/943479956 var1197!15) var1693)) ; Statement: $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> = $r28 
 ; Statement: return $r11 
(check-sat)
; {var1121_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1896_getCompatibleParamSignatures/-1626066609=([org.apache.dubbo.rpc.Invocation], java.lang.String[]), var2078_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var2542__=([java.lang.String[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1116_requireNonNull/1378936425=([java.lang.Object, java.lang.String], java.lang.Object), cast-from-var674-to-var2542=([org.apache.dubbo.rpc.model.MethodDescriptor], java.lang.Object), var1873-init=([], org.apache.dubbo.rpc.protocol.tri.RequestMetadata), <init>/1497424029=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], void), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var565-to-var1594=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), cast-from-var674-to-var3715=([org.apache.dubbo.rpc.model.MethodDescriptor], org.apache.dubbo.rpc.model.PackableMethod), packableMethod/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.PackableMethod), convertNoLowerHeader/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), ignoreDefaultVersion/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], boolean), method/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.MethodDescriptor), var565_getSchemeFromUrl/1890683227=([org.apache.dubbo.common.URL], io.netty.util.AsciiString), scheme/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], io.netty.util.AsciiString), var565_getCompressorFromEnv/1117912125=([], org.apache.dubbo.rpc.protocol.tri.compressor.Compressor), compressor/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.protocol.tri.compressor.Compressor), var697_getCancellationContext/-1529113401=([], org.apache.dubbo.rpc.CancellationContext), cancellationContext/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.CancellationContext), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), address/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), service/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), group/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), version/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), acceptEncodings/-1039249422=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], java.lang.String), acceptEncoding/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), var1896_getObjectAttachmentWithoutConvert/-2125165309=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.Object), cast-from-var2542-to-String=([java.lang.Object], java.lang.String), application/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), var1896_getObjectAttachments/241945301=([org.apache.dubbo.rpc.Invocation], java.util.Map), attachments/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.util.Map)}
; {var565=org.apache.dubbo.rpc.protocol.tri.TripleInvoker, var2225=r12, var674=org.apache.dubbo.rpc.model.MethodDescriptor, var1518=r2, var1896=org.apache.dubbo.rpc.Invocation, var3395=r0, var2434=r26, var1121=org.apache.dubbo.rpc.support.RpcUtils, var2973=r1, var2474=$r3, var2784=$r4, var2889=$r5, var611=$r8, var252=$r6, var2078=java.util.Arrays, var2542=java.lang.Object, var2231=$r7, var2347=$r9, var2134=$r10, var1116=java.util.Objects, var1873=org.apache.dubbo.rpc.protocol.tri.RequestMetadata, var1197=$r11, var99=org.apache.dubbo.common.URL, var1594=org.apache.dubbo.rpc.protocol.AbstractInvoker, var91=r13, var3476=$z0, var3715=org.apache.dubbo.rpc.model.PackableMethod, var1142=$r35, var1330=org.apache.dubbo.rpc.protocol.tri.TripleProtocol, var2158=$z1, var1324=$z2, var1154=io.netty.util.AsciiString, var1380=$r18, var1165=org.apache.dubbo.rpc.protocol.tri.compressor.Compressor, var2535=$r19, var48=org.apache.dubbo.rpc.CancellationContext, var697=org.apache.dubbo.rpc.RpcContext, var2332=$r20, var2206=$r21, var3616=$r22, var2650=$r23, var3380=$r24, var3254=$r25, var779=$r27, var3150=$r34, var3630=r36, var2743=null_type, var685=java.util.Map, var1693=$r28}
; {org.apache.dubbo.rpc.protocol.tri.TripleInvoker=var565, r12=var2225, org.apache.dubbo.rpc.model.MethodDescriptor=var674, r2=var1518, org.apache.dubbo.rpc.Invocation=var1896, r0=var3395, r26=var2434, org.apache.dubbo.rpc.support.RpcUtils=var1121, r1=var2973, $r3=var2474, $r4=var2784, $r5=var2889, $r8=var611, $r6=var252, java.util.Arrays=var2078, java.lang.Object=var2542, $r7=var2231, $r9=var2347, $r10=var2134, java.util.Objects=var1116, org.apache.dubbo.rpc.protocol.tri.RequestMetadata=var1873, $r11=var1197, org.apache.dubbo.common.URL=var99, org.apache.dubbo.rpc.protocol.AbstractInvoker=var1594, r13=var91, $z0=var3476, org.apache.dubbo.rpc.model.PackableMethod=var3715, $r35=var1142, org.apache.dubbo.rpc.protocol.tri.TripleProtocol=var1330, $z1=var2158, $z2=var1324, io.netty.util.AsciiString=var1154, $r18=var1380, org.apache.dubbo.rpc.protocol.tri.compressor.Compressor=var1165, $r19=var2535, org.apache.dubbo.rpc.CancellationContext=var48, org.apache.dubbo.rpc.RpcContext=var697, $r20=var2332, $r21=var2206, $r22=var3616, $r23=var2650, $r24=var3380, $r25=var3254, $r27=var779, $r34=var3150, r36=var3630, null_type=var2743, java.util.Map=var685, $r28=var1693}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	r26 := @parameter2: java.lang.Integer;	r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodDescriptor not found for");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" params:");	$r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String[] getCompatibleParamSignatures()>();	$r7 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object,java.lang.String)>(r2, $r10);	$r11 = new org.apache.dubbo.rpc.protocol.tri.RequestMetadata;	specialinvoke $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: void <init>()>();	r13 = virtualinvoke r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = r2 instanceof org.apache.dubbo.rpc.model.PackableMethod;	if $z0 == 0 goto $r14 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.util.Map packableMethodCache>;	$r35 = (org.apache.dubbo.rpc.model.PackableMethod) r2;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.PackableMethod packableMethod> = $r35;	goto [?= $z1 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER>];	$z1 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER>;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean convertNoLowerHeader> = $z1;	$z2 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION>;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: boolean ignoreDefaultVersion> = $z2;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> = r2;	$r18 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: io.netty.util.AsciiString getSchemeFromUrl(org.apache.dubbo.common.URL)>(r13);	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: io.netty.util.AsciiString scheme> = $r18;	$r19 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor getCompressorFromEnv()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.protocol.tri.compressor.Compressor compressor> = $r19;	$r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.CancellationContext getCancellationContext()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.CancellationContext cancellationContext> = $r20;	$r21 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String address> = $r21;	$r22 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> = $r22;	$r23 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String group> = $r23;	$r24 = virtualinvoke r13.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String version> = $r24;	$r25 = r12.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: java.lang.String acceptEncodings>;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String acceptEncoding> = $r25;	if r26 == null goto $r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application");	$r27 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("application");	$r34 = (java.lang.String) $r27;	r36 = $r34;	if $r34 != null goto $r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36;	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String application> = r36;	$r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>();	$r11.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.util.Map attachments> = $r28;	return $r11
;block_num 5