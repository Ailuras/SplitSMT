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

(declare-sort var198 0)
(declare-sort var596 0)
(declare-sort var499 0)
(declare-sort var2566 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun openClassfile/-1047117416 (var2566 String) var499)
(declare-fun cast-from-var198-to-var2566 (var198) var2566)
(declare-const null-var198 var198)
(declare-const null-String String)
(declare-const var1635 var198) ; Statement: r1 := @this: org.apache.dubbo.common.bytecode.DubboLoaderClassPath 
(assert (not (= var1635 null-var198)))
(declare-const var701 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var701 null-String)))
(assert true)
(define-const var988 Bool (startsWith/-1785782452 var701 "org.apache.dubbo")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo") 
 ; Statement: if $z0 != 0 goto $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.io.InputStream openClassfile(java.lang.String)>(r0) 
(assert (not (= (ite var988 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var2045 var499 (openClassfile/-1047117416 (cast-from-var198-to-var2566 var1635) var701)) ; Statement: $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.io.InputStream openClassfile(java.lang.String)>(r0) 
 ; Statement: return $r2 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), openClassfile/-1047117416=([javassist.LoaderClassPath, java.lang.String], java.io.InputStream), cast-from-var198-to-var2566=([org.apache.dubbo.common.bytecode.DubboLoaderClassPath], javassist.LoaderClassPath)}
; {var198=org.apache.dubbo.common.bytecode.DubboLoaderClassPath, var1635=r1, var701=r0, var596=null_type, var988=$z0, var499=java.io.InputStream, var2566=javassist.LoaderClassPath, var2045=$r2}
; {org.apache.dubbo.common.bytecode.DubboLoaderClassPath=var198, r1=var1635, r0=var701, null_type=var596, $z0=var988, java.io.InputStream=var499, javassist.LoaderClassPath=var2566, $r2=var2045}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.bytecode.DubboLoaderClassPath;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo");	if $z0 != 0 goto $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.io.InputStream openClassfile(java.lang.String)>(r0);	$r2 = specialinvoke r1.<javassist.LoaderClassPath: java.io.InputStream openClassfile(java.lang.String)>(r0);	return $r2
;block_num 2