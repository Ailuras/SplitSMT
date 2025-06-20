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

(declare-sort var2312 0)
(declare-sort var770 0)
(declare-sort var3683 0)
(declare-sort var919 0)
(declare-sort var2652 0)
(declare-sort var3379 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun appendNonNull/-1267374919 (var2652 var770 var3379 String) var770)
(declare-fun cast-from-var2312-to-var2652 (var2312) var2652)
(declare-fun cast-from-var919-to-var3379 (var919) var3379)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var2312 var2312)
(declare-const null-var770 var770)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var919-NET_PEER_NAME var919)
(declare-const var919-NET_PEER_PORT var919)
(declare-const var1443 var2312) ; Statement: r0 := @this: org.apache.dubbo.tracing.DefaultDubboClientObservationConvention 
(assert (not (= var1443 null-var2312)))
(declare-const var2581 var770) ; Statement: r6 := @parameter0: io.micrometer.common.KeyValues 
(assert (not (= var2581 null-var770)))
(declare-const var272 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var272 null-String)))
(declare-const var2457 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var2457 null-Int)))
(define-const var3310 var919 var919-NET_PEER_NAME) ; Statement: $r2 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames NET_PEER_NAME> 
(assert true)
(define-const var1219 var770 (appendNonNull/-1267374919 (cast-from-var2312-to-var2652 var1443) var2581 (cast-from-var919-to-var3379 var3310) var272)) ; Statement: r7 = virtualinvoke r0.<org.apache.dubbo.tracing.DefaultDubboClientObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r6, $r2, r1) 
 ; Statement: if i0 != 0 goto $r3 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames NET_PEER_PORT> 
(assert (not (= var2457 0))) ; Cond: i0 != 0 
(define-const var2099 var919 var919-NET_PEER_PORT) ; Statement: $r3 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames NET_PEER_PORT> 
(define-const var2926 String (String_valueOf/1240665136 var2457)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
(define-const var1594 var770 (appendNonNull/-1267374919 (cast-from-var2312-to-var2652 var1443) var1219 (cast-from-var919-to-var3379 var2099) var2926)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.tracing.DefaultDubboClientObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r7, $r3, $r4) 
 ; Statement: return $r5 
(check-sat)
; {appendNonNull/-1267374919=([org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, io.micrometer.common.KeyValues, io.micrometer.common.docs.KeyName, java.lang.String], io.micrometer.common.KeyValues), cast-from-var2312-to-var2652=([org.apache.dubbo.tracing.DefaultDubboClientObservationConvention], org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention), cast-from-var919-to-var3379=([org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames], io.micrometer.common.docs.KeyName), String_valueOf/1240665136=([int], java.lang.String)}
; {var2312=org.apache.dubbo.tracing.DefaultDubboClientObservationConvention, var1443=r0, var770=io.micrometer.common.KeyValues, var2581=r6, var272=r1, var3683=null_type, var2457=i0, var919=org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames, var3310=$r2, var2652=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var3379=io.micrometer.common.docs.KeyName, var1219=r7, var2099=$r3, var2926=$r4, var1594=$r5}
; {org.apache.dubbo.tracing.DefaultDubboClientObservationConvention=var2312, r0=var1443, io.micrometer.common.KeyValues=var770, r6=var2581, r1=var272, null_type=var3683, i0=var2457, org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames=var919, $r2=var3310, org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2652, io.micrometer.common.docs.KeyName=var3379, r7=var1219, $r3=var2099, $r4=var2926, $r5=var1594}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.tracing.DefaultDubboClientObservationConvention;	r6 := @parameter0: io.micrometer.common.KeyValues;	r1 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$r2 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames NET_PEER_NAME>;	r7 = virtualinvoke r0.<org.apache.dubbo.tracing.DefaultDubboClientObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r6, $r2, r1);	if i0 != 0 goto $r3 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames NET_PEER_PORT>;	$r3 = <org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames: org.apache.dubbo.tracing.DubboObservationDocumentation$LowCardinalityKeyNames NET_PEER_PORT>;	$r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r5 = virtualinvoke r0.<org.apache.dubbo.tracing.DefaultDubboClientObservationConvention: io.micrometer.common.KeyValues appendNonNull(io.micrometer.common.KeyValues,io.micrometer.common.docs.KeyName,java.lang.String)>(r7, $r3, $r4);	return $r5
;block_num 2