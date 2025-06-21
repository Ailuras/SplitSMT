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

(declare-sort var2552 0)
(declare-sort var927 0)
(declare-sort var2519 0)
(declare-sort var2274 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun unregister/-1677681220 (var2519 var927) void)
(declare-fun cast-from-var2552-to-var2519 (var2552) var2519)
(declare-fun removeFailedRegistered/-1879744 (var2552 var927) void)
(declare-fun removeFailedUnregistered/-884115687 (var2552 var927) void)
(declare-const null-var2552 var2552)
(declare-const null-var927 var927)
(declare-const null-var2274 var2274)
(declare-const var8 var2552) ; Statement: r0 := @this: org.apache.dubbo.registry.support.FailbackRegistry 
(assert (not (= var8 null-var2552)))
(declare-const var2876 var927) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2876 null-var927)))
(assert true)
;(assert (unregister/-1677681220 (cast-from-var2552-to-var2519 var8) var2876)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.AbstractRegistry: void unregister(org.apache.dubbo.common.URL)>(r1) 

(declare-const var8!1 var2552)
(declare-const var2876!1 var927)
(assert true)
;(assert (removeFailedRegistered/-1879744 var8!1 var2876!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedRegistered(org.apache.dubbo.common.URL)>(r1) 

(declare-const var8!2 var2552)
(declare-const var2876!2 var927)
(assert true)
;(assert (removeFailedUnregistered/-884115687 var8!2 var2876!2)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedUnregistered(org.apache.dubbo.common.URL)>(r1) 

(declare-const var8!3 var2552)
(declare-const var2876!3 var927)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3534 var2274) ; Statement: $r2 := @caughtexception 
(assert (not (= var3534 null-var2274)))
(define-const var3572 Bool false) ; Statement: $z0 = $r2 instanceof org.apache.dubbo.registry.support.SkipFailbackWrapperException 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var3572 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {unregister/-1677681220=([org.apache.dubbo.registry.support.AbstractRegistry, org.apache.dubbo.common.URL], void), cast-from-var2552-to-var2519=([org.apache.dubbo.registry.support.FailbackRegistry], org.apache.dubbo.registry.support.AbstractRegistry), removeFailedRegistered/-1879744=([org.apache.dubbo.registry.support.FailbackRegistry, org.apache.dubbo.common.URL], void), removeFailedUnregistered/-884115687=([org.apache.dubbo.registry.support.FailbackRegistry, org.apache.dubbo.common.URL], void)}
; {var2552=org.apache.dubbo.registry.support.FailbackRegistry, var8=r0, var927=org.apache.dubbo.common.URL, var2876=r1, var2519=org.apache.dubbo.registry.support.AbstractRegistry, var2274=java.lang.Exception, var3534=$r2, var3572=$z0}
; {org.apache.dubbo.registry.support.FailbackRegistry=var2552, r0=var8, org.apache.dubbo.common.URL=var927, r1=var2876, org.apache.dubbo.registry.support.AbstractRegistry=var2519, java.lang.Exception=var2274, $r2=var3534, $z0=var3572}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.registry.support.FailbackRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.registry.support.AbstractRegistry: void unregister(org.apache.dubbo.common.URL)>(r1);	specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedRegistered(org.apache.dubbo.common.URL)>(r1);	specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedUnregistered(org.apache.dubbo.common.URL)>(r1);	$r2 := @caughtexception;	$z0 = $r2 instanceof org.apache.dubbo.registry.support.SkipFailbackWrapperException;	if $z0 != 0 goto return;	return
;block_num 3