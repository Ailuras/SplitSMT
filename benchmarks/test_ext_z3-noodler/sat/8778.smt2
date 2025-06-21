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

(declare-sort var2292 0)
(declare-sort var2809 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2292 var2292)
(declare-const null-String String)
(declare-const var728 var2292) ; Statement: r2 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder 
(assert (not (= var728 null-var2292)))
(declare-const var3747 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3747 null-String)))
(declare-const var346 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var346 null-String)))
(assert true)
(define-const var3030 Bool (startsWith/-1785782452 var3747 var346)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2292=org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder, var728=r2, var3747=r0, var2809=null_type, var346=r1, var3030=$z0}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder=var2292, r2=var728, r0=var3747, null_type=var2809, r1=var346, $z0=var3030}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServicePackagesHolder;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>(r1);	return $z0
;block_num 1