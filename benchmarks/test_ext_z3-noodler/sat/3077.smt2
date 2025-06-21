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

(declare-sort var193 0)
(declare-sort var3892 0)
(declare-sort var1473 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1473_isEmpty/-813097145 (String) Bool)
(declare-fun arr-String-init () (Array Int String))
(declare-fun removeParameters/1784102506 (var193 (Array Int String)) var193)
(declare-const null-var193 var193)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2415 var193) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var2415 null-var193)))
(declare-const var164 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var164 null-String)))
(define-const var3675 Bool (var1473_isEmpty/-813097145 var164)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = newarray (java.lang.String)[1] 
(assert (= (ite var3675 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1079 (Array Int String) arr-String-init) ; Statement: $r2 = newarray (java.lang.String)[1] 
(declare-const var1079!1 (Array Int String))
(assert (not (= var1079!1 null-__Array__Int__String__)))
(assert (= (select var1079!1 0) var164)) ; Statement: $r2[0] = r0 
(assert true)
(define-const var299 var193 (removeParameters/1784102506 var2415 var1079!1)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder removeParameters(java.lang.String[])>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var1473_isEmpty/-813097145=([java.lang.String], boolean), arr-String-init=([], java.lang.String[]), removeParameters/1784102506=([org.apache.dubbo.common.URLBuilder, java.lang.String[]], org.apache.dubbo.common.URLBuilder)}
; {var193=org.apache.dubbo.common.URLBuilder, var2415=r1, var164=r0, var3892=null_type, var1473=org.apache.dubbo.common.utils.StringUtils, var3675=$z0, var1079=$r2, var299=$r3}
; {org.apache.dubbo.common.URLBuilder=var193, r1=var2415, r0=var164, null_type=var3892, org.apache.dubbo.common.utils.StringUtils=var1473, $z0=var3675, $r2=var1079, $r3=var299}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = newarray (java.lang.String)[1];	$r2 = newarray (java.lang.String)[1];	$r2[0] = r0;	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder removeParameters(java.lang.String[])>($r2);	return $r3
;block_num 2