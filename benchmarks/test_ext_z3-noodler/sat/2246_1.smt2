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

(declare-sort var3965 0)
(declare-sort var39 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3965 var3965)
(declare-const null-String String)
(declare-const var65 var3965) ; Statement: r1 := @this: org.apache.dubbo.common.compiler.support.CtClassBuilder 
(assert (not (= var65 null-var3965)))
(declare-const var3460 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3460 null-String)))
(assert true)
(define-const var865 Bool (contains/1009244746 var3460 (cast-from-String-to-String "."))) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>(".") 
 ; Statement: if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.common.compiler.support.CtClassBuilder: java.util.Map fullNames> 
(assert (not (= (ite var865 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r0 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3965=org.apache.dubbo.common.compiler.support.CtClassBuilder, var65=r1, var3460=r0, var39=null_type, var865=$z0}
; {org.apache.dubbo.common.compiler.support.CtClassBuilder=var3965, r1=var65, r0=var3460, null_type=var39, $z0=var865}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.compiler.support.CtClassBuilder;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>(".");	if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.common.compiler.support.CtClassBuilder: java.util.Map fullNames>;	return r0
;block_num 2