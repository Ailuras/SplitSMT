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

(declare-sort var3277 0)
(declare-sort var865 0)
(declare-sort var2099 0)
(declare-sort var708 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var865_getServiceName/-67876927 (var865) String)
(declare-fun var2099_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var865_getTargetServiceUniqueName/-1786712159 (var865) String)
(declare-fun readServiceName/1880901989 (var3277 String) String)
(declare-fun var708_getMethodName/-516674313 (var865) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3277 var3277)
(declare-const null-var865 var865)
(declare-const var944 var3277) ; Statement: r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var944 null-var3277)))
(declare-const var134 var865) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var134 null-var865)))
(define-const var1905 String (var865_getServiceName/-67876927 var134)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(define-const var3281 Bool (var2099_hasText/853333513 (cast-from-String-to-String var1905))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= (ite var3281 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3567 String (var865_getTargetServiceUniqueName/-1786712159 var134)) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert true)
(define-const var3096 String (readServiceName/1880901989 var944 var3567)) ; Statement: $r11 = specialinvoke r2.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: java.lang.String readServiceName(java.lang.String)>($r3) 
(assert true) ; Non Conditional
(define-const var3108 String var3096) ; Statement: r4 = $r11 
(define-const var177 String (var708_getMethodName/-516674313 var134)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3351 Bool (var2099_hasText/853333513 (cast-from-String-to-String var177))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10) 
 ; Statement: if $z1 == 0 goto $r12 = "" 
(assert (= (ite var3351 1 0) 0)) ; Cond: $z1 == 0 
(define-const var186 String "") ; Statement: $r12 = "" 
(assert true) ; Non Conditional
(define-const var2871 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2871)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2871!1 String)
(assert (= var2871!1 ""))
(assert true)
(define-const var1182 String (append/672562846 var2871!1 var3108)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2871!2 String)
(assert (= var2871!2 (str.++ var2871!1 var3108)))
(assert true)
(define-const var3385 String (append/672562846 var1182 "/")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var1182!1 String)
(assert (= var1182!1 (str.++ var1182 "/")))
(assert true)
(define-const var2307 String (append/672562846 var3385 var186)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3385!1 String)
(assert (= var3385!1 (str.++ var3385 var186)))
(assert true)
(define-const var2319 String (toString/-2075883882 var2307)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var865_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), var2099_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var865_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String), readServiceName/1880901989=([org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, java.lang.String], java.lang.String), var708_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3277=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var944=r2, var865=org.apache.dubbo.rpc.Invocation, var134=r0, var1905=$r1, var2099=org.apache.dubbo.common.utils.StringUtils, var3281=$z0, var3567=$r3, var3096=$r11, var3108=r4, var708=org.apache.dubbo.rpc.support.RpcUtils, var177=$r10, var3351=$z1, var186=$r12, var2871=$r5, var1182=$r6, var3385=$r7, var2307=$r8, var2319=$r9}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var3277, r2=var944, org.apache.dubbo.rpc.Invocation=var865, r0=var134, $r1=var1905, org.apache.dubbo.common.utils.StringUtils=var2099, $z0=var3281, $r3=var3567, $r11=var3096, r4=var3108, org.apache.dubbo.rpc.support.RpcUtils=var708, $r10=var177, $z1=var3351, $r12=var186, $r5=var2871, $r6=var1182, $r7=var3385, $r8=var2307, $r9=var2319}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1);	if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r11 = specialinvoke r2.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: java.lang.String readServiceName(java.lang.String)>($r3);	r4 = $r11;	$r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10);	if $z1 == 0 goto $r12 = "";	$r12 = "";	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 5