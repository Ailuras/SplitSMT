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

(declare-sort var1879 0)
(declare-sort var3777 0)
(declare-sort var2777 0)
(declare-sort var768 0)
(declare-sort var1807 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun allowedOrigins/601030123 (var1879) (Array Int String))
(declare-fun var3777_toString/-575966009 ((Array Int var2777)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2777__ ((Array Int String)) (Array Int var2777))
(declare-fun allowedOriginsPatterns/601030123 (var1879) (Array Int var768))
(declare-fun cast-from-__Array__Int__var768__-to-__Array__Int__var2777__ ((Array Int var768)) (Array Int var2777))
(declare-fun allowedMethods/601030123 (var1879) (Array Int String))
(declare-fun allowedHeaders/601030123 (var1879) (Array Int String))
(declare-fun exposedHeaders/601030123 (var1879) (Array Int String))
(declare-fun allowCredentials/601030123 (var1879) var1807)
(declare-fun append/-1031950772 (String var2777) String)
(declare-fun cast-from-var1807-to-var2777 (var1807) var2777)
(declare-fun maxAge/601030123 (var1879) Int)
(declare-fun cast-from-Int-to-var2777 (Int) var2777)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1879 var1879)
(declare-const var808 var1879) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta 
(assert (not (= var808 null-var1879)))
(define-const var371 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var371)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var371!1 String)
(assert (= var371!1 ""))
(assert true)
(define-const var3347 String (append/672562846 var371!1 "CorsMeta{allowedOrigins=")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("CorsMeta{allowedOrigins=") 
(declare-const var371!2 String)
(assert (= var371!2 (str.++ var371!1 "CorsMeta{allowedOrigins=")))
(define-const var2889 (Array Int String) (allowedOrigins/601030123 var808)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] allowedOrigins> 
(define-const var1166 String (var3777_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2777__ var2889))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r2) 
(assert true)
(define-const var2441 String (append/672562846 var3347 var1166)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3347!1 String)
(assert (= var3347!1 (str.++ var3347 var1166)))
(assert true)
(define-const var2842 String (append/672562846 var2441 ", allowedOriginsPatterns=")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowedOriginsPatterns=") 
(declare-const var2441!1 String)
(assert (= var2441!1 (str.++ var2441 ", allowedOriginsPatterns=")))
(define-const var3859 (Array Int var768) (allowedOriginsPatterns/601030123 var808)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.util.regex.Pattern[] allowedOriginsPatterns> 
(define-const var256 String (var3777_toString/-575966009 (cast-from-__Array__Int__var768__-to-__Array__Int__var2777__ var3859))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r6) 
(assert true)
(define-const var2550 String (append/672562846 var2842 var256)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2842!1 String)
(assert (= var2842!1 (str.++ var2842 var256)))
(assert true)
(define-const var1705 String (append/672562846 var2550 ", allowedMethods=")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowedMethods=") 
(declare-const var2550!1 String)
(assert (= var2550!1 (str.++ var2550 ", allowedMethods=")))
(define-const var386 (Array Int String) (allowedMethods/601030123 var808)) ; Statement: $r10 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] allowedMethods> 
(define-const var1688 String (var3777_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2777__ var386))) ; Statement: $r11 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r10) 
(assert true)
(define-const var938 String (append/672562846 var1705 var1688)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var1705!1 String)
(assert (= var1705!1 (str.++ var1705 var1688)))
(assert true)
(define-const var56 String (append/672562846 var938 ", allowedHeaders=")) ; Statement: $r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowedHeaders=") 
(declare-const var938!1 String)
(assert (= var938!1 (str.++ var938 ", allowedHeaders=")))
(define-const var3960 (Array Int String) (allowedHeaders/601030123 var808)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] allowedHeaders> 
(define-const var2017 String (var3777_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2777__ var3960))) ; Statement: $r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r14) 
(assert true)
(define-const var1944 String (append/672562846 var56 var2017)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var56!1 String)
(assert (= var56!1 (str.++ var56 var2017)))
(assert true)
(define-const var212 String (append/672562846 var1944 ", exposedHeaders=")) ; Statement: $r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", exposedHeaders=") 
(declare-const var1944!1 String)
(assert (= var1944!1 (str.++ var1944 ", exposedHeaders=")))
(define-const var3138 (Array Int String) (exposedHeaders/601030123 var808)) ; Statement: $r18 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] exposedHeaders> 
(define-const var3303 String (var3777_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2777__ var3138))) ; Statement: $r19 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r18) 
(assert true)
(define-const var3610 String (append/672562846 var212 var3303)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var212!1 String)
(assert (= var212!1 (str.++ var212 var3303)))
(assert true)
(define-const var3430 String (append/672562846 var3610 ", allowCredentials=")) ; Statement: $r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowCredentials=") 
(declare-const var3610!1 String)
(assert (= var3610!1 (str.++ var3610 ", allowCredentials=")))
(define-const var2236 var1807 (allowCredentials/601030123 var808)) ; Statement: $r22 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.Boolean allowCredentials> 
(assert true)
(define-const var1870 String (append/-1031950772 var3430 (cast-from-var1807-to-var2777 var2236))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22) 
(declare-const var3430!1 String)
(assert (str.prefixof var3430 var3430!1))
(assert true)
(define-const var2567 String (append/672562846 var1870 ", maxAge=")) ; Statement: $r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", maxAge=") 
(declare-const var1870!1 String)
(assert (= var1870!1 (str.++ var1870 ", maxAge=")))
(define-const var339 Int (maxAge/601030123 var808)) ; Statement: $r25 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.Long maxAge> 
(assert true)
(define-const var1428 String (append/-1031950772 var2567 (cast-from-Int-to-var2777 var339))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var2567!1 String)
(assert (str.prefixof var2567 var2567!1))
(assert true)
(define-const var1469 String (append/-1166366385 var1428 125)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1428!1 String)
(assert (str.prefixof var1428 var1428!1))
(assert true)
(define-const var1905 String (toString/-2075883882 var1469)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r29 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), allowedOrigins/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.lang.String[]), var3777_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var2777__=([java.lang.String[]], java.lang.Object[]), allowedOriginsPatterns/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.util.regex.Pattern[]), cast-from-__Array__Int__var768__-to-__Array__Int__var2777__=([java.util.regex.Pattern[]], java.lang.Object[]), allowedMethods/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.lang.String[]), allowedHeaders/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.lang.String[]), exposedHeaders/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.lang.String[]), allowCredentials/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.lang.Boolean), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1807-to-var2777=([java.lang.Boolean], java.lang.Object), maxAge/601030123=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta], java.lang.Long), cast-from-Int-to-var2777=([java.lang.Long], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1879=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta, var808=r1, var371=$r0, var3347=$r4, var2889=$r2, var3777=java.util.Arrays, var2777=java.lang.Object, var1166=$r3, var2441=$r5, var2842=$r8, var768=java.util.regex.Pattern, var3859=$r6, var256=$r7, var2550=$r9, var1705=$r12, var386=$r10, var1688=$r11, var938=$r13, var56=$r16, var3960=$r14, var2017=$r15, var1944=$r17, var212=$r20, var3138=$r18, var3303=$r19, var3610=$r21, var3430=$r23, var1807=java.lang.Boolean, var2236=$r22, var1870=$r24, var2567=$r26, var339=$r25, var1428=$r27, var1469=$r28, var1905=$r29}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta=var1879, r1=var808, $r0=var371, $r4=var3347, $r2=var2889, java.util.Arrays=var3777, java.lang.Object=var2777, $r3=var1166, $r5=var2441, $r8=var2842, java.util.regex.Pattern=var768, $r6=var3859, $r7=var256, $r9=var2550, $r12=var1705, $r10=var386, $r11=var1688, $r13=var938, $r16=var56, $r14=var3960, $r15=var2017, $r17=var1944, $r20=var212, $r18=var3138, $r19=var3303, $r21=var3610, $r23=var3430, java.lang.Boolean=var1807, $r22=var2236, $r24=var1870, $r26=var2567, $r25=var339, $r27=var1428, $r28=var1469, $r29=var1905}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("CorsMeta{allowedOrigins=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] allowedOrigins>;	$r3 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowedOriginsPatterns=");	$r6 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.util.regex.Pattern[] allowedOriginsPatterns>;	$r7 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowedMethods=");	$r10 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] allowedMethods>;	$r11 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowedHeaders=");	$r14 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] allowedHeaders>;	$r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", exposedHeaders=");	$r18 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.String[] exposedHeaders>;	$r19 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r18);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", allowCredentials=");	$r22 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.Boolean allowCredentials>;	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22);	$r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", maxAge=");	$r25 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta: java.lang.Long maxAge>;	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	return $r29
;block_num 1