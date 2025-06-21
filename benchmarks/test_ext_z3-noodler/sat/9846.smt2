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

(declare-sort var287 0)
(declare-sort var2426 0)
(declare-sort var2517 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2517_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var287 var287)
(declare-const null-String String)
(declare-const var3301 var287) ; Statement: r2 := @parameter0: org.springframework.beans.factory.support.AbstractBeanDefinition 
(assert (not (= var3301 null-var287)))
(declare-const var2293 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2293 null-String)))
(declare-const var3299 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3299 null-String)))
(define-const var1498 Bool (var2517_isBlank/-523695098 (cast-from-String-to-String var2293))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1498 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {var2517_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var287=org.springframework.beans.factory.support.AbstractBeanDefinition, var3301=r2, var2293=r0, var2426=null_type, var3299=r1, var2517=org.apache.dubbo.common.utils.StringUtils, var1498=$z0}
; {org.springframework.beans.factory.support.AbstractBeanDefinition=var287, r2=var3301, r0=var2293, null_type=var2426, r1=var3299, org.apache.dubbo.common.utils.StringUtils=var2517, $z0=var1498}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @parameter0: org.springframework.beans.factory.support.AbstractBeanDefinition;	r0 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 != 0 goto return;	return
;block_num 2