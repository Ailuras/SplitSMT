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

(declare-sort var3981 0)
(declare-sort var3341 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun loadClass/1140279053 (var3341 String) ClassObject)
(declare-const null-String String)
(declare-const null-var3341 var3341)
(declare-const var1129 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1129 null-String)))
(define-const var2653 var3341 null-var3341) ; Statement: r5 = null 
(assert true)
(define-const var2647 Bool (startsWith/-1785782452 var1129 "org.apache.dubbo")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo") 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var2647 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if r5 != null goto $r1 = virtualinvoke r5.<java.lang.ClassLoader: java.lang.Class loadClass(java.lang.String)>(r0) 
(assert (not (= var2653 null-var3341))) ; Cond: r5 != null 
(assert true)
(define-const var685 ClassObject (loadClass/1140279053 var2653 var1129)) ; Statement: $r1 = virtualinvoke r5.<java.lang.ClassLoader: java.lang.Class loadClass(java.lang.String)>(r0) 
 ; Statement: return $r1 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), loadClass/1140279053=([java.lang.ClassLoader, java.lang.String], java.lang.Class)}
; {var1129=r0, var3981=null_type, var3341=java.lang.ClassLoader, var2653=r5, var2647=$z0, var685=$r1}
; {r0=var1129, null_type=var3981, java.lang.ClassLoader=var3341, r5=var2653, $z0=var2647, $r1=var685}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r5 = null;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo");	if $z0 != 0 goto (branch);	if r5 != null goto $r1 = virtualinvoke r5.<java.lang.ClassLoader: java.lang.Class loadClass(java.lang.String)>(r0);	$r1 = virtualinvoke r5.<java.lang.ClassLoader: java.lang.Class loadClass(java.lang.String)>(r0);	return $r1
;block_num 3