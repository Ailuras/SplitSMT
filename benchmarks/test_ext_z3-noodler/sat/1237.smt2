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

(declare-sort var3910 0)
(declare-sort var3292 0)
(declare-sort var3002 0)
(declare-sort var517 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun find/62077257 (var517 String) var3002)
(declare-fun cast-from-var3910-to-var517 (var3910) var517)
(declare-const null-var3910 var3910)
(declare-const null-String String)
(declare-const var158 var3910) ; Statement: r1 := @this: org.apache.dubbo.common.bytecode.DubboLoaderClassPath 
(assert (not (= var158 null-var3910)))
(declare-const var2486 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2486 null-String)))
(assert true)
(define-const var2108 Bool (startsWith/-1785782452 var2486 "org.apache.dubbo")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo") 
 ; Statement: if $z0 != 0 goto $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.net.URL find(java.lang.String)>(r0) 
(assert (not (= (ite var2108 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var647 var3002 (find/62077257 (cast-from-var3910-to-var517 var158) var2486)) ; Statement: $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.net.URL find(java.lang.String)>(r0) 
 ; Statement: return $r2 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), find/62077257=([javassist.LoaderClassPath, java.lang.String], java.net.URL), cast-from-var3910-to-var517=([org.apache.dubbo.common.bytecode.DubboLoaderClassPath], javassist.LoaderClassPath)}
; {var3910=org.apache.dubbo.common.bytecode.DubboLoaderClassPath, var158=r1, var2486=r0, var3292=null_type, var2108=$z0, var3002=java.net.URL, var517=javassist.LoaderClassPath, var647=$r2}
; {org.apache.dubbo.common.bytecode.DubboLoaderClassPath=var3910, r1=var158, r0=var2486, null_type=var3292, $z0=var2108, java.net.URL=var3002, javassist.LoaderClassPath=var517, $r2=var647}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.bytecode.DubboLoaderClassPath;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo");	if $z0 != 0 goto $r2 = specialinvoke r1.<javassist.LoaderClassPath: java.net.URL find(java.lang.String)>(r0);	$r2 = specialinvoke r1.<javassist.LoaderClassPath: java.net.URL find(java.lang.String)>(r0);	return $r2
;block_num 2