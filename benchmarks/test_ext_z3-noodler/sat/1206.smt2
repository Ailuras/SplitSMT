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

(declare-sort var1286 0)
(declare-sort var500 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1286 var1286)
(declare-const null-String String)
(declare-const var213 var1286) ; Statement: r1 := @this: org.apache.dubbo.common.bytecode.DubboLoaderClassPath 
(assert (not (= var213 null-var1286)))
(declare-const var2803 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2803 null-String)))
(assert true)
(define-const var2948 Bool (startsWith/-1785782452 var2803 "org.apache.dubbo")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo") 
 ; Statement: if $z0 != 0 goto $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.net.URL find(java.lang.String)>(r0) 
(assert (not (not (= (ite var2948 1 0) 0)))) ; Negate: Cond: $z0 != 0  
 ; Statement: return null 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1286=org.apache.dubbo.common.bytecode.DubboLoaderClassPath, var213=r1, var2803=r0, var500=null_type, var2948=$z0}
; {org.apache.dubbo.common.bytecode.DubboLoaderClassPath=var1286, r1=var213, r0=var2803, null_type=var500, $z0=var2948}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.bytecode.DubboLoaderClassPath;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo");	if $z0 != 0 goto $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.net.URL find(java.lang.String)>(r0);	return null
;block_num 2