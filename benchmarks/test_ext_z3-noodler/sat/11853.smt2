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

(declare-sort var331 0)
(declare-sort var1743 0)
(declare-sort var2703 0)
(declare-sort var3727 0)
(declare-sort var3604 0)
(declare-sort var2071 0)
(declare-sort var1588 0)
(declare-sort var1872 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2703-init () (Array Int var2703))
(declare-fun withValue/691604378 (var3727 String) var2703)
(declare-fun var3604_of/-762783238 ((Array Int var2703)) var3604)
(declare-fun var1743_getServiceName/-67876927 (var1743) String)
(declare-fun var2071_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun appendNonNull/-1267374919 (var331 var3604 var1588 String) var3604)
(declare-fun cast-from-var3727-to-var1588 (var3727) var1588)
(declare-fun var1872_getMethodName/-516674313 (var1743) String)
(declare-const null-var331 var331)
(declare-const null-var1743 var1743)
(declare-const var3727-RPC_SYSTEM var3727)
(declare-const null-__Array__Int__var2703__ (Array Int var2703))
(declare-const var3727-RPC_SERVICE var3727)
(declare-const var3727-RPC_METHOD var3727)
(declare-const var2787 var331) ; Statement: r5 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var2787 null-var331)))
(declare-const var1369 var1743) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1369 null-var1743)))
(define-const var1096 (Array Int var2703) arr-var2703-init) ; Statement: $r0 = newarray (io.micrometer.common.KeyValue)[1] 
(define-const var3633 var3727 var3727-RPC_SYSTEM) ; Statement: $r1 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SYSTEM> 
(assert true)
(define-const var3034 var2703 (withValue/691604378 var3633 "apache_dubbo")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: io.micrometer.common.KeyValue withValue(java.lang.String)>("apache_dubbo") 
(declare-const var1096!1 (Array Int var2703))
(assert (not (= var1096!1 null-__Array__Int__var2703__)))
(assert (= (select var1096!1 0) var3034)) ; Statement: $r0[0] = $r2 
(define-const var3659 var3604 (var3604_of/-762783238 var1096!1)) ; Statement: r12 = staticinvoke <io.micrometer.common.KeyValues: io.micrometer.common.KeyValues of(io.micrometer.common.KeyValue[])>($r0) 
(define-const var1810 String (var1743_getServiceName/-67876927 var1369)) ; Statement: $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(define-const var3235 Bool (var2071_hasText/853333513 (cast-from-String-to-String var1810))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r4) 
 ; Statement: if $z0 == 0 goto $r6 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (not (= (ite var3235 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2048 String (var1743_getServiceName/-67876927 var1369)) ; Statement: $r13 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
 ; Statement: goto [?= $r7 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SERVICE>] 
(assert true) ; Non Conditional
(define-const var2009 var3727 var3727-RPC_SERVICE) ; Statement: $r7 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SERVICE> 
(assert true)
(define-const var488 var3604 (appendNonNull/-1267374919 var2787 var3659 (cast-from-var3727-to-var1588 var2009) var2048)) ; Statement: $r11 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r12, $r7, $r13) 
(define-const var887 var3727 var3727-RPC_METHOD) ; Statement: $r8 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_METHOD> 
(define-const var3298 String (var1872_getMethodName/-516674313 var1369)) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert true)
(define-const var799 var3604 (appendNonNull/-1267374919 var2787 var488 (cast-from-var3727-to-var1588 var887) var3298)) ; Statement: $r10 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>($r11, $r8, $r9) 
 ; Statement: return $r10 
(check-sat)
; {arr-var2703-init=([], io.micrometer.common.KeyValue[]), withValue/691604378=([org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames, java.lang.String], io.micrometer.common.KeyValue), var3604_of/-762783238=([io.micrometer.common.KeyValue[]], io.micrometer.common.KeyValues), var1743_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), var2071_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), appendNonNull/-1267374919=([org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, io.micrometer.common.KeyValues, io.micrometer.common.docs.KeyName, java.lang.String], io.micrometer.common.KeyValues), cast-from-var3727-to-var1588=([org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames], io.micrometer.common.docs.KeyName), var1872_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var331=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var2787=r5, var1743=org.apache.dubbo.rpc.Invocation, var1369=r3, var2703=io.micrometer.common.KeyValue, var1096=$r0, var3727=org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames, var3633=$r1, var3034=$r2, var3604=io.micrometer.common.KeyValues, var3659=r12, var1810=$r4, var2071=org.apache.dubbo.common.utils.StringUtils, var3235=$z0, var2048=$r13, var2009=$r7, var1588=io.micrometer.common.docs.KeyName, var488=$r11, var887=$r8, var1872=org.apache.dubbo.rpc.support.RpcUtils, var3298=$r9, var799=$r10}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var331, r5=var2787, org.apache.dubbo.rpc.Invocation=var1743, r3=var1369, io.micrometer.common.KeyValue=var2703, $r0=var1096, org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames=var3727, $r1=var3633, $r2=var3034, io.micrometer.common.KeyValues=var3604, r12=var3659, $r4=var1810, org.apache.dubbo.common.utils.StringUtils=var2071, $z0=var3235, $r13=var2048, $r7=var2009, io.micrometer.common.docs.KeyName=var1588, $r11=var488, $r8=var887, org.apache.dubbo.rpc.support.RpcUtils=var1872, $r9=var3298, $r10=var799}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r5 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r3 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r0 = newarray (io.micrometer.common.KeyValue)[1];	$r1 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SYSTEM>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: io.micrometer.common.KeyValue withValue(java.lang.String)>("apache_dubbo");	$r0[0] = $r2;	r12 = staticinvoke <io.micrometer.common.KeyValues: io.micrometer.common.KeyValues of(io.micrometer.common.KeyValue[])>($r0);	$r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r4);	if $z0 == 0 goto $r6 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r13 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	goto [?= $r7 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SERVICE>];	$r7 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_SERVICE>;	$r11 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r12, $r7, $r13);	$r8 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames RPC_METHOD>;	$r9 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	$r10 = virtualinvoke r5.<org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>($r11, $r8, $r9);	return $r10
;block_num 3