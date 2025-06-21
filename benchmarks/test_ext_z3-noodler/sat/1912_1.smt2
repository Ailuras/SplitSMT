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

(declare-sort var2767 0)
(declare-sort var2727 0)
(declare-sort var1460 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var2767 String) String)
(declare-fun var1460_isEmpty/-813097145 (String) Bool)
(declare-const null-var2767 var2767)
(declare-const null-String String)
(declare-const var1372 var2767) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1372 null-var2767)))
(declare-const var3188 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3188 null-String)))
(assert true)
(define-const var172 String (getParameter/356772413 var1372 var3188)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1411 Bool (var1460_isEmpty/-813097145 var172)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2) 
(assert (not (= (ite var1411 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var1460_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2767=org.apache.dubbo.common.Parameters, var1372=r0, var3188=r1, var2727=null_type, var172=r2, var1460=org.apache.dubbo.common.utils.StringUtils, var1411=$z0}
; {org.apache.dubbo.common.Parameters=var2767, r0=var1372, r1=var3188, null_type=var2727, r2=var172, org.apache.dubbo.common.utils.StringUtils=var1460, $z0=var1411}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r2);	return 0
;block_num 2