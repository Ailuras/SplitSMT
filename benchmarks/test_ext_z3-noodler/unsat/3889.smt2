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

(declare-sort var3140 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-ClassObject ClassObject)
(declare-const null-var3140 var3140)
(declare-const var2948 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2948 null-ClassObject)))
(define-const var152 var3140 null-var3140) ; Statement: r5 = null 
(assert true)
(define-const var3631 String (getName/-1958580599 var2948)) ; Statement: $r1 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3029 Bool (startsWith/-1785782452 var3631 "org.apache.dubbo")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo") 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var3029 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if r5 != null goto return r5 
(assert (not (= var152 null-var3140))) ; Cond: r5 != null 
 ; Statement: return r5 
(check-sat)
; {getName/-1958580599=([java.lang.Class], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2948=r0, var3140=java.lang.ClassLoader, var152=r5, var3631=$r1, var3029=$z0}
; {r0=var2948, java.lang.ClassLoader=var3140, r5=var152, $r1=var3631, $z0=var3029}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r5 = null;	$r1 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("org.apache.dubbo");	if $z0 != 0 goto (branch);	if r5 != null goto return r5;	return r5
;block_num 3