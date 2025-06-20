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

(declare-sort var825 0)
(declare-sort var1183 0)
(declare-sort var1029 0)
(declare-sort var240 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var825!class ClassObject)
(declare-const var1183!class ClassObject)
(declare-const var1029!class ClassObject)
(declare-const var240!class ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(define-const var3041 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3041)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3041!1 String)
(assert (= var3041!1 ""))
(define-const var1967 ClassObject var825!class) ; Statement: $r1 = class "Lorg/apache/dubbo/remoting/http12/HttpRequest;" 
(assert true)
(define-const var3345 String (getName/-1958580599 var1967)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var76 String (append/672562846 var3041!1 var3345)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3041!2 String)
(assert (= var3041!2 (str.++ var3041!1 var3345)))
(assert true)
(define-const var2553 String (append/672562846 var76 ".body")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".body") 
(declare-const var76!1 String)
(assert (= var76!1 (str.++ var76 ".body")))
(assert true)
(define-const var1575 String (toString/-2075883882 var2553)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1590 String var1575) ; Statement: <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_ATTRIBUTE> = $r5 
(define-const var504 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var504)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var504!1 String)
(assert (= var504!1 ""))
(define-const var270 ClassObject var1183!class) ; Statement: $r7 = class "Lorg/apache/dubbo/remoting/http12/message/HttpMessageDecoder;" 
(assert true)
(define-const var3228 String (getName/-1958580599 var270)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2356 String (append/672562846 var504!1 var3228)) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var504!2 String)
(assert (= var504!2 (str.++ var504!1 var3228)))
(assert true)
(define-const var2854 String (append/672562846 var2356 ".body")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".body") 
(declare-const var2356!1 String)
(assert (= var2356!1 (str.++ var2356 ".body")))
(assert true)
(define-const var3255 String (toString/-2075883882 var2854)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3338 String var3255) ; Statement: <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_DECODER_ATTRIBUTE> = $r11 
(define-const var3722 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3722)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3722!1 String)
(assert (= var3722!1 ""))
(define-const var2700 ClassObject var1029!class) ; Statement: $r13 = class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/RequestMapping;" 
(assert true)
(define-const var3021 String (getName/-1958580599 var2700)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1979 String (append/672562846 var3722!1 var3021)) ; Statement: $r15 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var3722!2 String)
(assert (= var3722!2 (str.++ var3722!1 var3021)))
(assert true)
(define-const var3274 String (append/672562846 var1979 ".sig")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".sig") 
(declare-const var1979!1 String)
(assert (= var1979!1 (str.++ var1979 ".sig")))
(assert true)
(define-const var3621 String (toString/-2075883882 var3274)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2989 String var3621) ; Statement: <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String SIG_ATTRIBUTE> = $r17 
(define-const var1771 ClassObject var1029!class) ; Statement: $r18 = class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/RequestMapping;" 
(assert true)
(define-const var3064 String (getName/-1958580599 var1771)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.Class: java.lang.String getName()>() 
(define-const var3696 String var3064) ; Statement: <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String MAPPING_ATTRIBUTE> = $r19 
(define-const var2124 ClassObject var240!class) ; Statement: $r20 = class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/meta/HandlerMeta;" 
(assert true)
(define-const var982 String (getName/-1958580599 var2124)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.Class: java.lang.String getName()>() 
(define-const var1446 String var982) ; Statement: <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String HANDLER_ATTRIBUTE> = $r21 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3041=$r0, var825=org.apache.dubbo.remoting.http12.HttpRequest, var1967=$r1, var3345=$r2, var76=$r3, var2553=$r4, var1575=$r5, var1590=<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_ATTRIBUTE>, var504=$r6, var1183=org.apache.dubbo.remoting.http12.message.HttpMessageDecoder, var270=$r7, var3228=$r8, var2356=$r9, var2854=$r10, var3255=$r11, var3338=<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_DECODER_ATTRIBUTE>, var3722=$r12, var1029=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var2700=$r13, var3021=$r14, var1979=$r15, var3274=$r16, var3621=$r17, var2989=<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String SIG_ATTRIBUTE>, var1771=$r18, var3064=$r19, var3696=<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String MAPPING_ATTRIBUTE>, var240=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta, var2124=$r20, var982=$r21, var1446=<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String HANDLER_ATTRIBUTE>}
; {$r0=var3041, org.apache.dubbo.remoting.http12.HttpRequest=var825, $r1=var1967, $r2=var3345, $r3=var76, $r4=var2553, $r5=var1575, <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_ATTRIBUTE>=var1590, $r6=var504, org.apache.dubbo.remoting.http12.message.HttpMessageDecoder=var1183, $r7=var270, $r8=var3228, $r9=var2356, $r10=var2854, $r11=var3255, <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_DECODER_ATTRIBUTE>=var3338, $r12=var3722, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var1029, $r13=var2700, $r14=var3021, $r15=var1979, $r16=var3274, $r17=var3621, <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String SIG_ATTRIBUTE>=var2989, $r18=var1771, $r19=var3064, <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String MAPPING_ATTRIBUTE>=var3696, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta=var240, $r20=var2124, $r21=var982, <org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String HANDLER_ATTRIBUTE>=var1446}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 3}
;stmts $r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = class "Lorg/apache/dubbo/remoting/http12/HttpRequest;";	$r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".body");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_ATTRIBUTE> = $r5;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = class "Lorg/apache/dubbo/remoting/http12/message/HttpMessageDecoder;";	$r8 = virtualinvoke $r7.<java.lang.Class: java.lang.String getName()>();	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".body");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String BODY_DECODER_ATTRIBUTE> = $r11;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/RequestMapping;";	$r14 = virtualinvoke $r13.<java.lang.Class: java.lang.String getName()>();	$r15 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".sig");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String SIG_ATTRIBUTE> = $r17;	$r18 = class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/RequestMapping;";	$r19 = virtualinvoke $r18.<java.lang.Class: java.lang.String getName()>();	<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String MAPPING_ATTRIBUTE> = $r19;	$r20 = class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/meta/HandlerMeta;";	$r21 = virtualinvoke $r20.<java.lang.Class: java.lang.String getName()>();	<org.apache.dubbo.rpc.protocol.tri.rest.RestConstants: java.lang.String HANDLER_ATTRIBUTE> = $r21;	return
;block_num 1