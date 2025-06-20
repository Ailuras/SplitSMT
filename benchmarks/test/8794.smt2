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

(declare-sort var1307 0)
(declare-sort var1579 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-const null-var1307 var1307)
(declare-const null-String String)
(declare-const var480 var1307) ; Statement: r3 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder 
(assert (not (= var480 null-var1307)))
(declare-const var1163 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var1163 null-String)))
(assert true)
(define-const var2029 Bool (endsWith/985337093 var1163 ".")) ; Statement: $z0 = virtualinvoke r4.<java.lang.String: boolean endsWith(java.lang.String)>(".") 
 ; Statement: if $z0 != 0 goto return r4 
(assert (not (= (ite var2029 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r4 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean)}
; {var1307=org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder, var480=r3, var1163=r4, var1579=null_type, var2029=$z0}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder=var1307, r3=var480, r4=var1163, null_type=var1579, $z0=var2029}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder;	r4 := @parameter0: java.lang.String;	$z0 = virtualinvoke r4.<java.lang.String: boolean endsWith(java.lang.String)>(".");	if $z0 != 0 goto return r4;	return r4
;block_num 2