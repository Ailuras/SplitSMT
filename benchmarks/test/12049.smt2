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

(declare-sort var3005 0)
(declare-sort var2715 0)
(declare-sort var2245 0)
(declare-sort var1942 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2715_getServiceName/-67876927 (var2715) String)
(declare-fun var2245_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2715_getTargetServiceUniqueName/-1786712159 (var2715) String)
(declare-fun readServiceName/1880901989 (var3005 String) String)
(declare-fun var1942_getMethodName/-516674313 (var2715) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3005 var3005)
(declare-const null-var2715 var2715)
(declare-const var271 var3005) ; Statement: r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var271 null-var3005)))
(declare-const var1575 var2715) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1575 null-var2715)))
(define-const var1182 String (var2715_getServiceName/-67876927 var1575)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(define-const var3474 Bool (var2245_hasText/853333513 (cast-from-String-to-String var1182))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= (ite var3474 1 0) 0)) ; Cond: $z0 == 0 
(define-const var191 String (var2715_getTargetServiceUniqueName/-1786712159 var1575)) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert true)
(define-const var2970 String (readServiceName/1880901989 var271 var191)) ; Statement: $r11 = specialinvoke r2.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: java.lang.String readServiceName(java.lang.String)>($r3) 
(assert true) ; Non Conditional
(define-const var3434 String var2970) ; Statement: r4 = $r11 
(define-const var1853 String (var1942_getMethodName/-516674313 var1575)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var2033 Bool (var2245_hasText/853333513 (cast-from-String-to-String var1853))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10) 
 ; Statement: if $z1 == 0 goto $r12 = "" 
(assert (not (= (ite var2033 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var556 String var1853) ; Statement: $r12 = $r10 
 ; Statement: goto [?= $r5 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var2105 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2105)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2105!1 String)
(assert (= var2105!1 ""))
(assert true)
(define-const var497 String (append/672562846 var2105!1 var3434)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2105!2 String)
(assert (= var2105!2 (str.++ var2105!1 var3434)))
(assert true)
(define-const var2579 String (append/672562846 var497 "/")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var497!1 String)
(assert (= var497!1 (str.++ var497 "/")))
(assert true)
(define-const var730 String (append/672562846 var2579 var556)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2579!1 String)
(assert (= var2579!1 (str.++ var2579 var556)))
(assert true)
(define-const var422 String (toString/-2075883882 var730)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var2715_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), var2245_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2715_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String), readServiceName/1880901989=([org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, java.lang.String], java.lang.String), var1942_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3005=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var271=r2, var2715=org.apache.dubbo.rpc.Invocation, var1575=r0, var1182=$r1, var2245=org.apache.dubbo.common.utils.StringUtils, var3474=$z0, var191=$r3, var2970=$r11, var3434=r4, var1942=org.apache.dubbo.rpc.support.RpcUtils, var1853=$r10, var2033=$z1, var556=$r12, var2105=$r5, var497=$r6, var2579=$r7, var730=$r8, var422=$r9}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var3005, r2=var271, org.apache.dubbo.rpc.Invocation=var2715, r0=var1575, $r1=var1182, org.apache.dubbo.common.utils.StringUtils=var2245, $z0=var3474, $r3=var191, $r11=var2970, r4=var3434, org.apache.dubbo.rpc.support.RpcUtils=var1942, $r10=var1853, $z1=var2033, $r12=var556, $r5=var2105, $r6=var497, $r7=var2579, $r8=var730, $r9=var422}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1);	if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r11 = specialinvoke r2.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: java.lang.String readServiceName(java.lang.String)>($r3);	r4 = $r11;	$r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10);	if $z1 == 0 goto $r12 = "";	$r12 = $r10;	goto [?= $r5 = new java.lang.StringBuilder];	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 5