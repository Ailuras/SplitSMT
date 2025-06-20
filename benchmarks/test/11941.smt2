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

(declare-sort var515 0)
(declare-sort var1589 0)
(declare-sort var2698 0)
(declare-sort var586 0)
(declare-sort var1463 0)
(declare-sort var2866 0)
(declare-sort var2405 0)
(declare-sort var102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2698-init () (Array Int var2698))
(declare-fun withValue/691604378 (var586 String) var2698)
(declare-fun var1463_of/-762783238 ((Array Int var2698)) var1463)
(declare-fun var1589_getServiceName/-67876927 (var1589) String)
(declare-fun var2866_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1589_getTargetServiceUniqueName/-1786712159 (var1589) String)
(declare-fun readServiceName/1880901989 (var515 String) String)
(declare-fun appendNonNull/-1267374919 (var515 var1463 var2405 String) var1463)
(declare-fun cast-from-var586-to-var2405 (var586) var2405)
(declare-fun var102_getMethodName/-516674313 (var1589) String)
(declare-const null-var515 var515)
(declare-const null-var1589 var1589)
(declare-const var586-RPC_SYSTEM var586)
(declare-const null-__Array__Int__var2698__ (Array Int var2698))
(declare-const var586-RPC_SERVICE var586)
(declare-const var586-RPC_METHOD var586)
(declare-const var2786 var515) ; Statement: r5 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var2786 null-var515)))
(declare-const var3765 var1589) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3765 null-var1589)))
(define-const var1001 (Array Int var2698) arr-var2698-init) ; Statement: $r0 = newarray (io.micrometer.common.KeyValue)[1] 
(define-const var2221 var586 var586-RPC_SYSTEM) ; Statement: $r1 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SYSTEM> 
(assert true)
(define-const var3255 var2698 (withValue/691604378 var2221 "apache_dubbo")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: io.micrometer.common.KeyValue withValue(java.lang.String)>("apache_dubbo") 
(declare-const var1001!1 (Array Int var2698))
(assert (not (= var1001!1 null-__Array__Int__var2698__)))
(assert (= (select var1001!1 0) var3255)) ; Statement: $r0[0] = $r2 
(define-const var755 var1463 (var1463_of/-762783238 var1001!1)) ; Statement: r12 = staticinvoke <io.micrometer.common.KeyValues: io.micrometer.common.KeyValues of(io.micrometer.common.KeyValue[])>($r0) 
(define-const var1061 String (var1589_getServiceName/-67876927 var3765)) ; Statement: $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(define-const var3104 Bool (var2866_hasText/853333513 (cast-from-String-to-String var1061))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r4) 
 ; Statement: if $z0 == 0 goto $r6 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= (ite var3104 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1100 String (var1589_getTargetServiceUniqueName/-1786712159 var3765)) ; Statement: $r6 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert true)
(define-const var681 String (readServiceName/1880901989 var2786 var1100)) ; Statement: $r13 = specialinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: java.lang.String readServiceName(java.lang.String)>($r6) 
(assert true) ; Non Conditional
(define-const var2079 var586 var586-RPC_SERVICE) ; Statement: $r7 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SERVICE> 
(assert true)
(define-const var2002 var1463 (appendNonNull/-1267374919 var2786 var755 (cast-from-var586-to-var2405 var2079) var681)) ; Statement: $r11 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r12, $r7, $r13) 
(define-const var76 var586 var586-RPC_METHOD) ; Statement: $r8 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_METHOD> 
(define-const var1226 String (var102_getMethodName/-516674313 var3765)) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert true)
(define-const var2827 var1463 (appendNonNull/-1267374919 var2786 var2002 (cast-from-var586-to-var2405 var76) var1226)) ; Statement: $r10 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>($r11, $r8, $r9) 
 ; Statement: return $r10 
(check-sat)
; {arr-var2698-init=([], io.micrometer.common.KeyValue[]), withValue/691604378=([org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames, java.lang.String], io.micrometer.common.KeyValue), var1463_of/-762783238=([io.micrometer.common.KeyValue[]], io.micrometer.common.KeyValues), var1589_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), var2866_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1589_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String), readServiceName/1880901989=([org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, java.lang.String], java.lang.String), appendNonNull/-1267374919=([org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, io.micrometer.common.KeyValues, io.micrometer.common.docs.KeyName, java.lang.String], io.micrometer.common.KeyValues), cast-from-var586-to-var2405=([org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames], io.micrometer.common.docs.KeyName), var102_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var515=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var2786=r5, var1589=org.apache.dubbo.rpc.Invocation, var3765=r3, var2698=io.micrometer.common.KeyValue, var1001=$r0, var586=org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames, var2221=$r1, var3255=$r2, var1463=io.micrometer.common.KeyValues, var755=r12, var1061=$r4, var2866=org.apache.dubbo.common.utils.StringUtils, var3104=$z0, var1100=$r6, var681=$r13, var2079=$r7, var2405=io.micrometer.common.docs.KeyName, var2002=$r11, var76=$r8, var102=org.apache.dubbo.rpc.support.RpcUtils, var1226=$r9, var2827=$r10}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var515, r5=var2786, org.apache.dubbo.rpc.Invocation=var1589, r3=var3765, io.micrometer.common.KeyValue=var2698, $r0=var1001, org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames=var586, $r1=var2221, $r2=var3255, io.micrometer.common.KeyValues=var1463, r12=var755, $r4=var1061, org.apache.dubbo.common.utils.StringUtils=var2866, $z0=var3104, $r6=var1100, $r13=var681, $r7=var2079, io.micrometer.common.docs.KeyName=var2405, $r11=var2002, $r8=var76, org.apache.dubbo.rpc.support.RpcUtils=var102, $r9=var1226, $r10=var2827}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r5 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r3 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r0 = newarray (io.micrometer.common.KeyValue)[1];	$r1 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SYSTEM>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: io.micrometer.common.KeyValue withValue(java.lang.String)>("apache_dubbo");	$r0[0] = $r2;	r12 = staticinvoke <io.micrometer.common.KeyValues: io.micrometer.common.KeyValues of(io.micrometer.common.KeyValue[])>($r0);	$r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r4);	if $z0 == 0 goto $r6 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r6 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r13 = specialinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: java.lang.String readServiceName(java.lang.String)>($r6);	$r7 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SERVICE>;	$r11 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r12, $r7, $r13);	$r8 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_METHOD>;	$r9 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	$r10 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>($r11, $r8, $r9);	return $r10
;block_num 3