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

(declare-sort var3230 0)
(declare-sort var397 0)
(declare-sort var1400 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3230 var3230)
(declare-const null-var397 var397)
(declare-const null-String String)
(declare-const var592 var3230) ; Statement: r1 := @this: org.apache.dubbo.config.spring.beans.factory.config.DubboConfigDefaultPropertyValueBeanPostProcessor 
(assert (not (= var592 null-var3230)))
(declare-const var1229 var397) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var1229 null-var397)))
(declare-const var1515 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1515 null-String)))
(assert true)
(define-const var3170 Bool (contains/1009244746 var1515 (cast-from-String-to-String "#"))) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("#") 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var3170 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3230=org.apache.dubbo.config.spring.beans.factory.config.DubboConfigDefaultPropertyValueBeanPostProcessor, var592=r1, var397=org.apache.dubbo.config.AbstractConfig, var1229=r2, var1515=r0, var1400=null_type, var3170=$z0}
; {org.apache.dubbo.config.spring.beans.factory.config.DubboConfigDefaultPropertyValueBeanPostProcessor=var3230, r1=var592, org.apache.dubbo.config.AbstractConfig=var397, r2=var1229, r0=var1515, null_type=var1400, $z0=var3170}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.spring.beans.factory.config.DubboConfigDefaultPropertyValueBeanPostProcessor;	r2 := @parameter0: org.apache.dubbo.config.AbstractConfig;	r0 := @parameter1: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("#");	if $z0 != 0 goto return;	return
;block_num 2