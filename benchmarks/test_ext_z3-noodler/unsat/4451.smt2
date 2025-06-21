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

(declare-sort var3435 0)
(declare-sort var397 0)
(declare-sort var3714 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3714_iterator/-912451715 (var3714) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var3435 var3435)
(declare-const null-ClassObject ClassObject)
(declare-const null-var397 var397)
(declare-const var3435-SERVICE_ANNOTATION_CLASSES var3714)
(declare-const var3165 var3435) ; Statement: r10 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver 
(assert (not (= var3165 null-var3435)))
(declare-const var3611 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var3611 null-ClassObject)))
(define-const var3262 var397 null-var397) ; Statement: r11 = null 
(define-const var3269 var3714 var3435-SERVICE_ANNOTATION_CLASSES) ; Statement: $r0 = <org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.util.List SERVICE_ANNOTATION_CLASSES> 
(define-const var3933 Iterator (var3714_iterator/-912451715 var3269)) ; Statement: r1 = interfaceinvoke $r0.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1642 Bool (Iterator_hasNext/-1669924200 var3933)) ; Statement: $z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var1642 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r11 != null goto return r11 
(assert (not (= var3262 null-var397))) ; Cond: r11 != null 
 ; Statement: return r11 
(check-sat)
; {var3714_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var3435=org.apache.dubbo.common.utils.ServiceAnnotationResolver, var3165=r10, var3611=r5, var397=java.lang.annotation.Annotation, var3262=r11, var3714=java.util.List, var3269=$r0, var3933=r1, var1642=$z0}
; {org.apache.dubbo.common.utils.ServiceAnnotationResolver=var3435, r10=var3165, r5=var3611, java.lang.annotation.Annotation=var397, r11=var3262, java.util.List=var3714, $r0=var3269, r1=var3933, $z0=var1642}
;seq 
;cnt {}
;stmts r10 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver;	r5 := @parameter0: java.lang.Class;	r11 = null;	$r0 = <org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.util.List SERVICE_ANNOTATION_CLASSES>;	r1 = interfaceinvoke $r0.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto (branch);	if r11 != null goto return r11;	return r11
;block_num 4