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

(declare-sort var2199 0)
(declare-sort var2737 0)
(declare-sort var1507 0)
(declare-sort var3106 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2737_getServiceName/-67876927 (var2737) String)
(declare-fun var1507_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3106_getMethodName/-516674313 (var2737) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2199 var2199)
(declare-const null-var2737 var2737)
(declare-const var998 var2199) ; Statement: r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var998 null-var2199)))
(declare-const var3279 var2737) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3279 null-var2737)))
(define-const var958 String (var2737_getServiceName/-67876927 var3279)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(define-const var2114 Bool (var1507_hasText/853333513 (cast-from-String-to-String var958))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (not (= (ite var2114 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1743 String (var2737_getServiceName/-67876927 var3279)) ; Statement: $r11 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
 ; Statement: goto [?= r4 = $r11] 
(assert true) ; Non Conditional
(define-const var704 String var1743) ; Statement: r4 = $r11 
(define-const var1850 String (var3106_getMethodName/-516674313 var3279)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3795 Bool (var1507_hasText/853333513 (cast-from-String-to-String var1850))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10) 
 ; Statement: if $z1 == 0 goto $r12 = "" 
(assert (= (ite var3795 1 0) 0)) ; Cond: $z1 == 0 
(define-const var937 String "") ; Statement: $r12 = "" 
(assert true) ; Non Conditional
(define-const var150 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var150)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var150!1 String)
(assert (= var150!1 ""))
(assert true)
(define-const var2514 String (append/672562846 var150!1 var704)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var150!2 String)
(assert (= var150!2 (str.++ var150!1 var704)))
(assert true)
(define-const var1824 String (append/672562846 var2514 "/")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var2514!1 String)
(assert (= var2514!1 (str.++ var2514 "/")))
(assert true)
(define-const var2068 String (append/672562846 var1824 var937)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var1824!1 String)
(assert (= var1824!1 (str.++ var1824 var937)))
(assert true)
(define-const var1112 String (toString/-2075883882 var2068)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var2737_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), var1507_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3106_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2199=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var998=r2, var2737=org.apache.dubbo.rpc.Invocation, var3279=r0, var958=$r1, var1507=org.apache.dubbo.common.utils.StringUtils, var2114=$z0, var1743=$r11, var704=r4, var3106=org.apache.dubbo.rpc.support.RpcUtils, var1850=$r10, var3795=$z1, var937=$r12, var150=$r5, var2514=$r6, var1824=$r7, var2068=$r8, var1112=$r9}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2199, r2=var998, org.apache.dubbo.rpc.Invocation=var2737, r0=var3279, $r1=var958, org.apache.dubbo.common.utils.StringUtils=var1507, $z0=var2114, $r11=var1743, r4=var704, org.apache.dubbo.rpc.support.RpcUtils=var3106, $r10=var1850, $z1=var3795, $r12=var937, $r5=var150, $r6=var2514, $r7=var1824, $r8=var2068, $r9=var1112}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1);	if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r11 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	goto [?= r4 = $r11];	r4 = $r11;	$r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10);	if $z1 == 0 goto $r12 = "";	$r12 = "";	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 5