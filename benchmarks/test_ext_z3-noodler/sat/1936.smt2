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

(declare-sort var714 0)
(declare-sort var3447 0)
(declare-sort var1655 0)
(declare-sort var104 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var714 String) String)
(declare-fun var1655_isEmpty/-813097145 (String) Bool)
(declare-fun var104_parseBoolean/746105335 (String) Bool)
(declare-const null-var714 var714)
(declare-const null-String String)
(declare-const var1480 var714) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1480 null-var714)))
(declare-const var3458 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3458 null-String)))
(assert true)
(define-const var260 String (getParameter/356772413 var1480 var3458)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1974 Bool (var1655_isEmpty/-813097145 var260)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert (= (ite var1974 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1953 Bool (var104_parseBoolean/746105335 var260)) ; Statement: $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
 ; Statement: return $z1 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var1655_isEmpty/-813097145=([java.lang.String], boolean), var104_parseBoolean/746105335=([java.lang.String], boolean)}
; {var714=org.apache.dubbo.common.Parameters, var1480=r0, var3458=r1, var3447=null_type, var260=r2, var1655=org.apache.dubbo.common.utils.StringUtils, var1974=$z0, var104=java.lang.Boolean, var1953=$z1}
; {org.apache.dubbo.common.Parameters=var714, r0=var1480, r1=var3458, null_type=var3447, r2=var260, org.apache.dubbo.common.utils.StringUtils=var1655, $z0=var1974, java.lang.Boolean=var104, $z1=var1953}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	$z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	return $z1
;block_num 2