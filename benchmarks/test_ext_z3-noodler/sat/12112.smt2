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

(declare-sort var3622 0)
(declare-sort var878 0)
(declare-sort var3753 0)
(declare-sort var714 0)
(declare-sort var1063 0)
(declare-sort var1396 0)
(declare-sort var808 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3753 String) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1063_getEncoder/-814672977 () var714)
(declare-fun getBytes/1068683673 (String) (Array Int Int))
(declare-fun encodeToString/1148501555 (var714 (Array Int Int)) String)
(declare-fun var878_getAttachment/-2134772037 (var878 String) String)
(declare-fun var1396_equals/1031735566 (var808 var808) Bool)
(declare-fun cast-from-String-to-var808 (String) var808)
(declare-const null-var3622 var3622)
(declare-const null-var878 var878)
(declare-const null-var3753 var3753)
(declare-const var2608 var3622) ; Statement: r19 := @this: org.apache.dubbo.auth.BasicAuthenticator 
(assert (not (= var2608 null-var3622)))
(declare-const var2755 var878) ; Statement: r15 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2755 null-var878)))
(declare-const var179 var3753) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var179 null-var3753)))
(assert true)
(define-const var3883 String (getParameter/-1307325648 var179 "username")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("username") 
(assert true)
(define-const var3264 String (getParameter/-1307325648 var179 "password")) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("password") 
(define-const var251 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var251)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var251!1 String)
(assert (= var251!1 ""))
(assert true)
(define-const var3837 String (append/672562846 var251!1 var3883)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var251!2 String)
(assert (= var251!2 (str.++ var251!1 var3883)))
(assert true)
(define-const var2335 String (append/672562846 var3837 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var3837!1 String)
(assert (= var3837!1 (str.++ var3837 ":")))
(assert true)
(define-const var2796 String (append/672562846 var2335 var3264)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2335!1 String)
(assert (= var2335!1 (str.++ var2335 var3264)))
(assert true)
(define-const var2606 String (toString/-2075883882 var2796)) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1004 var714 var1063_getEncoder/-814672977) ; Statement: $r9 = staticinvoke <java.util.Base64: java.util.Base64$Encoder getEncoder()>() 
(assert true)
(define-const var3550 (Array Int Int) (getBytes/1068683673 var2606)) ; Statement: $r8 = virtualinvoke r7.<java.lang.String: byte[] getBytes()>() 
(assert true)
(define-const var1116 String (encodeToString/1148501555 var1004 var3550)) ; Statement: r10 = virtualinvoke $r9.<java.util.Base64$Encoder: java.lang.String encodeToString(byte[])>($r8) 
(define-const var2474 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2474)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2474!1 String)
(assert (= var2474!1 ""))
(assert true)
(define-const var1462 String (append/672562846 var2474!1 "Basic ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Basic ") 
(declare-const var2474!2 String)
(assert (= var2474!2 (str.++ var2474!1 "Basic ")))
(assert true)
(define-const var3109 String (append/672562846 var1462 var1116)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10) 
(declare-const var1462!1 String)
(assert (= var1462!1 (str.++ var1462 var1116)))
(assert true)
(define-const var3291 String (toString/-2075883882 var3109)) ; Statement: r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3078 String (var878_getAttachment/-2134772037 var2755 "Authorization")) ; Statement: $r16 = interfaceinvoke r15.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("Authorization") 
(define-const var1446 Bool (var1396_equals/1031735566 (cast-from-String-to-var808 var3291) (cast-from-String-to-var808 var3078))) ; Statement: $z0 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>(r14, $r16) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1446 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1063_getEncoder/-814672977=([], java.util.Base64$Encoder), getBytes/1068683673=([java.lang.String], byte[]), encodeToString/1148501555=([java.util.Base64$Encoder, byte[]], java.lang.String), var878_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var1396_equals/1031735566=([java.lang.Object, java.lang.Object], boolean), cast-from-String-to-var808=([java.lang.String], java.lang.Object)}
; {var3622=org.apache.dubbo.auth.BasicAuthenticator, var2608=r19, var878=org.apache.dubbo.rpc.Invocation, var2755=r15, var3753=org.apache.dubbo.common.URL, var179=r0, var3883=r1, var3264=r2, var251=$r3, var3837=$r4, var2335=$r5, var2796=$r6, var2606=r7, var714=java.util.Base64$Encoder, var1063=java.util.Base64, var1004=$r9, var3550=$r8, var1116=r10, var2474=$r11, var1462=$r12, var3109=$r13, var3291=r14, var3078=$r16, var1396=java.util.Objects, var808=java.lang.Object, var1446=$z0}
; {org.apache.dubbo.auth.BasicAuthenticator=var3622, r19=var2608, org.apache.dubbo.rpc.Invocation=var878, r15=var2755, org.apache.dubbo.common.URL=var3753, r0=var179, r1=var3883, r2=var3264, $r3=var251, $r4=var3837, $r5=var2335, $r6=var2796, r7=var2606, java.util.Base64$Encoder=var714, java.util.Base64=var1063, $r9=var1004, $r8=var3550, r10=var1116, $r11=var2474, $r12=var1462, $r13=var3109, r14=var3291, $r16=var3078, java.util.Objects=var1396, java.lang.Object=var808, $z0=var1446}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: byte[] getBytes()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.String: byte[] getBytes()>": 1}
;stmts r19 := @this: org.apache.dubbo.auth.BasicAuthenticator;	r15 := @parameter0: org.apache.dubbo.rpc.Invocation;	r0 := @parameter1: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("username");	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("password");	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = staticinvoke <java.util.Base64: java.util.Base64$Encoder getEncoder()>();	$r8 = virtualinvoke r7.<java.lang.String: byte[] getBytes()>();	r10 = virtualinvoke $r9.<java.util.Base64$Encoder: java.lang.String encodeToString(byte[])>($r8);	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Basic ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10);	r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = interfaceinvoke r15.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("Authorization");	$z0 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>(r14, $r16);	if $z0 != 0 goto return;	return
;block_num 2