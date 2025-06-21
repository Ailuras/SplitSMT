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

(declare-sort var3928 0)
(declare-sort var3543 0)
(declare-sort var860 0)
(declare-sort var2172 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2172_getMethodName/-888969971 (var2172) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var3928 var3928)
(declare-const null-var3543 var3543)
(declare-const null-var860 var860)
(declare-const null-var2172 var2172)
(declare-const var1980 var3928) ; Statement: r17 := @this: org.apache.dubbo.rpc.filter.CompatibleFilter 
(assert (not (= var1980 null-var3928)))
(declare-const var377 var3543) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Result 
(assert (not (= var377 null-var3543)))
(declare-const var831 var860) ; Statement: r4 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var831 null-var860)))
(declare-const var1589 var2172) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1589 null-var2172)))
(define-const var3291 String (var2172_getMethodName/-888969971 var1589)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var3752 Bool (startsWith/-1785782452 var3291 "$")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("$") 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var3752 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {var2172_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3928=org.apache.dubbo.rpc.filter.CompatibleFilter, var1980=r17, var3543=org.apache.dubbo.rpc.Result, var377=r2, var860=org.apache.dubbo.rpc.Invoker, var831=r4, var2172=org.apache.dubbo.rpc.Invocation, var1589=r0, var3291=$r1, var3752=$z0}
; {org.apache.dubbo.rpc.filter.CompatibleFilter=var3928, r17=var1980, org.apache.dubbo.rpc.Result=var3543, r2=var377, org.apache.dubbo.rpc.Invoker=var860, r4=var831, org.apache.dubbo.rpc.Invocation=var2172, r0=var1589, $r1=var3291, $z0=var3752}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r17 := @this: org.apache.dubbo.rpc.filter.CompatibleFilter;	r2 := @parameter0: org.apache.dubbo.rpc.Result;	r4 := @parameter1: org.apache.dubbo.rpc.Invoker;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("$");	if $z0 != 0 goto return;	return
;block_num 2