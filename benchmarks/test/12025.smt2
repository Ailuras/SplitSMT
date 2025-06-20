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

(declare-sort var1381 0)
(declare-sort var903 0)
(declare-sort var3609 0)
(declare-sort var1586 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var903_getServiceName/-67876927 (var903) String)
(declare-fun var3609_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1586_getMethodName/-516674313 (var903) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1381 var1381)
(declare-const null-var903 var903)
(declare-const var2642 var1381) ; Statement: r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var2642 null-var1381)))
(declare-const var335 var903) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var335 null-var903)))
(define-const var204 String (var903_getServiceName/-67876927 var335)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(define-const var3678 Bool (var3609_hasText/853333513 (cast-from-String-to-String var204))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (not (= (ite var3678 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3318 String (var903_getServiceName/-67876927 var335)) ; Statement: $r11 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
 ; Statement: goto [?= r4 = $r11] 
(assert true) ; Non Conditional
(define-const var1389 String var3318) ; Statement: r4 = $r11 
(define-const var1810 String (var1586_getMethodName/-516674313 var335)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3818 Bool (var3609_hasText/853333513 (cast-from-String-to-String var1810))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10) 
 ; Statement: if $z1 == 0 goto $r12 = "" 
(assert (not (= (ite var3818 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var284 String var1810) ; Statement: $r12 = $r10 
 ; Statement: goto [?= $r5 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var1617 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1617)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1617!1 String)
(assert (= var1617!1 ""))
(assert true)
(define-const var3268 String (append/672562846 var1617!1 var1389)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var1617!2 String)
(assert (= var1617!2 (str.++ var1617!1 var1389)))
(assert true)
(define-const var1168 String (append/672562846 var3268 "/")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3268!1 String)
(assert (= var3268!1 (str.++ var3268 "/")))
(assert true)
(define-const var3432 String (append/672562846 var1168 var284)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var1168!1 String)
(assert (= var1168!1 (str.++ var1168 var284)))
(assert true)
(define-const var1768 String (toString/-2075883882 var3432)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var903_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), var3609_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1586_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1381=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var2642=r2, var903=org.apache.dubbo.rpc.Invocation, var335=r0, var204=$r1, var3609=org.apache.dubbo.common.utils.StringUtils, var3678=$z0, var3318=$r11, var1389=r4, var1586=org.apache.dubbo.rpc.support.RpcUtils, var1810=$r10, var3818=$z1, var284=$r12, var1617=$r5, var3268=$r6, var1168=$r7, var3432=$r8, var1768=$r9}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var1381, r2=var2642, org.apache.dubbo.rpc.Invocation=var903, r0=var335, $r1=var204, org.apache.dubbo.common.utils.StringUtils=var3609, $z0=var3678, $r11=var3318, r4=var1389, org.apache.dubbo.rpc.support.RpcUtils=var1586, $r10=var1810, $z1=var3818, $r12=var284, $r5=var1617, $r6=var3268, $r7=var1168, $r8=var3432, $r9=var1768}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1);	if $z0 == 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r11 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	goto [?= r4 = $r11];	r4 = $r11;	$r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r10);	if $z1 == 0 goto $r12 = "";	$r12 = $r10;	goto [?= $r5 = new java.lang.StringBuilder];	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 5