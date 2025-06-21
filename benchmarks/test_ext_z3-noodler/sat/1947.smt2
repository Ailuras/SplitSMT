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

(declare-sort var659 0)
(declare-sort var1087 0)
(declare-sort var153 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var659 String) String)
(declare-fun var153_isEmpty/-813097145 (String) Bool)
(declare-const null-var659 var659)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2409 var659) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2409 null-var659)))
(declare-const var1982 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1982 null-String)))
(declare-const var2566 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var2566 null-Bool)))
(assert true)
(define-const var3947 String (getParameter/356772413 var2409 var1982)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1889 Bool (var153_isEmpty/-813097145 var3947)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert (not (= (ite var1889 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return z2 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var153_isEmpty/-813097145=([java.lang.String], boolean)}
; {var659=org.apache.dubbo.common.Parameters, var2409=r0, var1982=r1, var1087=null_type, var2566=z2, var3947=r2, var153=org.apache.dubbo.common.utils.StringUtils, var1889=$z0}
; {org.apache.dubbo.common.Parameters=var659, r0=var2409, r1=var1982, null_type=var1087, z2=var2566, r2=var3947, org.apache.dubbo.common.utils.StringUtils=var153, $z0=var1889}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	z2 := @parameter1: boolean;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	return z2
;block_num 2