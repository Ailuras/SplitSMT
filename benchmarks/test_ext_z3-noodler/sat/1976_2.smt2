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

(declare-sort var1724 0)
(declare-sort var1826 0)
(declare-sort var2738 0)
(declare-sort var580 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var1724 String) String)
(declare-fun var2738_isEmpty/-813097145 (String) Bool)
(declare-fun var580_parseBoolean/746105335 (String) Bool)
(declare-const null-var1724 var1724)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var901 var1724) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var901 null-var1724)))
(declare-const var160 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var160 null-String)))
(declare-const var753 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var753 null-Bool)))
(assert true)
(define-const var1437 String (getParameter/356772413 var901 var160)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var783 Bool (var2738_isEmpty/-813097145 var1437)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert (= (ite var783 1 0) 0)) ; Cond: $z0 == 0 
(define-const var471 Bool (var580_parseBoolean/746105335 var1437)) ; Statement: $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
 ; Statement: return $z1 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var2738_isEmpty/-813097145=([java.lang.String], boolean), var580_parseBoolean/746105335=([java.lang.String], boolean)}
; {var1724=org.apache.dubbo.common.Parameters, var901=r0, var160=r1, var1826=null_type, var753=z2, var1437=r2, var2738=org.apache.dubbo.common.utils.StringUtils, var783=$z0, var580=java.lang.Boolean, var471=$z1}
; {org.apache.dubbo.common.Parameters=var1724, r0=var901, r1=var160, null_type=var1826, z2=var753, r2=var1437, org.apache.dubbo.common.utils.StringUtils=var2738, $z0=var783, java.lang.Boolean=var580, $z1=var471}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	z2 := @parameter1: boolean;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	$z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	return $z1
;block_num 2